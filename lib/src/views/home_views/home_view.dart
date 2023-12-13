import 'dart:collection';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/views/home_views/all_users_list_view.dart';
import 'package:pos_admin/src/views/map_view/map_view.dart';
import 'package:pos_admin/src/views/route_view/live_location_tracking.dart';
import 'package:pos_admin/src/views/route_view/route_view.dart';
import 'package:pos_admin/src/widgets/drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    locationController.getTodays();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   title: Text("Home"),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15),
      //       child: IconButton(
      //           onPressed: () {
      //             Get.to(MapViews());
      //           },
      //           icon: const Icon(Icons.map)),
      //     )
      //   ],
      // ),
      body: Row(
        children: [
          CommonDrawer(),
          Container(
            width: size.width * 0.81,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: size.width * 0.81,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.withOpacity(0.2)),
                        ]),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Welcome , Admin",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: locationController.getAsStream(DateTime.now()),
                      builder: (context, snapshot) {
                        locationController.getTodays();
                        return GetBuilder<LocationController>(builder: (_) {
                          return Container(
                            height: 500,
                            width: size.width * 0.81,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey.withOpacity(0.2)),
                                ]),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              "Users daily track",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 40,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: const Text(
                                            "Date",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: const Text(
                                            "Username",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: const Text(
                                            "In Time",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: const Text(
                                            "Out Time",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: const Text(
                                            "Actions",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  for (int i = 0;
                                      i <
                                          locationController
                                              .attandaceEmpList.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 20, bottom: 10),
                                      child: Container(
                                        height: 42,
                                        decoration: BoxDecoration(
                                            color: i.isEven
                                                ? const Color.fromARGB(
                                                    255, 214, 214, 214)
                                                : const Color.fromARGB(
                                                    255, 238, 237, 237),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                formatDate(
                                                    locationController
                                                        .attandaceEmpList[i]
                                                        .inTime,
                                                    [dd, "-", mm, "-", yyyy]),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                locationController
                                                    .attandaceEmpList[i].name,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                formatDate(
                                                    locationController
                                                        .attandaceEmpList[i]
                                                        .inTime,
                                                    [hh, ":", nn, " ", am]),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                locationController
                                                        .attandaceEmpList[i]
                                                        .isOut
                                                    ? formatDate(
                                                        locationController
                                                            .attandaceEmpList[i]
                                                            .outTime,
                                                        [hh, ":", nn, " ", am])
                                                    : "",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Row(children: [
                                                InkWell(
                                                  onTap: () {
                                                    // Get.to(() => MapViews(
                                                    //       employeeModel:
                                                    //           locationController
                                                    //               .attandaceEmpList[i],
                                                    //       latLng: LatLng(
                                                    //           locationController
                                                    //               .attandaceEmpList[
                                                    //                   i]
                                                    //               .inLocation
                                                    //               .first
                                                    //               .latitude,
                                                    //           locationController
                                                    //               .attandaceEmpList[
                                                    //                   i]
                                                    //               .inLocation
                                                    //               .first
                                                    //               .longitude),
                                                    //     ));

                                                    // Get.to(() =>
                                                    //     RouteViewStatic(
                                                    //       startCoordinate:
                                                    //           LatLng(13.1013,
                                                    //               80.2330),
                                                    // endCoordinate: LatLng(
                                                    //     locationController
                                                    //         .attandaceEmpList[
                                                    //             i]
                                                    //         .outLocation
                                                    //         .first
                                                    //         .latitude,
                                                    //     locationController
                                                    //         .attandaceEmpList[
                                                    //             i]
                                                    //         .outLocation
                                                    //         .first
                                                    //         .longitude),
                                                    //       webGoogleMapsApiKey:
                                                    //           "AIzaSyAW5KzcgfymV6SmIEG8xzIpgCMS6vb0D1s",
                                                    //       destinationAddress:
                                                    //           "start",
                                                    //       lineColor: Colors.red,
                                                    //       startAddress: "end",
                                                    //     ));

                                                    Get.to(() =>
                                                        LiveLocationTracking(
                                                          startLocation: LatLng(
                                                              locationController
                                                                  .attandaceEmpList[
                                                                      i]
                                                                  .inLocation
                                                                  .first
                                                                  .latitude,
                                                              locationController
                                                                  .attandaceEmpList[
                                                                      i]
                                                                  .inLocation
                                                                  .first
                                                                  .longitude),
                                                          username:
                                                              locationController
                                                                  .attandaceEmpList[
                                                                      i]
                                                                  .username,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: 70,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3))
                                                        ]),
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "View",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        });
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
