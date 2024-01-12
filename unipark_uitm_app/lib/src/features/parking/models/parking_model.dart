import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingModel {
  String? id;
  final String parkingAddress;
  final String parkingName;
  final String parkingDesc;
  final double parkingLng;
  final double parkingLat;
  final String parkingGoogleLink;
  final String parkingWazeLink;
  final int parkingAvailable;
  final int parkingTotal;
  final bool parkingStatus;
  final bool parkingRfidStatus;
  String? distance;

  ParkingModel({
    this.id,
    required this.parkingAddress,
    required this.parkingName,
    required this.parkingDesc,
    required this.parkingLng,
    required this.parkingLat,
    required this.parkingGoogleLink,
    required this.parkingWazeLink,
    required this.parkingAvailable,
    required this.parkingTotal,
    required this.parkingStatus,
    required this.parkingRfidStatus,
    this.distance,
  });

  static ParkingModel empty() => ParkingModel(id: '', parkingAddress: '', parkingName: '', parkingDesc: '', parkingLng: 0.0, parkingLat: 0.0, parkingGoogleLink: '', parkingWazeLink: '', parkingAvailable: 0, parkingTotal: 0, parkingStatus: true, parkingRfidStatus: false);

  Map<String, dynamic> toJson() {
    return {
      'parking_address': parkingAddress,
      'parking_name': parkingName,
      'parking_desc': parkingDesc,
      'parking_longitude': parkingLng,
      'parking_latitude': parkingLat,
      'parking_google_link': parkingGoogleLink,
      'parking_waze_link': parkingWazeLink,
      'parking_available': parkingAvailable,
      'parking_total': parkingTotal,
      'parking_status': parkingStatus,
      'parking_rfid_status': parkingRfidStatus,
    };
  }

  factory ParkingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ParkingModel(
        id: document.id,
        parkingAddress: data['parking_address'] ?? '',
        parkingName:  data['parking_name'] ?? '',
        parkingDesc: data['parking_desc'] ?? '',
        parkingLng: data['parking_longitude'] ?? 0.0,
        parkingLat: data['parking_latitude'] ?? 0.0,
        parkingGoogleLink: data['parking_google_link'] ?? '',
        parkingWazeLink: data['parking_waze_link'] ?? '',
        parkingAvailable: data['parking_available'] ?? 0,
        parkingTotal: data['parking_total'] ?? 0,
        parkingStatus: data['parking_status'] ?? true,
        parkingRfidStatus: data['parking_rfid_status'] ?? false,
      );
    } else {
      return ParkingModel.empty();
    }
  }

  factory ParkingModel.fromQueryDocSnapshot(QueryDocumentSnapshot<Object?> document) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      return ParkingModel(
        id: document.id,
        parkingAddress: data['parking_address'] ?? '',
        parkingName:  data['parking_name'] ?? '',
        parkingDesc: data['parking_desc'] ?? '',
        parkingLng: data['parking_longitude'] ?? 0.0,
        parkingLat: data['parking_latitude'] ?? 0.0,
        parkingGoogleLink: data['parking_google_link'] ?? '',
        parkingWazeLink: data['parking_waze_link'] ?? '',
        parkingAvailable: data['parking_available'] ?? 0,
        parkingTotal: data['parking_total'] ?? 0,
        parkingStatus: data['parking_status'] ?? true,
        parkingRfidStatus: data['parking_rfid_status'] ?? false,
      );
    } else {
      return ParkingModel.empty();
    }
  }
}