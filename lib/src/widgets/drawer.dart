import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/controllers/location_controller.dart';
import 'package:pos_admin/src/views/home_views/all_users_list_view.dart';
import 'package:pos_admin/src/views/home_views/home_view.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
   final locationController = Get.find<LocationController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.19,
      decoration: BoxDecoration(color: primaryColor, boxShadow: [
        BoxShadow(blurRadius: 2, color: Colors.grey.withOpacity(0.2)),
      ]),
      child: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 100,
                width: size.width * 0.19,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: Image.asset("assets/icons/pos_logo.png"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30, right: 30),
            //   child: InkWell(
            //     onTap: () {
            //       locationController.isTodayClicked(true);
            //       locationController.isUserClicked(false);
            //       Get.off(() => HomeView());
            //     },
            //     onHover: (isHover) {
            //       locationController.isTodayHovered(isHover);
            //     },
            //     child: Container(
            //       height: 35,
            //       width: size.width * 0.19,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: locationController.isTodayClicked.isTrue ||
            //                   locationController.isTodayHovered.isTrue
            //               ? Colors.white.withOpacity(0.8)
            //               : Colors.white.withOpacity(0.3)),
            //       alignment: Alignment.centerLeft,
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 15),
            //         child: Text(
            //           "Today",
            //           style: TextStyle(
            //               color: locationController.isTodayClicked.isTrue ||
            //                       locationController.isTodayHovered.isTrue
            //                   ? primaryColor
            //                   : Colors.white,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: InkWell(
                onTap: () {
                  locationController.isUserClicked(true);
                  locationController.isTodayClicked(false);
                  print(locationController.isUserClicked.value);
                  Get.to(() => AllUsersView());
                },
                onHover: (isHover) {
                  locationController.isUserHovered(isHover);
                },
                child: Container(
                  height: 35,
                  width: size.width * 0.19,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: locationController.isUserClicked.isTrue ||
                              locationController.isUserHovered.isTrue
                          ? Colors.white.withOpacity(0.8)
                          : Colors.white.withOpacity(0.3)),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Users",
                      style: TextStyle(
                          color: locationController.isUserClicked.isTrue ||
                                  locationController.isUserHovered.isTrue
                              ? primaryColor
                              : Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
