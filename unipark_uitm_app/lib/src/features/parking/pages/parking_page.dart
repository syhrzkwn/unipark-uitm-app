import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:unipark_uitm_app/src/features/parking/controllers/parking_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/widgets/parking_card.dart';

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parkingController = Get.put(ParkingController());
    final dark = HelperFunction.isDarkMode(context);
    final size = HelperFunction.screenSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ? darkModeBackground : whiteColor,
        title: const Text('Parking Spaces'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SlidingUpPanel(
            minHeight: 90.0,
            maxHeight: size.height - 300.0,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
            header: Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: dark ? darkModeBackground : whiteColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                  const Gap(25.0),
                  Obx(() => Text('${parkingController.listParking.length} parking spaces ', style: const TextStyle(fontWeight: FontWeight.w600))),
                  const Gap(30.0),
                ],
              ),
            ),
            panelBuilder: (scrollController) => _buildSlidingPanel(
              scrollController: scrollController,
              parkingController: parkingController,
              context: context,
            ),
            body: Obx(() {
              if (parkingController.markers.isEmpty) {
                Future.delayed(const Duration(seconds: 4));
                return const Center(child: CircularProgressIndicator());
              }

              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  parkingController.mapController = controller;
                },
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                trafficEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(3.06297, 101.49965), // Initial position
                  zoom: 15,
                ),
                markers: Set<Marker>.of(parkingController.markers),
              );
            }),
          ),
          Positioned(
            right: 15.0,
            top: 15.0,
            child: SizedBox(
              width: 48,
              height: 48,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: 'location_button',
                  onPressed: () => parkingController.currentLocationCamera(),
                  backgroundColor: dark ? darkModeBackground : whiteColor,
                  child: Icon(MingCute.location_2_line, color: dark ? whiteColor : textColor1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSlidingPanel({required ScrollController scrollController, required ParkingController parkingController, required BuildContext context}) {
  final dark = HelperFunction.isDarkMode(context);

  return Obx(() => Container(
    decoration: BoxDecoration(
      color: dark ? darkModeBackground : whiteColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(defaultSize, 90.0, defaultSize, defaultSize),
      controller: scrollController,
      itemCount: parkingController.listParking.length,
      itemBuilder: (context, index) {
        var item = parkingController.listParking[index];
        if(parkingController.listParking.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return WParkingCard(parking: item);
      },
    ),
  ));
}
