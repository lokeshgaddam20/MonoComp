import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Chatbot> {
  ChatUser me = ChatUser(id: '12345', firstName: 'Me');
  ChatUser bot = ChatUser(id: '6789', firstName: 'Bot');
  List<ChatMessage> msgs = <ChatMessage>[];

  getMessages(ChatMessage m) {
    msgs.insert(0, m);
    setState(() {});
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
