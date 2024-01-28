import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unipark_uitm_app/src/features/parking/models/parking_model.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  var currentLocation = Rx<LocationData?>(null);
  var parkingLocation = Rx<ParkingModel?>(null);
  GoogleMapController? mapController;
  Location location = Location();
  List<ParkingModel> listParking = <ParkingModel>[];
  Rx<BitmapDescriptor?> customIcon = Rx<BitmapDescriptor?>(null);
  var permissionStatus = Rx<PermissionStatus>(PermissionStatus.denied);

  @override
  void onInit() {
    super.onInit();
    fetchParkingData();
    loadCustomMarker();
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        permissionStatus.value = granted;
        location.onLocationChanged.listen((locationData) {
          currentLocation.value = locationData;
          parkingLocation.value = _findNearestParkingLocation(locationData);
          updateCameraPosition();
        });
      }
    });
  }

  void fetchParkingData() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      List<ParkingModel> list = <ParkingModel>[];

      FirebaseFirestore.instance
          .collection("Parking")
          .where("parking_status", isEqualTo: true)
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> event) {
        list.clear();
        for (var item in event.docs) {
          ParkingModel parking = ParkingModel(
            id: item.id,
            parkingAddress: item.get('parking_address'),
            parkingName: item.get('parking_name'),
            parkingDesc: item.get('parking_desc'),
            parkingLng: item.get('parking_longitude'),
            parkingLat: item.get('parking_latitude'),
            parkingGoogleLink: item.get('parking_google_link'),
            parkingWazeLink: item.get('parking_waze_link'),
            parkingAvailable: item.get('parking_available'),
            parkingTotal: item.get('parking_total'),
            parkingStatus: item.get('parking_status'),
            parkingRfidStatus: item.get('parking_rfid_status'),
          );
          list.add(parking);
        }
        listParking.assignAll(list);
      });
    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Pi / 180
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p))/2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  ParkingModel? _findNearestParkingLocation(LocationData currentLocation) {
    ParkingModel nearestParking = ParkingModel.empty();
    double minDistance = double.infinity;

    List<ParkingModel> parkingLocation = <ParkingModel>[];
    List<ParkingModel> parkingLocationList = <ParkingModel>[];

    for(var item in listParking) {
      parkingLocation.add(ParkingModel(
        id: item.id,
        parkingAddress: item.parkingAddress,
        parkingName: item.parkingName,
        parkingDesc: item.parkingDesc,
        parkingLng: item.parkingLng,
        parkingLat: item.parkingLat,
        parkingGoogleLink: item.parkingGoogleLink,
        parkingWazeLink: item.parkingWazeLink,
        parkingAvailable: item.parkingAvailable,
        parkingTotal: item.parkingTotal,
        parkingStatus: item.parkingStatus,
        parkingRfidStatus: item.parkingRfidStatus,
      ));
    }
    parkingLocationList.assignAll(parkingLocation);

    for(ParkingModel location in parkingLocationList) {
      double distance = calculateDistance(
        currentLocation.latitude!,
        currentLocation.longitude!,
        location.parkingLat,
        location.parkingLng,
      );

      if(distance < minDistance) {
        minDistance = distance;
        nearestParking = location;

        final m = (minDistance * 1000).round();
        if (m < 1000) {
          nearestParking.distance = '$m M';
        }
        else {
          final km = (m / 1000).toStringAsFixed(1);
          nearestParking.distance = '$km KM';
        }
      }
    }
    return nearestParking;
  }

  void updateCameraPosition() {
    if (parkingLocation.value != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              parkingLocation.value!.parkingLat,
              parkingLocation.value!.parkingLng,
            ),
            zoom: 18.0,
          ),
        ),
      );
    }
  }

  void loadCustomMarker() async {
    customIcon.value = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100.0, 100.0)),
      mapMarker,
    );
  }

  void currentLocationCamera() {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.value!.latitude ?? 0.0, currentLocation.value!.longitude ?? 0.0),
        zoom: 18.0,
      ),
    ));
  }
}
