import 'package:cloud_firestore/cloud_firestore.dart';

class RfidModel {
  String id;
  String? userId;
  String ownerName;
  bool parkingEntered;
  String plateNumber;
  String rfidTagId;
  bool rfidStatus;
  String rfidRegisteredDate;
  String rfidExpiredDate;
  String vehicleBrand;
  String vehicleModel;
  String vehicleYear;

  // Constructor
  RfidModel({
    required this.id,
    required this.userId,
    required this.ownerName,
    required this.parkingEntered,
    required this.plateNumber,
    required this.rfidTagId,
    required this.rfidStatus,
    required this.rfidRegisteredDate,
    required this.rfidExpiredDate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleYear,
  });

  // Static function to create an empty rfid model
  static RfidModel empty() => RfidModel(
    id: '',
    userId: '',
    ownerName: '',
    parkingEntered: false,
    plateNumber: '',
    rfidTagId: '',
    rfidStatus: true,
    rfidRegisteredDate: '',
    rfidExpiredDate: '',
    vehicleBrand: '',
    vehicleModel: '',
    vehicleYear: '',
  );

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'owner_name': ownerName,
      'parking_entered': parkingEntered,
      'plate_number': plateNumber,
      'rfid_tag_id': rfidTagId,
      'rfid_status': rfidStatus,
      'rfid_registered_date': rfidRegisteredDate,
      'rfid_expired_date': rfidExpiredDate,
      'vehicle_brand': vehicleBrand,
      'vehicle_model': vehicleModel,
      'vehicle_year': vehicleYear,
    };
  }

  factory RfidModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return RfidModel(
        id: document.id,
        userId: data['user_id'] ?? '',
        ownerName: data['owner_name'] ?? '',
        parkingEntered: data['parking_entered'] ?? false,
        plateNumber: data['plate_number'] ?? '',
        rfidTagId: data['rfid_tag_id'] ?? '',
        rfidStatus: data['rfid_status'] ?? true,
        rfidRegisteredDate: data['rfid_registered_date'] ?? '',
        rfidExpiredDate: data['rfid_expired_date'] ?? '',
        vehicleBrand: data['vehicle_brand'] ?? '',
        vehicleModel: data['vehicle_model'] ?? '',
        vehicleYear: data['vehicle_year'] ?? '',
      );
    } else {
      return RfidModel.empty();
    }
  }

  // Factory method to create a VehicleModel from a Firebase document snapshot
  factory RfidModel.fromQueryDocSnapshot(QueryDocumentSnapshot<Object?> document) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      return RfidModel(
        id: document.id,
        userId: data['user_id'] ?? '',
        ownerName: data['owner_name'] ?? '',
        parkingEntered: data['parking_entered'] ?? false,
        plateNumber: data['plate_number'] ?? '',
        rfidTagId: data['rfid_tag_id'] ?? '',
        rfidStatus: data['rfid_status'] ?? true,
        rfidRegisteredDate: data['rfid_registered_date'] ?? '',
        rfidExpiredDate: data['rfid_expired_date'] ?? '',
        vehicleBrand: data['vehicle_brand'] ?? '',
        vehicleModel: data['vehicle_model'] ?? '',
        vehicleYear: data['vehicle_year'] ?? '',
      );
    } else {
      return RfidModel.empty();
    }
  }
}