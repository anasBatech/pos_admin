import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_admin/firebase_options.dart';
import 'package:pos_admin/src/controllers/auth_controller.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/views/auth_views/splash_screen.dart';
import 'package:pos_admin/src/views/home_views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LocationController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(),
    );
  }
}
