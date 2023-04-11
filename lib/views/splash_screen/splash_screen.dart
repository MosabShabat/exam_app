import 'package:exam_app/views/auth_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_getx_controller.dart';
import '../../model/auth_firebase.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      () {
        Get.put(AuthGetxController());
        Get.off(() => AuthFireBase().isLogin ? HomeScreen() : RegisterScreen());
      },
    );
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
