import 'dart:convert';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/src/const/firebase_constants.dart';
import 'package:pos_admin/src/models/location_model.dart';
import 'package:pos_admin/src/models/location_names_model.dart';
import 'package:pos_admin/src/models/staff_models.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:excel/excel.dart';

class LocationController extends GetxController {
  List<EmployeeModel> attandaceEmpList = [];
  List<EmployeeModel> allUsersList = [];
  List<EmployeeModel> userHistory = [];

  List<LocationNameModel> locationNames = [];

  Map<String, Marker> markers = {};
// this will hold the generated polylines
  Set<Polyline> polylines = {};

  // List<LatLng> polylineCoordinates = [];

  RxDouble totalDistanceTraveled = 0.0.obs;

  RxBool isUserHovered = false.obs;
  RxBool isTodayHovered = false.obs;
  RxBool isUserClicked = true.obs;
  RxBool isTodayClicked = false.obs;

  RxBool isLoading = true.obs;

  RxBool isNameLoading = false.obs;

  getTodays() async {
    FirebaseFirestore.instance
        .collection(dailyAttendanceCollection)
        .doc(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}")
        .collection(emplyeeAttendanceCollection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      attandaceEmpList.clear();
      for (var doc in querySnapshot.docs) {
        EmployeeModel employeeModel = EmployeeModel(
          id: doc.id,
          name: doc["name"],
          username: doc["userName"],
          userID: doc["userID"],
          outTime: DateTime.parse(doc["outTime"]),
          inLocation: List<LatLongModel>.from(doc["inLocation"].map((x) =>
              LatLongModel(
                  latitude: x["latitude"], longitude: x["longitude"]))),
          inTime: DateTime.parse(doc["inTime"]),
          isIn: doc["isIn"],
          isOut: doc["isOut"],
          outLocation: List<LatLongModel>.from(doc["outLocation"].map((x) =>
              LatLongModel(
                  latitude: x["latitude"], longitude: x["longitude"]))),
        );
        attandaceEmpList.add(employeeModel);
      }
      update();
    });
  }

  Stream<QuerySnapshot> getAsStream(DateTime date) {
    Stream<QuerySnapshot> snap = FirebaseFirestore.instance
        .collection(dailyAttendanceCollection)
        .doc("${date.day}-${date.month}-${date.year}")
        .collection(emplyeeAttendanceCollection)
        .snapshots();

    return snap;
  }

  getAllUsers() async {
    FirebaseFirestore.instance
        .collection(usersCollection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      allUsersList.clear();
      for (var doc in querySnapshot.docs) {
        EmployeeModel employeeModel = EmployeeModel(
          id: doc.id,
          name: doc["name"],
          username: doc["userName"],
          userID: doc["userID"],
          outTime: DateTime.parse(doc["outTime"]),
          inLocation: List<LatLongModel>.from(doc["inLocation"].map((x) =>
              LatLongModel(
                  latitude: x["latitude"], longitude: x["longitude"]))),
          inTime: DateTime.parse(doc["inTime"]),
          isIn: doc["isIn"],
          isOut: doc["isOut"],
          outLocation: List<LatLongModel>.from(doc["outLocation"].map((x) =>
              LatLongModel(
                  latitude: x["latitude"], longitude: x["longitude"]))),
        );
        allUsersList.add(employeeModel);
      }
      update();
    });
  }

  Stream<QuerySnapshot> getAsStreamOfUsers() {
    Stream<QuerySnapshot> snap =
        FirebaseFirestore.instance.collection(usersCollection).snapshots();

    return snap;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getLiveLocation(
      String username, DateTime date) {
    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    var stream = attendanceCollection
        .doc("${date.day}-${date.month}-${date.year}")
        .collection(emplyeeAttendanceCollection)
        .doc(username)
        .collection(liveLOcationCollection)
        .doc("live")
        .snapshots();

    return stream;
  }

  getLivePolyLine(String username, DateTime date) async {
    List<LocationModel> treat = [];
    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    var data = await attendanceCollection
        .doc("${date.day}-${date.month}-${date.year}")
        .collection(emplyeeAttendanceCollection)
        .doc(username)
        .collection(liveLOcationCollection).orderBy("createdAt").get();


        print("//<<---doc length--->>\\");
        print(data.docs.length);

    if (data.docs.isNotEmpty) {
      // var polyMap = data.data();
      // var temppolyList = polyMap!["polyLine"];
      treat = [];
      data.docs.forEach((element) {
        treat.add(LocationModel(
            isInvoiced: element["is_invoiced"] ?? false,
            date: element["createdAt"] == null
                ? DateTime(1000)
                : DateTime.parse(element["createdAt"]),
            latLang: LatLng(element["latitude"], element["longitude"])));
      });
    }

    return treat;
  }

  getLiveInvoices(String username, DateTime date) async {
    List<LocationModel> treat = [];
    CollectionReference attendanceCollection =
        FirebaseFirestore.instance.collection(dailyAttendanceCollection);

    var data = await attendanceCollection
        .doc("${date.day}-${date.month}-${date.year}")
        .collection(emplyeeAttendanceCollection)
        .doc(username)
        .collection(InvoicedLOcationCollection)
        .get();

    print("--------document lenght-------$username---${date.day}-${date.month}-${date.year}");
    print(data.docs.length);

    if (data.docs.isNotEmpty) {
      // var polyMap = data.data();
      // var temppolyList = polyMap!["polyLine"];
      treat = [];
      data.docs.forEach((element) {
        treat.add(LocationModel(
            isInvoiced: element.data()["is_invoiced"] ?? false,
            date: element.data()["createdAt"] == null
                ? DateTime(1000)
                : DateTime.parse(element.data()["createdAt"]),
            latLang: LatLng(
                element.data()["latitude"], element.data()["longitude"])));
      });
    }

    return treat;
  }

  double calculateDistane(List<LocationModel> polyline) {
    double totalDistance = 0;
    for (int i = 0; i < polyline.length; i++) {
      if (i < polyline.length - 1) {
        // skip the last index
        totalDistance += getStraightLineDistance(
            polyline[i + 1].latLang.latitude,
            polyline[i + 1].latLang.longitude,
            polyline[i].latLang.latitude,
            polyline[i].latLang.longitude);
      }
    }
    totalDistanceTraveled(totalDistance / 1000);
    update();
    return totalDistance;
  }

  double getStraightLineDistance(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1);
    var dLon = deg2rad(lon2 - lon1);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d * 1000; //in m
  }

  dynamic deg2rad(deg) {
    return deg * (math.pi / 180);
  }

