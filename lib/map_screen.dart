import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_integration/map_controller.dart';

class MapScreen extends StatelessWidget {
  final MapController c = Get.put(MapController());
  MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(28.220835792848256, 83.98573642583638),
                  zoom: 15,
                ),
                markers: buildMarkers(),
                onTap: (LatLng latLng) {
                  if (c.location1.value == null) {
                    c.setLocation1(latLng);
                  } else {
                    c.setLocation2(latLng);
                  }
                },
              ),
            ),
          ),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (c.location1.value != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Distance to Office from Location 1: ${c.distanceToLocation1.value.toStringAsFixed(2)} meters',
                    ),
                  ),
                if (c.location2.value != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Distance to Office from Location 2: ${c.distanceToLocation2.value.toStringAsFixed(2)} meters',
                    ),
                  ),
                if (c.location1.value != null && c.location2.value != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(c.determineClosestLocation()),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Set<Marker> buildMarkers() {
    Set<Marker> markers = {};
    if (c.location1.value != null) {
      markers.add(Marker(
        markerId: const MarkerId('Location 1'),
        position: c.location1.value!,
      ));
    }
    if (c.location2.value != null) {
      markers.add(Marker(
        markerId: const MarkerId('Location 2'),
        position: c.location2.value!,
      ));
    }
    markers.add(const Marker(
      markerId: MarkerId('Office'),
      position: LatLng(28.220835792848256, 83.98573642583638),
    ));
    return markers;
  }
}
