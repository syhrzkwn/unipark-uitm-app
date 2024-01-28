import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/features/home/controllers/home_controller.dart';
import 'package:unipark_uitm_app/src/features/parking/models/parking_model.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ParkingDetailPage extends StatelessWidget {
   const ParkingDetailPage({
    super.key,
    required this.parking,
  });

  final ParkingModel parking;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share('*${parking.parkingName}* (${parking.parkingStatus ? "Open" : "Close"})'
                  '\n'
                  '\n📍 Address: ${parking.parkingAddress}'
                  '\n🅿️ Parking Available: ${parking.parkingRfidStatus ? parking.parkingTotal - parking.parkingAvailable : "Not Counted"}'
                  '\n🚗 RFID: ${parking.parkingRfidStatus ? "Available" : "Not Available"}'
                  '\n'
                  '\n🔗 Waze: ${parking.parkingWazeLink}'
                  '\n🔗 Google Maps: ${parking.parkingGoogleLink}'
                  '\n'
                  '\nby UniPark@UiTM'
              );
            },
            icon: const Icon(MingCute.share_2_line),
          ),
          const Gap(5.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(parking.parkingName, style: Theme.of(context).textTheme.headlineSmall),
              const Gap(10.0),
              Badge(label: parking.parkingStatus ? const Text('Open') : const Text('Close'), textColor: parking.parkingStatus ? activeGreenText : redColor, backgroundColor: parking.parkingStatus ? activeGreen : redColorBackground),
              const Gap(20.0),
              SizedBox(
                width: 400,
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(parking.parkingLat, parking.parkingLng),
                    zoom: 18,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(parking.id!),
                      position: LatLng(parking.parkingLat, parking.parkingLng),
                      icon: homeController.customIcon.value ?? BitmapDescriptor.defaultMarker,
                      infoWindow: InfoWindow(
                        title: parking.distance,
                        snippet: parking.distance,
                      ),
                    ),
                  },
                ),
              ),
              const Gap(20.0),
              Row(
                children: [
                  Icon(MingCute.map_pin_line, color: dark ? whiteColor : textColor1),
                  const Gap(5.0),
                  Expanded(
                    child: Text(
                      parking.parkingAddress,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const Gap(10.0),
              Row(
                children: [
                  Icon(MingCute.car_3_line, color: dark ? whiteColor : textColor1),
                  const Gap(5.0),
                  Text.rich(
                    TextSpan(text: "Parking Available: ",
                      children: [
                        TextSpan(text: parking.parkingRfidStatus ? "${parking.parkingTotal - parking.parkingAvailable}" : "not counted", style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(10.0),
              Row(
                children: [
                  Icon(Icons.nfc_outlined, color: dark ? whiteColor : textColor1),
                  const Gap(5.0),
                  const Text('RFID: '),
                  Badge(label: parking.parkingRfidStatus ? const Text('Available') : const Text('Not Available'), textColor: parking.parkingRfidStatus ? activeGreenText : redColor, backgroundColor: parking.parkingRfidStatus ? activeGreen : redColorBackground),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultSize),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: dark ? darkModeBackground : whiteColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                        const Gap(30.0),
                        Text('Open in', style: Theme.of(context).textTheme.headlineSmall),
                        const Gap(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(parking.parkingWazeLink));
                              },
                              child: Column(
                                children: [
                                  Image(
                                    image: const AssetImage(wazeApp),
                                    height: size.height * 0.1,
                                  ),
                                  const Text('Waze'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(parking.parkingGoogleLink));
                              },
                              child: Column(
                                children: [
                                  Image(
                                    image: const AssetImage(googleApp),
                                    height: size.height * 0.1,
                                  ),
                                  const Text('Google Maps'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(20.0),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text('GO TO PARKING'),
          ),
        ),
      ),
    );
  }
}
