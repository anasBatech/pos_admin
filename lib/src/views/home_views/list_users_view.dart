import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/const/app_font.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/models/location_model.dart';
import 'package:pos_admin/src/views/routes/route_names.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final locationController = Get.find<LocationController>();

  String dropdownvalue = 'Apple';

  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];
  var searchController = TextEditingController();
   var searchController2 = TextEditingController();
   List customernames = [
    'Jane cooper',
    'Floyd Milies',
    'karthic',
    'JayaSeelan',
    'Venkat',
    'Prakash',
    'Kristin Watson'
   ];
    List companynames = [
    'Microsoft',
    'Yahoo',
    'Adabe',
    'Tesia',
    'Google',
    'Facebook',
    'Microsoft'
   ];
     List phonenumber = [
    '1234567890',
    '3456789012',
    '0987654333',
    '0987654323',
    '4567888321',
    '6789005433',
    '2345677899'
   ];
     List email = [
   'Jane cooper222@gmail.com',
    'Floyd Milies44@gmail.com',
    'karthic11@gmail.com',
    'JayaSeelan55@gmail.com',
    'Venkat44@gmail.com',
    'Prakash88@gmail.com',
    'Kristin Watson@gmail.com'
   ];
     List country = [
   'United states',
    'Iran',
    'Brazil',
    'Israel',
    'Kiribati',
    'Reunion',
    'Aland Islands'
   ];
    List status = [
   'Active',
    'Inative',
    'Active',
    'Active',
    'Inactive',
    'Active',
    'Active'
   ];

