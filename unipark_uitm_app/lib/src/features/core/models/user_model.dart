import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unipark_uitm_app/src/utils/helpers/formatter.dart';

class UserModel {
  final String id;
  String name;
  int studentId;
  final String email;
  String phone;
  String deviceToken;

  // Constructor
  UserModel({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
    required this.phone,
    required this.deviceToken,
  });

  // Format phone number, example: +6012-3456789
  String get formattedPhoneNo => Formatter.formatPhoneNumber(phone);

  // Static function to create an empty user model
  static UserModel empty() => UserModel(id: '', name: '', studentId: 0, email: '', phone: '', deviceToken: '');

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'student_id': studentId,
      'email': email,
      'phone': formattedPhoneNo,
      'device_token': deviceToken,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['name'] ?? '',
        studentId: data['student_id'] ?? 0,
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        deviceToken: data['device_token'] ?? '',
      );
    }
    return UserModel.empty();
  }
}