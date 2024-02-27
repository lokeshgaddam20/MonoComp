import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeminiAI {
  final String name;
  final String id;
  final String avatarUrl; // URL to the avatar image

  GeminiAI({
    required this.name,
    required this.id,
    required this.avatarUrl,
  });
}

class Chatbot extends StatefulWidget {
  final GeminiAI geminiAi;

  const Chatbot({super.key, required this.geminiAi});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late ChatUser me; // Make 'me' variable late to initialize later
  late ChatUser bot;
  List<ChatMessage> msgs = [];
  List<ChatUser> typing = [];

  @override
  void initState() {
    super.initState();
    // Initialize 'me' user
    me = ChatUser(id: '12345', firstName: 'Me');
    // Initialize 'bot' user with the provided GeminiAI data
    bot = ChatUser(
      id: '67890',
      firstName: widget.geminiAi.name,
      profileImage: widget.geminiAi.avatarUrl,
    );
  }

  final myuri =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBrH1dm2NKIripbUa9f8as-eApsfDIoOhg';

  final header = {
    'Content-Type': 'application/json',
  };

  getMessages(ChatMessage m) async {
    try {
      typing.add(bot);
      msgs.insert(0, m);
      setState(() {});
      var body = {
        "contents": [
          {
            "parts": [
              {"text": m.text}
            ]
          }
        ]
      };
      final response = await http.post(Uri.parse(myuri),
          headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage msg = ChatMessage(
            user: bot,
            createdAt: DateTime.now(),
            text: data['candidates'][0]['content']['parts'][0]['text']);
        msgs.insert(0, msg);
        setState(() {});
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    } finally {
      typing.remove(bot);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              backgroundImage: NetworkImage(widget.geminiAi.avatarUrl),
            ),
            const SizedBox(width: 12),
            Text(widget.geminiAi.name),
          ],
        ),
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: me,
        onSend: (ChatMessage m) {
          getMessages(m);
        },
        messages: msgs,
        inputOptions: const InputOptions(
          alwaysShowSend: true,
          inputDisabled: false,
          autocorrect: true,
        ),
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.black,
          avatarBuilder:
              (ChatUser user, Function? onAvatarTap, Function? onLongPress) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(widget.geminiAi.avatarUrl),
            );
          },
        ),
      ),
    );
  }
}