var startDate = DateTime.now().subtract(const Duration(days: 2));
  var endDate = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    // setDefault();
  }


  setDefault(){
   WidgetsBinding.instance.addPostFrameCallback((_) {
     if(locationController.userHistory.isEmpty){
       _showDialouge(context);
    }
   });
  }



    var selectedUser;

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
      if(selectedUser != null){
           locationController.getUserHistory(selectedUser, startDate, endDate);
      }
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now().add(Duration(days: 1)));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
      if(selectedUser != null){
           locationController.getUserHistory(selectedUser, startDate, endDate);
      }
    }
  }



     



   _showDialouge(BuildContext context) {
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(
          child: Container(
            height: 550,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                 const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                        ),
                       InkWell(
                        onTap: (){
                         locationController.searchForUser("");
                          Get.back();
                        },
                        child: const Icon(CupertinoIcons.xmark,color: Colors.blue,))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Select User",style: primaryFontsemiBold.copyWith(
                            fontSize: 16,
                          ),),
                          Text("To see the details of actvity and tracking",style: primaryFont.copyWith(
                        fontSize: 11,
                        color: Colors.black45
                      ),)
                    ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      height: 50,
                      child: TextField(
                        style: primaryFontsemiBold.copyWith(
                          fontSize: 15
                        ),
                        onChanged: (value) {
                          locationController.searchForUser(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.blue
                            )
                          ),
                          suffixIcon:const  Icon(Icons.search)
                        ),

                      ),
                    ),
                  ),
                   const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 350,
                    child: GetBuilder<LocationController>(
                      builder: (_) {
                        return locationController.userNameList.isEmpty ? Center(
                            child: Image.asset("assets/icons/no_data_found.jpg",height: 220),
                          ) :ListView.builder(
                          itemCount: locationController.userNameList.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                          return  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                               boxShadow: [
                                BoxShadow(
                                   blurRadius: 2,
                                   color: Colors.blue.withOpacity(0.4)
                                )
                               ],
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(locationController.userNameList[index].toUpperCase(),style: primaryFontsemiBold.copyWith(
                                      fontSize: 16
                                    ),),

                                   TextButton(onPressed: (){
                                    setState(() {
                                      selectedUser = locationController.userNameList[index].toUpperCase();
                                    });

                                    locationController.getUserHistory(locationController.userNameList[index], startDate, endDate);
                                    Get.back();

                                   }, child: Text("View",style: primaryFontsemiBold.copyWith(
                                    fontSize: 14,
                                    color: Colors.blue
                                   ),))

                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );
   }








  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                height: size.height + 300,
                width: 195,
                decoration:  BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.grey.withOpacity(0.4)
                    )
                  ],
          
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Image.asset("assets/icons/befco_img.jpeg",height: 110,),
                      ],
                     ),
                      // Text('Digital Data',
                      // textAlign: TextAlign.start,
                      // style: primaryFont.copyWith(
                      //   fontSize: 17,
                      //   fontWeight: FontWeight.bold
                      // ),),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/dashboard (1).png',
                            height: 20,
                            fit: BoxFit.fitHeight,),
                            Padding(
                              padding: const  EdgeInsets.only(left: 15),
                              child: Text('Dashboard',
                              style: primaryFont.copyWith(
                                fontWeight: FontWeight.w500
                              ),),
                            )
                          ],
                        ),
                      ),

                       const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: (){
                           _showDialouge(context);
                          },
                          child: Container(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/icons/users.png',
                                height: 20,
                                fit: BoxFit.fitHeight,),
                                Padding(
                                  padding: const  EdgeInsets.only(left: 15),
                                  child: Text('Select User',
                                  style: primaryFont.copyWith(
                                    fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                               const Icon(Icons.arrow_forward_ios_rounded,size: 15,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               ),
               Padding(
                 padding: const EdgeInsets.only(bottom: 0),
                 child: Container(
                  width: MediaQuery.of(context).size.width - 195,
                 child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(                            blurRadius: 2,
                            color: Colors.grey.withOpacity(0.4)
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width*0.3,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: TextField(
                                  controller:searchController,
                                  readOnly: true,
                                  onTap: ()=>  _showDialouge(context),
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(
                                      fontSize: 13
                                    ),
                                    suffixIcon: Container(
                                      height: 35,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: const Icon(Icons.search,
                                      color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1
                                      )
                                    )
                                  ), ),
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text('Hello, ',
                                    style: primaryFont.copyWith(
                                     color: Colors.grey.shade700
                                    ),),
                                    Text('Admin',
                                    style: primaryFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                    ),)
                                  ],
                                ),
                              const  SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/icons/software-engineer.png',height: 40,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                       Padding(
                         padding: const EdgeInsets.only(left: 60,right: 60,top: 40),
                         child: GetBuilder<LocationController>(
                           builder: (_) {
                             return Container(
                               decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0.0, 0.75),
                                  blurRadius: 5,
                                  color: Colors.grey
                                )
                              ]
                             ),
                             child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(selectedUser ?? "No User Selected",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      Row(
                                        children: [
                                          
                                           Container(
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                               const Icon(Icons
                                                                    .date_range),
                                                               const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    formatDate(startDate, [
                                                                      dd,
                                                                      "-",
                                                                      mm,
                                                                      "-",
                                                                      yyyy
                                                                    ]))
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
                                                               const Icon(Icons
                                                                    .date_range),
                                                             const   SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                    formatDate(endDate, [
                                                                      dd,
                                                                      "-",
                                                                      mm,
                                                                      "-",
                                                                      yyyy
                                                                    ]))
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
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                               const  SizedBox(
                                  height: 30,
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
                                                child:  Text(
                                                  "Date",
                                                  style: primaryFontsemiBold.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child:  Text(
                                                  "Username",
                                                 style: primaryFontsemiBold.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child:  Text(
                                                  "In Time",
                                                style: primaryFontsemiBold.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child:  Text(
                                                  "Out Time",
                                                  style: primaryFontsemiBold.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                child:  Text(
                                                  "Actions",
                                              style: primaryFontsemiBold.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                Divider(),
                                  const SizedBox(
                                          height: 20,
                                        ),

                                        if(locationController.userHistory.isEmpty)
                                          Column(
                                            children: [
                                              const SizedBox(
                                               height: 100,
                                               ),
                                              Image.asset("assets/icons/no_result_found.jpg",height: 200,)
                                            ],
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
                                              // decoration: BoxDecoration(
                                              //     color: i.isEven
                                              //         ? const Color.fromARGB(
                                              //             255, 214, 214, 214)
                                              //         : const Color.fromARGB(
                                              //             255, 238, 237, 237),
                                              //     borderRadius:
                                              //         BorderRadius.circular(10)),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 2,
                                                    color: Colors.blue.withOpacity(0.3)

                                                  )
                                                ],
                                               borderRadius: BorderRadius.circular(20)
                                              ),
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
                             )
                        
                        );
                           }
                         ),
                       )
                  ],
                 ),
                 ),
               )
            ],
          ),
        ],
      )
    );
  }
}