//AIzaSyDergFiQQSAtleFHO8tkKGj2ox1oYRIFsI
  Future<String> getPlacesName(LatLng latLng) async {
    String placeName = "";
    try {
      double lat = latLng.latitude;
      double lng = latLng.longitude;
      String apiKey = 'AIzaSyDergFiQQSAtleFHO8tkKGj2ox1oYRIFsI';
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String address = data['results'][0]['formatted_address'];
        placeName = address;
        // print(placeName);
        // print('Address: $address');
      } else {
        print('Failed to retrieve geocoding data');
      }
    } catch (e) {
      print("Error: $e");
    }
    return placeName;
  }

  generateListOfLocationNames(List<LocationModel> polyline) async {
    locationNames.clear();
    print("%%%%%%%%%%%%%------------------length--------------%%%%%%%%%%%%%%");
    print(polyline.length);
    int i = 0;
    while (i < polyline.length) {
      String placename = await getPlacesName(polyline[i].latLang);
      locationNames.add(LocationNameModel(
          createdAt: polyline[i].date, locationName: placename));
      locationNames.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      update();
      i += 5;
    }
  }

  // Future<List<EmployeeModel>> generateUserHistory(
  //     String username, DateTime date) async {
  //   List<EmployeeModel> tempHistoryList = [];
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(dailyAttendanceCollection)
  //       .doc("${date.day}-${date.month}-${date.year}")
  //       .collection(emplyeeAttendanceCollection)
  //       .where("userName", isEqualTo: username)
  //       .get();
  //   tempHistoryList.clear();
  //   print("__________-------${querySnapshot.docs.length}----$date--__________");
  //   for (var doc in querySnapshot.docs) {
  //     EmployeeModel employeeModel = EmployeeModel(
  //       id: doc.id,
  //       name: doc["name"],
  //       username: doc["userName"],
  //       userID: doc["userID"],
  //       outTime: DateTime.parse(doc["outTime"]),
  //       inLocation: List<LatLongModel>.from(doc["inLocation"].map((x) =>
  //           LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
  //       inTime: DateTime.parse(doc["inTime"]),
  //       isIn: doc["isIn"],
  //       isOut: doc["isOut"],
  //       outLocation: List<LatLongModel>.from(doc["outLocation"].map((x) =>
  //           LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
  //     );
  //     tempHistoryList.add(employeeModel);
  //   }
  //   return tempHistoryList;
  // }

  Future<List<EmployeeModel>> generateUserHistory(
      String username, DateTime date, DateTime endDate) async {
    List<EmployeeModel> tempHistoryList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup(emplyeeAttendanceCollection)
        .where("userName", isEqualTo: username)
        .where("inTime", isGreaterThanOrEqualTo: date.toIso8601String())
        .where("inTime", isLessThanOrEqualTo: endDate.toIso8601String())
        .get();
    tempHistoryList.clear();
    print(
        "__________-------${querySnapshot.docs.length}----${date}-----$endDate-__________");
    for (var doc in querySnapshot.docs) {
      EmployeeModel employeeModel = EmployeeModel(
        id: doc.id,
        name: doc["name"],
        username: doc["userName"],
        userID: doc["userID"],
        outTime: DateTime.parse(doc["outTime"]),
        inLocation: List<LatLongModel>.from(doc["inLocation"].map((x) =>
            LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
        inTime: DateTime.parse(doc["inTime"]),
        isIn: doc["isIn"],
        isOut: doc["isOut"],
        outLocation: List<LatLongModel>.from(doc["outLocation"].map((x) =>
            LatLongModel(latitude: x["latitude"], longitude: x["longitude"]))),
      );
      tempHistoryList.add(employeeModel);
    }
    return tempHistoryList;
  }

  getUserHistory(String username, DateTime startDate, DateTime endDate) async {
    isLoading(true);
    print(">..<get user history>..<");
    List<DateTime> tlistOfDates = getDatesBetween(startDate, endDate);
    userHistory.clear();
    List<EmployeeModel> tempHistoryList =
        await generateUserHistory(username, startDate, endDate);

    tempHistoryList.forEach((element) {
      userHistory.add(element);
    });
    // for (int i = 0; i < tlistOfDates.length; i++) {

    //   if (userHistory.length > 1) {
    //     isLoading(false);
    //   }

    //   update();
    // }
    isLoading(false);
    update();
  }

  List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];
    DateTime date = DateTime(startDate.year, startDate.month, startDate.day);
    while (date.compareTo(endDate) <= 0) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
    }
    return dates;
  }

  void generateExcel(List<LocationModel> listPolys, String userName) async {
    var excel = Excel.createExcel();

    List<String> headingList = [
      "Sl. No.",
      "User",
      "Date",
      "Time",
      "Place",
      "Is invoiced",
    ];

    Sheet sheetObject = excel['Sheet1'];

    for (var i = 0; i < listPolys.length; i++) {
      String placename = await getPlacesName(listPolys[i].latLang);
      List<String> dataList = [
        (i + 1).toString(),
        userName,
        formatDate(listPolys[i].date, [dd, "-", mm, "-", yyyy]),
        formatDate(listPolys[i].date, [h, ":", nn, " ", am]),
        placename,
        listPolys[i].isInvoiced ? "Yes" : ""
      ];

      sheetObject.insertRowIterables(dataList, i + 1);
    }
    sheetObject.insertRowIterables(headingList, 0);

    var onValue = excel.encode();
    // File(join("$path/excel.xlsx"))
    //   ..createSync(recursive: true)
    //   ..writeAsBytesSync(onValue);
    final blob = html.Blob([onValue],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }
}
