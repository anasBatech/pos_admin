import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_admin/src/const/app_colors.dart';
import 'package:pos_admin/src/const/app_font.dart';
import 'package:pos_admin/src/const/app_style.dart';
import 'package:pos_admin/src/controllers/auth_controller.dart';

class SignINView extends StatefulWidget {
  SignINView({Key? key}) : super(key: key);

  @override
  State<SignINView> createState() => _SignINViewState();
}

class _SignINViewState extends State<SignINView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final authController = Get.find<AuthController>();

  bool isObscure = true;

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Expanded(
              child: Container(
                color: Colors.white,
                child: const Image(
                          image: AssetImage("assets/icons/pos_logo.png"),
                        ),
              )),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 228, 219, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Admin Panel",style: primaryFontBold.copyWith(
                    fontSize: 22
                  ),),
                  Text("Login with your email and password",style: primaryFont.copyWith(
                    color: Colors.black45,
                    fontSize: 12
                  ),),
                 const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 330,
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                     ),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: primaryFontsemiBold.copyWith(
                        fontSize: 15
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                          labelText: "Email",
                          suffixIcon: InkWell(
                              onTap: () {
                                emailController.clear();
                              },
                              child: const Icon(CupertinoIcons.xmark_circle)),
                          enabledBorder: borderstyle,
                          focusedBorder: borderstyle),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: 330,
                     decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                     ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: isObscure,
                         style: primaryFontsemiBold.copyWith(
                        fontSize: 15
                      ),
                        decoration: InputDecoration(
                            labelText: "Password",
                             fillColor: Colors.white,
                             
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: isObscure
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            enabledBorder: borderstyle,
                            focusedBorder: borderstyle),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 330,
                    child: Row(
                      children: [
                        Checkbox(
                            value: rememberMe,
                            activeColor: primaryColor,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = val!;
                              });
                            }),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          "Remember Password",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                        Obx(() => InkWell(
                                    onTap: () {
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        authController.signIn(
                                            context,
                                            emailController.text,
                                            passwordController.text);
                                      } else {
                                        Get.snackbar(
                                            "Please Enter Email and Password to Continue",
                                            "",
                                            maxWidth: 400,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                    },
                          child: Container(
                                              height: 45,
                                              width: 330,
                                              decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)
                                              ),
                                              alignment: Alignment.center,
                                              child: authController.isLoading.isFalse
                                ?   Text("Sign in",style: primaryFontBold.copyWith(
                          color: Colors.white,
                          fontSize: 20
                                              ),) :const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                        ),
                  ),

                  // Obx(() => Container(
                  //       width: 330,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             height: 5,
                  //           ),
                  //           authController.isLoading.isFalse
                  //               ? InkWell(
                  //                   onTap: () {
                  //                     if (emailController.text.isNotEmpty &&
                  //                         passwordController.text.isNotEmpty) {
                  //                       authController.signIn(
                  //                           context,
                  //                           emailController.text,
                  //                           passwordController.text);
                  //                     } else {
                  //                       Get.snackbar(
                  //                           "Please Enter Email and Password to Continue",
                  //                           "",
                  //                           maxWidth: 400,
                  //                           colorText: Colors.white,
                  //                           backgroundColor: Colors.red);
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     height: 30,
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(20),
                  //                       color: primaryColor,
                  //                     ),
                  //                     alignment: Alignment.center,
                  //                     child: const Padding(
                  //                       padding: EdgeInsets.only(
                  //                           left: 15, right: 15),
                  //                       child: Text("Sign in",
                  //                           style:
                  //                               TextStyle(color: Colors.white)),
                  //                     ),
                  //                   ),
                  //                 )
                  //               : Container(
                  //                   height: 30,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(20),
                  //                     color: primaryColor,
                  //                   ),
                  //                   alignment: Alignment.center,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(
                  //                         left: 15, right: 15),
                  //                     child: Container(
                  //                       width: 40,
                  //                       height: 25,
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Container(
                  //                             height: 20,
                  //                             width: 20,
                  //                             child:
                  //                                 const CircularProgressIndicator(
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //         ],
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
