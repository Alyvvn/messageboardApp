import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message to a board
  Future<void> sendMessage({
    required String boardId,
    required String messageText,
    required String userId,
    required String userName,
  }) async {
    try {
      await _firestore.collection('messages').add({
        'boardId': boardId,
        'messageText': messageText,
        'userId': userId,
        'userName': userName,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Send message error: $e');
      rethrow;
    }
  }

  // Get messages for a specific board (real-time stream)
  Stream<List<MessageModel>> getMessages(String boardId) {
    return _firestore
        .collection('messages')
        .where('boardId', isEqualTo: boardId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Handle null timestamp (when message is being sent)
        var data = doc.data();
        if (data['timestamp'] == null) {
          data['timestamp'] = Timestamp.now();
        }
        return MessageModel.fromFirestore(doc);
      }).toList();
    });
  }

  // Get all messages (for admin purposes)
  Future<List<MessageModel>> getAllMessages() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => MessageModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Get all messages error: $e');
      return [];
    }
  }

  // Delete a message
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
    } catch (e) {
      print('Delete message error: $e');
      rethrow;
    }
  }

  // Get message count for a board
  Future<int> getMessageCount(String boardId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('messages')
          .where('boardId', isEqualTo: boardId)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      print('Get message count error: $e');
      return 0;
    }
  }
}

