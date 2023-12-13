
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_admin/src/const/app_colors.dart';

import '../../controllers/auth_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.checkLoggedInOrNot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/icons/pos_logo.png"),
      ),
    );
  }
}
