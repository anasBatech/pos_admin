import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos_admin/firebase_options.dart';
import 'package:pos_admin/src/controllers/auth_controller.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/views/auth_views/login_view.dart';
import 'package:pos_admin/src/views/auth_views/splash_screen.dart';
import 'package:pos_admin/src/views/home_views/home_view.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:pos_admin/src/views/home_views/list_users_view.dart';
import 'package:pos_admin/src/views/route_view/time_line_ui_testing.dart';
import 'package:pos_admin/src/views/routes/route_generator.dart';
import 'package:pos_admin/src/views/routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LocationController());
  Get.put(AuthController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreenView(),
      // home: UserLocationTimeLineViewTest(
      //   dateTime: DateTime.parse("2023-11-16 07:31:39.927"),
      //   startLocation: const LatLng(-8.9004118, 13.1928507),
      //   username: "CAR2",
      // ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: UserListScreen( ),
      // home: SignINView(),
    );
  }
}
