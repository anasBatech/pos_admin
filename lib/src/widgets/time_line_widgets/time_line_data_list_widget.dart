import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_admin/src/const/app_font.dart';

class TimeLineDataListWidget extends StatefulWidget {
  DateTime choosenDate;
 TimeLineDataListWidget({super.key,required this.choosenDate});

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
                        Text("Today".toUpperCase(),style: primaryFontsemiBold.copyWith(
                          fontSize: 14,
                          color: Colors.black54

                        ),)
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

                      isDropdownHideUnderline: true, // optional
                      isFormValidator: true, // optional
                      startYear: 2020, // optional
                      endYear: 2030, // optional
                      width: 12, // optional
                      selectedDay: widget.choosenDate.day, // optional
                      selectedMonth:  widget.choosenDate.month, // optional
                      selectedYear:  widget.choosenDate.year, // optional
                      onChangedDay: (value) => print('onChangedDay: $value'),
                      onChangedMonth: (value) => print('onChangedMonth: $value'),
                      onChangedYear: (value) => print('onChangedYear: $value'),
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
                const  SizedBox(
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
                             Text("45KM",style: GoogleFonts.poppins(
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
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Row(
                        crossAxisAlignment:index == places.length - 1 ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          index == 0 ? SvgPicture.asset("assets/icons/moto.svg",height: 25,
                          color: Colors.black54,
                          ) : index == 3 ? Image.asset("assets/icons/payment.png",height: 25,): SvgPicture.asset("assets/icons/moto.svg",height: 25,
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
                                bottomLeft:  index == places.length - 1 ? Radius.circular(10) : Radius.circular(0),
                                bottomRight:  index == places.length - 1 ? Radius.circular(10) : Radius.circular(0),
                              )
                            ),
                            alignment:index == places.length - 1 ?  Alignment.bottomCenter : Alignment.topCenter,
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
            
                          Container(
                            width: size.width * 0.22,
                            child: Text("48-52, Muniyappa St, Neelam Garden, Siruvallur, Perambur, Chennai, Tamil Nadu 600011",style: primaryFont.copyWith(
                              color: Colors.black45,
                              fontSize: 12
                            ),),
                          )
            
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
