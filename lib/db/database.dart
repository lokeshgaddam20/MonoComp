import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomMap) async {
    try {
      return await _firestore
          .collection("chatRoom")
          .doc(chatRoomId)
          .set(chatRoomMap);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
