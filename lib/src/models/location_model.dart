import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  DateTime date;
  LatLng latLang;
  bool isInvoiced;

  LocationModel(
      {required this.date, required this.latLang, this.isInvoiced = false});
}
