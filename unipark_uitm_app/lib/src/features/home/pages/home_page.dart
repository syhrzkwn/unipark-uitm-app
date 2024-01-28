import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:unipark_uitm_app/src/features/home/controllers/home_controller.dart';
import 'package:unipark_uitm_app/src/features/parking/models/parking_model.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: 'location_button',
                  onPressed: () => homeController.currentLocationCamera(),
                  backgroundColor: dark ? darkModeBackground : whiteColor,
                  child: Icon(MingCute.location_2_line,
                      color: dark ? whiteColor : textColor1),
                ),
              ),
            ),
            const Gap(10.0),
            FloatingActionButton.extended(
              heroTag: 'rfid_button',
              onPressed: () {
                Get.to(() => const RFIDPage());
              },
              backgroundColor: dark ? darkModeBackground : whiteColor,
              icon: Icon(
                  Icons.nfc_outlined, size: 20, color: dark ? whiteColor : textColor1),
              label: Text('RFID', style: TextStyle(
                  fontSize: 16, color: dark ? whiteColor : textColor1)),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Obx(() {
        ParkingModel? parkingLocation = homeController.parkingLocation.value;
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            homeController.mapController = controller;
          },
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          trafficEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(3.07018, 101.49955), // Initial position
            zoom: 15,
          ),
          markers: parkingLocation != null ? {
            Marker(
              markerId: MarkerId(parkingLocation.id ?? ''),
              position: LatLng(parkingLocation.parkingLat, parkingLocation.parkingLng),
              icon: homeController.customIcon.value ?? BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: parkingLocation.parkingName,
                snippet: parkingLocation.parkingDesc,
              ),
            ),
          } : {},
        );
      }),
      bottomNavigationBar: Obx(() {
        if(homeController.permissionStatus.value == PermissionStatus.denied) {
          return Container(
            height: 230,
            decoration: BoxDecoration(
              color: dark ? darkModeBackground : whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage(uniparkLogo),
                    height: size.height * 0.04,
                  ),
                  Column(
                    children: [
                      Text('PARKING SPACES',
                          style: TextStyle(fontSize: 18.0,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.bold,
                              color: dark ? whiteColor : blackColor)),
                      const Gap(10.0),
                      const Text('Locate the nearest parking spaces inside\n UiTM Shah Alam', textAlign: TextAlign.center,),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: dark ? darkModeBackground : whiteColor,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                  ),
                                  const Gap(30.0),
                                  Column(
                                    children: [
                                      Image(
                                        image: const AssetImage(locationDenied),
                                        height: size.height * 0.3,
                                      ),
                                      const Gap(10.0),
                                      Text('Enable location services', style: Theme.of(context).textTheme.headlineSmall),
                                      const Gap(20.0),
                                      const Text('This allows us to automatically find parking spaces near you', textAlign: TextAlign.center),
                                      const Gap(20.0),
                                      const Text('Go to Settings and then'),
                                      const Text('1. Go to Location'),
                                      const Text('2. Select UniPark application'),
                                      const Text('3. Tap Always or While Using'),
                                      const Text('4. Close and open the app'),
                                      const Gap(30.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () => AppSettings.openAppSettings(type: AppSettingsType.location),
                                          child: const Text('GO TO SETTINGS'),
                                        ),
                                      ),
                                      const Gap(20.0),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('ENABLE LOCATION'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if(homeController.currentLocation.value == null) {
          Future.delayed(const Duration(seconds: 4));
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          decoration: BoxDecoration(
            color: dark ? darkModeBackground : whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(defaultSize),
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(defaultSize),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: secondaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('NEAREST PARKING  •  ${homeController.parkingLocation
                      .value!.distance}', style: const TextStyle(
                      fontWeight: FontWeight.bold)),
                  Text(homeController.parkingLocation.value!.parkingName,
                      style: TextStyle(fontSize: 18.0,
                          fontFamily: 'Epilogue',
                          fontWeight: FontWeight.bold,
                          color: dark ? whiteColor : blackColor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MingCute.car_3_line,
                          color: dark ? whiteColor : textColor1),
                      const Gap(5.0),
                      Text.rich(
                        TextSpan(text: "Parking Available: ",
                          children: [
                            TextSpan(
                                text: homeController.parkingLocation.value!
                                    .parkingRfidStatus ? "${homeController
                                    .parkingLocation.value!.parkingTotal -
                                    homeController.parkingLocation.value!
                                        .parkingAvailable}" : "not counted",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
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
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                  ),
                                  const Gap(30.0),
                                  Text('Open in', style: Theme
                                      .of(context)
                                      .textTheme
                                      .headlineSmall),
                                  const Gap(10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              homeController.parkingLocation
                                                  .value!.parkingWazeLink));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                              image: const AssetImage(
                                                  wazeApp),
                                              height: size.height * 0.1,
                                            ),
                                            const Text('Waze'),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              homeController.parkingLocation
                                                  .value!.parkingGoogleLink));
                                        },
                                        child: Column(
                                          children: [
                                            Image(
                                              image: const AssetImage(
                                                  googleApp),
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
