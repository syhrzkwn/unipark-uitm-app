import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(3.0725983122436333, 101.49826260475604);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: FloatingActionButton.extended(
          onPressed: () {Get.to(() => const RFIDPage());},
          backgroundColor: dark ? darkModeBackground : whiteColor,
          icon: Icon(Icons.directions_car_filled_outlined, color: dark ? whiteColor : textColor1),
          label: Text('RFID', style: TextStyle(fontSize: 16, color: dark ? whiteColor : textColor1)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('0'),
                position: const LatLng(3.0725983122436333, 101.49826260475604),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                infoWindow: const InfoWindow(
                  title: 'Public Parking, Kompleks Kejuruteraan, UiTM Shah Alam',
                ),
              ),
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 196,
                    padding: const EdgeInsets.all(defaultSize),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: dark ? darkModeBackground : whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('NEAREST PARKING • 250 M', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Public Parking Kompleks Kejuruteraan', style: TextStyle(fontSize: 16, fontFamily: 'Epilogue', fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_car_filled_outlined, color: dark ? whiteColor : textColor1),
                            const Gap(5.0),
                            const Text('Parking Available: 22/100'),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('GO TO PARKING'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
