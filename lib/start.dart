import 'package:flutter/material.dart';
import 'package:geminiai/auth/auth_provider.dart';
import 'package:geminiai/bot.dart';
// import 'package:geminiai/services/chat_service.dart';

List<GeminiAI> geminiAiList = [
  GeminiAI(
    name: 'Apple',
    id: '1',
    avatarUrl:
        'https://cdn3.iconfinder.com/data/icons/picons-social/57/56-apple-512.png',
  ),
  GeminiAI(
    name: 'Google',
    id: '2',
    avatarUrl:
        'https://cdn0.iconfinder.com/data/icons/social-network-7/50/2-256.png',
  ),
  GeminiAI(
    name: 'Microsoft',
    id: '3',
    avatarUrl:
        'https://cdn2.iconfinder.com/data/icons/social-icons-circular-color/512/windows-256.png',
  ),
];

void logout() {
  final _auth = AuthService();
  _auth.signOut();
}

// void showProfileMenu(BuildContext context, String userName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(userName),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 logout();
//                 Navigator.pop(context);
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  // final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gemini AI',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: const [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: geminiAiList.length,
        // separatorBuilder: (context, index) =>
        //     const Divider(), // Add divider between items
        itemBuilder: (context, index) {
          final geminiAi = geminiAiList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chatbot(geminiAi: geminiAi),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32, // Set avatar size
                    backgroundImage: NetworkImage(geminiAi.avatarUrl),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      geminiAi.name,
                      style: const TextStyle(
                        fontSize: 18, // Set font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
