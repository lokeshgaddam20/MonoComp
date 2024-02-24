import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Chatbot> {
  ChatUser me = ChatUser(id: '12345', firstName: 'Me');
  ChatUser bot = ChatUser(id: '6789', firstName: 'Bot');
  List<ChatMessage> msgs = <ChatMessage>[];

  final myuri =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBrH1dm2NKIripbUa9f8as-eApsfDIoOhg';

  final header = {
    'Content-Type': 'application/json',
  };

  getMessages(ChatMessage m) async {
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
    await http
        .post(Uri.parse(myuri), headers: header, body: jsonEncode(body))
        .then((value) => {
              if (value.statusCode == 200) {
                var data = jsonDecode(value.body);
                print(data['candidates'][0]['contents']['parts'][0]['text']);

                ChatMessage msg = ChatMessage(user: bot, createdAt: DateTime.now(), text: data['candidates'][0]['contents']['parts'][0]['text']);
                msgs.insert(0, msg);
                setState(() {}))
              }
              else{
                print("err occured")
              }
        })
        .catchError((e)=>{});
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DashChat(
      currentUser: me,
      onSend: (ChatMessage message) {
        getMessages(message);
      },
      messages: msgs,
    ));
  }
}
