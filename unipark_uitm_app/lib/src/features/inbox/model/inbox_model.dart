import 'package:cloud_firestore/cloud_firestore.dart';

class InboxModel {
  String? id;
  String? inboxTitle;
  String? inboxBody;
  String inboxDate;

  // Constructor
  InboxModel({
    this.id,
    this.inboxTitle,
    this.inboxBody,
    required this.inboxDate,
  });

  // Static function to create an empty rfid model
  static InboxModel empty() => InboxModel(
    inboxTitle: '',
    inboxBody: '',
    inboxDate: '',
  );

  // Convert model to JSON structure for storing data in Firebase
  toJson() {
    return {
      'inbox_title': inboxTitle,
      'inbox_body': inboxBody,
      'inbox_date': inboxDate,
    };
  }

  factory InboxModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return InboxModel(
        id: document.id,
        inboxTitle: data['inbox_title'] ?? '',
        inboxBody: data['inbox_body'] ?? '',
        inboxDate: data['inbox_date'] ?? '',
      );
    } else {
      return InboxModel.empty();
    }
  }

  // Factory method to create a VehicleModel from a Firebase document snapshot
  factory InboxModel.fromQueryDocSnapshot(QueryDocumentSnapshot<Object?> document) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      return InboxModel(
        id: document.id,
        inboxTitle: data['inbox_title'] ?? '',
        inboxBody: data['inbox_body'] ?? '',
        inboxDate: data['inbox_date'] ?? '',
      );
    } else {
      return InboxModel.empty();
    }
  }
}