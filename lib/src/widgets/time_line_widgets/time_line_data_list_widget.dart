import 'package:date_format/date_format.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/app_font.dart';
import 'package:pos_admin/src/models/location_names_model.dart';
import 'package:pos_admin/src/views/route_view/user_location_timeline_view.dart';
import 'package:pos_admin/src/views/routes/route_names.dart';

class TimeLineDataListWidget extends StatefulWidget {
  DateTime choosenDate;
  List<LocationNameModel> locationNames;
  double totalTravelledPath;
  LatLng startLocation;
  String username;
 TimeLineDataListWidget({super.key,required this.choosenDate,required this.locationNames,required this.totalTravelledPath,required this.startLocation,required this.username});

  @override
  State<TimeLineDataListWidget> createState() => _TimeLineDataListWidgetState();
}

class _TimeLineDataListWidgetState extends State<TimeLineDataListWidget> {

   List places = [
    "chennai",
    "madurai",
    "isthamul",
    "karnataka",
    "Thaiwan",
    "pondichery"
   ];



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width * 0.35,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: size.width * 0.35,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 2, color: Color.fromARGB(255, 226, 226, 226))
              ]),
              child: Column(
                children: [
                 const SizedBox(
                    height: 10,
                  ),
                   Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Get.offAllNamed(RoutesName.HOME_PAGE);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const  SizedBox(
                              width: 10,
                            ),
                           const  Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Timeline",
                              style: primaryFontsemiBold.copyWith(
                                fontWeight: FontWeight.w500,
                                  fontSize: 18,),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            DateTime todaydate = DateTime.now();
                            Get.offAll(()=> UserLocationTimeLineView(
                              dateTime: todaydate,
                              startLocation: widget.startLocation,
                              username: widget.username,
                            ));
                          },
                          child: Text("Today".toUpperCase(),style: primaryFontsemiBold.copyWith(
                            fontSize: 14,
                            color: Colors.black54
                          ),),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownDatePicker(
                      inputDecoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10))), // optional
                                yearFlex: 2,
                                dayFlex: 2,
                                monthFlex: 3,
                      isDropdownHideUnderline: true, // optional
                      isFormValidator: true, // optional
                      startYear: 2020, // optional
                      endYear: 2030, // optional
                      width: 15, // optional
                      selectedDay: widget.choosenDate.day, // optional
                      selectedMonth:  widget.choosenDate.month, // optional
                      selectedYear:  widget.choosenDate.year, // optional

                      onChangedDay: (value) {
                        print('onChangedDay: $value');
                        int day = int.parse(value!);
                         
                        DateTime dateChoosen = DateTime(widget.choosenDate.year,widget.choosenDate.month,day);
                         Get.offAll(()=> UserLocationTimeLineView(
                              dateTime: dateChoosen,
                              startLocation: widget.startLocation,
                              username: widget.username,
                            ));
     
                      },
                      onChangedMonth: (value) {
                        print('onChangedMonth: $value');
                         int months = int.parse(value!);
                         DateTime dateChoosen = DateTime(widget.choosenDate.year,months,widget.choosenDate.day);
                          Get.offAll(()=> UserLocationTimeLineView(
                              dateTime: dateChoosen,
                              startLocation: widget.startLocation,
                              username: widget.username,
                            ));
                      },
                      onChangedYear: (value) {
                        print('onChangedYear: $value');
                         int years = int.parse(value!);
                         DateTime dateChoosen = DateTime(years,widget.choosenDate.month,widget.choosenDate.day);
                          Get.offAll(()=> UserLocationTimeLineView(
                              dateTime: dateChoosen,
                              startLocation: widget.startLocation,
                              username: widget.username,
                            ));
                      },
                        
                      //boxDecoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                      // showDay: false,// optional
                      // dayFlex: 2,// optional
                      // locale: "zh_CN",// optional
                      // hintDay: 'Day', // optional
                      // hintMonth: 'Month', // optional
                      // hintYear: 'Year', // optional
                      // hintTextStyle: TextStyle(color: Colors.grey), // optional
                    ),
                  ),
                const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                       Image.asset("assets/icons/long-distance (1).png",height: 40,),
                       const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Distance",style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400
                            ),),
                             Text("${widget.totalTravelledPath.toStringAsFixed(2)} KM",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),)
                          ],
                        )
                  
                  
                  
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                child: ListView.builder(
                  shrinkWrap: true,
                  addRepaintBoundaries : false,
                  itemCount: widget.locationNames.length,
                  itemBuilder: (context, index) {
                    return Row(
                        crossAxisAlignment:index == places.length - 1 ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          index == 0 ? SvgPicture.asset("assets/icons/moto.svg",height: 25,
                          color: Colors.black54,
                          ) : widget.locationNames[index].isinvoiced ? Image.asset("assets/icons/payment.png",height: 25,): SvgPicture.asset("assets/icons/moto.svg",height: 25,
                          color: Colors.white,
                          ),
            
                          Container(
                            width: 10,
                            height: 120,
                            decoration:  BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: index == 0 ? Radius.circular(10) : Radius.circular(0),
                                topRight:  index == 0 ? Radius.circular(10) : Radius.circular(0),
                                bottomLeft:  index == widget.locationNames.length - 1 ? Radius.circular(10) : Radius.circular(0),
                                bottomRight:  index == widget.locationNames.length - 1 ? Radius.circular(10) : Radius.circular(0),
                              )
                            ),
                            alignment:index == widget.locationNames.length - 1 ?  Alignment.bottomCenter : Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                          ),
            
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.22,
                                child: Text(widget.locationNames[index].locationName,style: primaryFont.copyWith(
                                  color: Colors.black45,
                                  fontSize: 12
                                ),),
                              ),
 const SizedBox(
                            height: 10,
                          ),
                          Text(formatDate(widget.locationNames[index].createdAt, [h,":",nn," " ,am]),style: primaryFontsemiBold.copyWith(
                                  color: Colors.black54,
                                  fontSize: 11,

                                ),)
                            ],
                          ),
                         
                        ],
                       );
                  },
                  
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
