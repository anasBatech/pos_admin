import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';

class TimeLineDataListWidget extends StatefulWidget {
  const TimeLineDataListWidget({super.key});

  @override
  State<TimeLineDataListWidget> createState() => _TimeLineDataListWidgetState();
}

class _TimeLineDataListWidgetState extends State<TimeLineDataListWidget> {
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
            flex: 1,
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
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            Text(
                              "TimeLine",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text("Today")
                      ],
                    ),
                  ),
                  DropdownDatePicker(
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
                    startYear: 1900, // optional
                    endYear: 2020, // optional
                    width: 10, // optional
                    // selectedDay: 14, // optional
                    selectedMonth: 10, // optional
                    selectedYear: 1993, // optional
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              shrinkWrap: true,
              children: const [
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
                SizedBox(
                  height: 50,
                ),
                Text("Changes and proliongs"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
