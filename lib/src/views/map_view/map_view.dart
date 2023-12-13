import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/models/staff_models.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class MapViews extends StatefulWidget {
  LatLng latLng;
  EmployeeModel employeeModel;
  MapViews({super.key, required this.latLng, required this.employeeModel});

  @override
  State<MapViews> createState() => _MapViewsState();
}

class _MapViewsState extends State<MapViews> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(13.0569, 80.2425),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Map<String, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _addMarker(
        "${widget.employeeModel.name}\nIn Time",
        "${widget.employeeModel.name}\nOut Time",
        widget.latLng,
        LatLng(widget.employeeModel.outLocation.first.latitude,
            widget.employeeModel.outLocation.first.longitude));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Map View"),
      ),
      body: Center(
        child: Container(
          height: size.height * 0.8,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.values.toSet(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  _addMarker(String id, String id2, LatLng position, LatLng position2) async {
    var marker = Marker(markerId: MarkerId(id), position: position);
    var marker2 = Marker(markerId: MarkerId(id2), position: position2);

    markers[id] = marker;
    markers[id2] = marker2;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: position,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
    setState(() {});
  }
}
