import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime registrationDateTime;
  final String? dateOfBirth;
  final String? displayName;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.registrationDateTime,
    this.dateOfBirth,
    this.displayName,
  });

  // Create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      role: data['role'] ?? 'user',
      registrationDateTime: (data['registrationDateTime'] as Timestamp).toDate(),
      dateOfBirth: data['dateOfBirth'],
      displayName: data['displayName'],
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'registrationDateTime': Timestamp.fromDate(registrationDateTime),
      'dateOfBirth': dateOfBirth,
      'displayName': displayName ?? '$firstName $lastName',
    };
  }

  // Get full name
  String get fullName => displayName ?? '$firstName $lastName';
}

