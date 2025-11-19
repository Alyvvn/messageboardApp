import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String messageText;
  final String userId;
  final String userName;
  final DateTime timestamp;
  final String boardId;

  MessageModel({
    required this.id,
    required this.messageText,
    required this.userId,
    required this.userName,
    required this.timestamp,
    required this.boardId,
  });

  // Create MessageModel 
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      messageText: data['messageText'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? 'Anonymous',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      boardId: data['boardId'] ?? '',
    );
  }

  // Convert MessageModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'messageText': messageText,
      'userId': userId,
      'userName': userName,
      'timestamp': Timestamp.fromDate(timestamp),
      'boardId': boardId,
    };
  }
}

