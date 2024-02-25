import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends GetxController {
  Rx<LatLng?> location1 = Rx<LatLng?>(null);
  Rx<LatLng?> location2 = Rx<LatLng?>(null);
  RxDouble distanceToLocation1 = RxDouble(0.0);
  RxDouble distanceToLocation2 = RxDouble(0.0);
  final LatLng officeLocation =
      const LatLng(28.220835792848256, 83.98573642583638);

  void setLocation1(LatLng? location) {
    location1.value = location;
    if (location != null) {
      calculateDistance(location, 1);
    }
  }

  void setLocation2(LatLng? location) {
    location2.value = location;
    if (location != null) {
      calculateDistance(location, 2);
    }
  }

  void calculateDistance(LatLng location, int number) async {
    double distance = Geolocator.distanceBetween(
      location.latitude,
      location.longitude,
      officeLocation.latitude,
      officeLocation.longitude,
    );
    if (number == 1) {
      distanceToLocation1.value = distance;
    } else {
      distanceToLocation2.value = distance;
    }
  }

  String determineClosestLocation() {
    if (distanceToLocation1.value < distanceToLocation2.value) {
      return 'Location 1 is closer to the office.';
    } else if (distanceToLocation1.value > distanceToLocation2.value) {
      return 'Location 2 is closer to the office.';
    } else {
      return 'Both locations are at the same distance from the office.';
    }
  }
}
