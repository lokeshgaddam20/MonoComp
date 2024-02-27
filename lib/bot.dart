import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      _firestore.collection('chats_${widget.geminiAi.id}').add({
        'text': m.text,
        'createdAt': DateTime.now(),
        'userId': me.id,
        'userName': me.firstName,
        'userAvatar': me.profileImage,
      });
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
        _firestore.collection('chats_${widget.geminiAi.id}').add({
          'text': msg.text,
          'createdAt': DateTime.now(),
          'userId': bot.id,
          'userName': bot.firstName,
          'userAvatar': bot.profileImage,
        });
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
      body: StreamBuilder(
        stream: _firestore
            .collection('chats_${widget.geminiAi.id}')
            .orderBy('createdAt',
                descending: true) // Order messages by timestamp
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //   // If no data is available, display a message indicating no messages
          //   return const Center(
          //     child: Text('No messages available'),
          //   );
          // }
          else {
            final messages = snapshot.data!.docs;
            List<ChatMessage> chatMessages = [];
            for (var message in messages) {
              final text = message['text'];
              final userId = message['userId'];
              final userName = message['userName'];
              final userAvatar = message['userAvatar'];

              final chatMessage = ChatMessage(
                text: text,
                user: ChatUser(
                  id: userId,
                  firstName: userName,
                  profileImage: userAvatar,
                ),
                createdAt: message['createdAt'].toDate(),
              );
              chatMessages.add(chatMessage);
            }
            return DashChat(
              typingUsers: typing,
              currentUser: me,
              onSend: (ChatMessage m) {
                getMessages(m);
              },
              messages: chatMessages,
              inputOptions: const InputOptions(
                alwaysShowSend: true,
                inputDisabled: false,
                autocorrect: true,
              ),
              messageOptions: MessageOptions(
                currentUserContainerColor: Colors.black,
                avatarBuilder: (ChatUser user, Function? onAvatarTap,
                    Function? onLongPress) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: NetworkImage(widget.geminiAi.avatarUrl),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
