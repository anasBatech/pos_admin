import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/models/location_model.dart';

// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
const double CAMERA_ZOOM = 12;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class LiveLocationTracking extends StatefulWidget {
  LatLng startLocation;
  String username;
  LiveLocationTracking(
      {super.key, required this.startLocation, required this.username});

  @override
  State<LiveLocationTracking> createState() => _LiveLocationTrackingState();
}

class _LiveLocationTrackingState extends State<LiveLocationTracking> {
  Completer<GoogleMapController> _controller = Completer();

  final locationController = Get.find<LocationController>();
// this set will hold my markers

// this will hold each polyline coordinate as Lat and Lng pairs
  List<LocationModel> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDergFiQQSAtleFHO8tkKGj2ox1oYRIFsI";

  @override
  void initState() {
    super.initState();
    setInitialPolyLines();
    setLoading();
  }

  setInitialPolyLines() async {
    List<LocationModel> listPolys = await locationController.getLivePolyLine(
        widget.username, DateTime.now());
    locationController.generateListOfLocationNames(listPolys);
    setPolylinesFirst(listPolys);
  }

  setLoading() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      locationController.isNameLoading(true);
      locationController.update();
      await Future.delayed(const Duration(seconds: 4));
      locationController.isNameLoading(false);
      locationController.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: widget.startLocation);
    return Scaffold(
      body: StreamBuilder(
          stream: Get.find<LocationController>()
              .getLiveLocation(widget.username, DateTime.now()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            } else {
              LatLng latLng = LatLng(
                  snapshot.data!["latitude"], snapshot.data!["longitude"]);
              LocationModel locationModel = LocationModel(
                  date: snapshot.data!.data()!.containsKey("createdAt")
                      ? DateTime.parse(snapshot.data!["createdAt"])
                      : DateTime.now(),
                  latLang: latLng);

              getLiveLocationUpdate(locationModel);
              setInvoiceLocations();
              return GetBuilder<LocationController>(builder: (_) {
                return Row(
                  children: [
                    Container(
                      height: size.height,
                      width: size.width * 0.2,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SingleChildScrollView(
                        child: locationController.isNameLoading.isTrue
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      "Location Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Distance",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${locationController.totalDistanceTraveled.value.toStringAsFixed(1)} KM",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 15),
                                    child: Text(
                                      "Places Traveled",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int i = 0;
                                      i <
                                          locationController
                                              .locationNames.length;
                                      i++)
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    color: primaryColor,
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      child: Text(
                                                        locationController
                                                            .locationNames[i]
                                                            .locationName,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                      )),
                                                  if (locationController
                                                          .locationNames[i]
                                                          .createdAt
                                                          .year !=
                                                      1000)
                                                    Container(
                                                      width: 70,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            formatDate(
                                                                locationController
                                                                    .locationNames[i]
                                                                    .createdAt,
                                                                [
                                                                  dd,
                                                                  "-",
                                                                  mm,
                                                                  "-",
                                                                  yyyy
                                                                ]),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          Text(
                                                            formatDate(
                                                                locationController
                                                                    .locationNames[i]
                                                                    .createdAt,
                                                                [
                                                                  hh,
                                                                  ":",
                                                                  nn,
                                                                  " ",
                                                                  am
                                                                ]),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: const [
                                                Text(".\n.\n"),
                                                Icon(Icons
                                                    .keyboard_arrow_down_rounded)
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            )
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       Container(
                                        //         width: 160,
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Container(
                                        //                 width: 170,
                                        //                 child: Text(
                                        //                   "Nungambakkam",
                                        //                   maxLines: 1,
                                        //                   overflow: TextOverflow.visible,
                                        //                 )),
                                        //             SizedBox(
                                        //               height: 3,
                                        //             ),
                                        //             Divider(
                                        //               thickness: 1.5,
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       const SizedBox(
                                        //         height: 17,
                                        //       ),
                                        //       Container(
                                        //         width: 160,
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: const [
                                        //             Text("Perambur"),
                                        //             SizedBox(
                                        //               height: 3,
                                        //             ),
                                        //             Divider(
                                        //               thickness: 1.5,
                                        //             )
                                        //           ],
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                ],
                              ),
                      ),
                    ),
                    GetBuilder<LocationController>(builder: (_) {
                      return Container(
                        height: size.height,
                        width: size.width * 0.8,
                        child: GoogleMap(
                            myLocationEnabled: true,
                            compassEnabled: true,
                            tiltGesturesEnabled: false,
                            markers: locationController.markers.values.toSet(),
                            polylines: locationController.polylines,
                            mapType: MapType.normal,
                            initialCameraPosition: initialLocation,
                            onMapCreated: onMapCreated),
                      );
                    }),
                  ],
                );
              });
            }
          }),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins(widget.startLocation);
    // setPolylines(widget.startLocation);
    setInvoiceLocations();
    setInitialPolyLines();
  }

  setInvoiceLocations() async {
    var data = await rootBundle.load('icons/invoice_icon.png');
    final Uint8List imgicon = data.buffer.asUint8List();
    List<LocationModel> listPolys = await locationController.getLiveInvoices(
        widget.username, DateTime.now());

    for (var i = 0; i < listPolys.length; i++) {
      locationController.markers["inv$i"] = Marker(
        markerId: MarkerId("inv$i"),
        infoWindow: const InfoWindow(snippet: "Here i took a invoice"),
        position: listPolys[i].latLang,
        icon: BitmapDescriptor.fromBytes(imgicon, size: const Size(50, 50)),
      );
    }
  }

  setDeFaults() async {}

  void setMapPins(LatLng currentMark) {
    locationController.markers["In"] = Marker(
      markerId: MarkerId("In"),
      position: widget.startLocation,
    );

    locationController.markers["live"] = Marker(
      markerId: const MarkerId("live"),
      position: currentMark,
    );
    locationController.update();
  }

  getLiveLocationUpdate(LocationModel currentMark) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (mounted) {
        setPolylines(currentMark);
        setMapPins(currentMark.latLang);
      }
    });
  }

  setPolylines(LocationModel location) async {
    polylineCoordinates.add(location);
    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs
    List<LatLng> tpoints = [];

    polylineCoordinates.forEach((element) {
      tpoints.add(element.latLang);
    });

    Polyline polyline = Polyline(
        polylineId: const PolylineId("Traveled path"),
        color: const Color.fromARGB(255, 40, 122, 198),
        points: tpoints);
    print(
        "------------------------------------------------------------?>setpolyline normal");
    // add the constructed polyline as a set of points
    // to the polyline set, which will eventually
    // end up showing up on the map
    locationController.calculateDistane(polylineCoordinates);
    locationController.generateListOfLocationNames(polylineCoordinates);
    locationController.polylines.add(polyline);
    setMapPins(location.latLang);
    locationController.update();
  }

  setPolylinesFirst(List<LocationModel> temppolylineCoordinates) async {
    locationController.polylines.clear();
    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs

    List<LatLng> tpoints = [];
    temppolylineCoordinates.forEach((element) {
      tpoints.add(element.latLang);
    });

    Polyline polyline = Polyline(
        polylineId: const PolylineId("Traveled path"),
        color: const Color.fromARGB(255, 40, 122, 198),
        points: tpoints);
    print(
        "-----------------------------II----------------------------> setPoly second");
    // add the constructed polyline as a set of points
    // to the polyline set, which will eventually
    // end up showing up on the map
    locationController.calculateDistane(temppolylineCoordinates);
    locationController.polylines.add(polyline);
    await Future.delayed(Duration(seconds: 1));
    locationController.update();
    // locationController.calculateDistane(temppolylineCoordinates);
  }
}
