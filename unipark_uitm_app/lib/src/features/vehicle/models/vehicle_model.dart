import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  String? id;
  String brand;
  String colour;
  String model;
  String ownerName;
  String plateNumber;
  bool rfid;

  // Constructor
  VehicleModel({
    this.id,
    required this.brand,
    required this.colour,
    required this.model,
    required this.ownerName,
    required this.plateNumber,
    required this.rfid,
  });

  // Static function to create an empty vehicle model
  static VehicleModel empty() => VehicleModel(id: '', brand: '', colour: '', model: '', ownerName: '', plateNumber: '', rfid: false);

  // Convert model to JSON structure for storing data in Firebase
  toJson() {
    return {
      'brand': brand,
      'colour': colour,
      'model': model,
      'owner_name': ownerName,
      'plate_number': plateNumber,
      'rfid': rfid,
    };
  }

  // Factory method to create a VehicleModel from a Firebase document snapshot
  factory VehicleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return VehicleModel(
        id: document.id,
        brand: data['brand'] ?? '',
        colour: data['colour'] ?? '',
        model: data['model'] ?? '',
        ownerName: data['owner_name'] ?? '',
        plateNumber: data['plate_number'] ?? '',
        rfid: data['rfid'] ?? false,
      );
    } else {
      return VehicleModel.empty();
    }
  }

  // Factory method to create a VehicleModel from a Firebase document snapshot
  factory VehicleModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      return VehicleModel(
        id: document.id,
        brand: data['brand'] ?? '',
        colour: data['colour'] ?? '',
        model: data['model'] ?? '',
        ownerName: data['owner_name'] ?? '',
        plateNumber: data['plate_number'] ?? '',
        rfid: data['rfid'] ?? false,
      );
    } else {
      return VehicleModel.empty();
    }
  }
}