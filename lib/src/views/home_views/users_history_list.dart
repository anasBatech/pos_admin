import 'dart:collection';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/models/location_model.dart';
import 'package:pos_admin/src/models/staff_models.dart';
import 'package:pos_admin/src/views/home_views/all_users_list_view.dart';
import 'package:pos_admin/src/views/map_view/map_view.dart';
import 'package:pos_admin/src/views/route_view/live_location_tracking.dart';
import 'package:pos_admin/src/views/route_view/location_history_tracking.dart';
import 'package:pos_admin/src/views/route_view/route_view.dart';
import 'package:pos_admin/src/views/route_view/user_location_timeline_view.dart';
import 'package:pos_admin/src/views/routes/route_names.dart';
import 'package:pos_admin/src/widgets/drawer.dart';

class UserHistorys extends StatefulWidget {
  String userName;
  UserHistorys({super.key, required this.userName});

  @override
  State<UserHistorys> createState() => _UserHistorysState();
}

class _UserHistorysState extends State<UserHistorys> {
  final locationController = Get.find<LocationController>();

  var startDate = DateTime.now().subtract(const Duration(days: 30));
  var endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    locationController.getUserHistory(widget.userName, startDate, endDate);
  }

  List<String> filterList = ["Monthly", "Weekly", "Yearly"];

  var selectedFilter = "Monthly";

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
      locationController.getUserHistory(widget.userName, startDate, endDate);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
      locationController.getUserHistory(widget.userName, startDate, endDate);
    }
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
          const CommonDrawer(),
          Container(
            width: size.width * 0.81,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: 100,
                //     width: size.width * 0.81,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.white,
                //         boxShadow: [
                //           BoxShadow(
                //               blurRadius: 2,
                //               color: Colors.grey.withOpacity(0.2)),
                //         ]),
                //     alignment: Alignment.centerLeft,
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 15),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           SizedBox(
                //             height: 20,
                //           ),
                //           Text(
                //             "Welcome , Admin",
                //             style: TextStyle(
                //                 fontSize: 30, fontWeight: FontWeight.w600),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Text(
                //             "Here is whats Happening",
                //             style:
                //                 TextStyle(fontSize: 13, color: Colors.black45),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<LocationController>(builder: (_) {
                    return locationController.isLoading.isTrue
                        ? Container(
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
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        : Container(
                            height: size.height * 0.9,
                            width: size.width * 0.81,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey.withOpacity(0.2)),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SingleChildScrollView(
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                widget.userName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Start Date",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _selectStartDate(context);
                                                    },
                                                    child: Container(
                                                      height: 33,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .date_range),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                "${formatDate(startDate, [
                                                                  dd,
                                                                  "-",
                                                                  mm,
                                                                  "-",
                                                                  yyyy
                                                                ])}")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "End Date",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _selectEndDate(context);
                                                    },
                                                    child: Container(
                                                      height: 33,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .date_range),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                "${formatDate(endDate, [
                                                                  dd,
                                                                  "-",
                                                                  mm,
                                                                  "-",
                                                                  yyyy
                                                                ])}")
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
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
                                                .userHistory.length;
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
                                                          .userHistory[i]
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
                                                      .userHistory[i].name,
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
                                                          .userHistory[i]
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
                                                          .userHistory[i].isOut
                                                      ? formatDate(
                                                          locationController
                                                              .userHistory[i]
                                                              .outTime,
                                                          [
                                                              hh,
                                                              ":",
                                                              nn,
                                                              " ",
                                                              am
                                                            ])
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
                                                      //               .userHistory[i],
                                                      //       latLng: LatLng(
                                                      //           locationController
                                                      //               .userHistory[
                                                      //                   i]
                                                      //               .inLocation
                                                      //               .first
                                                      //               .latitude,
                                                      //           locationController
                                                      //               .userHistory[
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
                                                      //         .userHistory[
                                                      //             i]
                                                      //         .outLocation
                                                      //         .first
                                                      //         .latitude,
                                                      //     locationController
                                                      //         .userHistory[
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

                                                      Get.offAllNamed(
                                                        RoutesName.USER_TIMELINE, arguments: {
                                                        "startLocation": LatLng(
                                                                locationController
                                                                    .userHistory[
                                                                        i]
                                                                    .inLocation
                                                                    .first
                                                                    .latitude,
                                                                locationController
                                                                    .userHistory[
                                                                        i]
                                                                    .inLocation
                                                                    .first
                                                                    .longitude),
                                                            "username":
                                                                locationController
                                                                    .userHistory[
                                                                        i]
                                                                    .username,
                                                            "dateTime":
                                                                locationController
                                                                    .userHistory[
                                                                        i]
                                                                    .inTime,
                                                      });

                                                      // Get.to(() =>
                                                      //     UserLocationTimeLineView(
                                                      //       startLocation: LatLng(
                                                      //           locationController
                                                      //               .userHistory[
                                                      //                   i]
                                                      //               .inLocation
                                                      //               .first
                                                      //               .latitude,
                                                      //           locationController
                                                      //               .userHistory[
                                                      //                   i]
                                                      //               .inLocation
                                                      //               .first
                                                      //               .longitude),
                                                      //       username:
                                                      //           locationController
                                                      //               .userHistory[
                                                      //                   i]
                                                      //               .username,
                                                      //       dateTime:
                                                      //           locationController
                                                      //               .userHistory[
                                                      //                   i]
                                                      //               .inTime,
                                                      //     ));
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
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3))
                                                          ]),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        "View",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      List<LocationModel>
                                                          listPolys =
                                                          await locationController
                                                              .getLivePolyLine(
                                                                  locationController
                                                                      .userHistory[
                                                                          i]
                                                                      .username,
                                                                  locationController
                                                                      .userHistory[
                                                                          i]
                                                                      .inTime);

                                                      locationController
                                                          .generateExcel(
                                                              listPolys,
                                                              locationController
                                                                  .userHistory[
                                                                      i]
                                                                  .username);
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
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3))
                                                          ]),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        "Export",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
