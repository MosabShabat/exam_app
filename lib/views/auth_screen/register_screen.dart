import 'dart:io';
import 'package:exam_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/auth_getx_controller.dart';
import '../../model/FirebaseResponse.dart';
import '../home_screen/home_screen.dart';
import '../../model/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _birthDateTextController;
  late TextEditingController _birthTimeTextController;
  late TextEditingController _userNameController;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _birthDateTextController = TextEditingController();
    _birthTimeTextController = TextEditingController();
    _userNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _birthDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.heightBox,
            "Create New"
                .text
                .fontFamily(bold)
                .color(darkFontGrey)
                .size(22)
                .make(),
            "Account".text.fontFamily(bold).color(darkFontGrey).size(22).make(),
            20.heightBox,
            "Please type full information below and "
                .text
                .fontFamily(regular)
                .color(darkFontGrey)
                .size(15)
                .make(),
            "we can create your account"
                .text
                .fontFamily(regular)
                .color(darkFontGrey)
                .size(15)
                .make(),
            20.heightBox,
            TextField(
              keyboardType: TextInputType.name,
              controller: _userNameController,
              decoration: InputDecoration(
                hintText: 'Full Name',
                border: InputBorder.none,
              ),
            ),
            30.heightBox,
            TextField(
              keyboardType: TextInputType.name,
              controller: _emailTextController,
              decoration: InputDecoration(
                hintText: 'Your Email',
                border: InputBorder.none,
              ),
            ),
            30.heightBox,
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            30.heightBox,
            TextField(
              controller: _birthDateTextController,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () {
                _pickDate();
              },
              decoration: InputDecoration(
                hintText: 'Birthdate',
                suffixIcon: const Icon(Icons.date_range),
                border: InputBorder.none,
              ),
            ),
            30.heightBox,
            ElevatedButton(
              onPressed: () async => await _performRegister(),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Sign Up'),
            ),
            50.heightBox,
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 3,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: "Or connect with"
                      .text
                      .fontFamily(regular)
                      .color(darkFontGrey)
                      .size(15)
                      .make(),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 3,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(apple),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(facebook),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(google),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      var format = DateFormat.yMd();
      var formattedDate = format.format(date);
      _birthDateTextController.text = formattedDate;
    }
  }

  void _customDialog() async {
    bool? hide = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 2,
              color: Colors.blue,
            ),
          ),
          child: Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                const Spacer(),
                const CircleAvatar(radius: 40),
                SizedBox(height: 15),
                Text(
                  'App Name',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Flutter Qatar',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
                Text(
                  'V 1.0.0',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black26,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.blue.shade200,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: const Text('HIDE'),
                )
              ],
            ),
          ),
        );
      },
    );

    print(hide ?? false);
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _userNameController.text.isNotEmpty) {
      return true;
    }
    VxToast.show(context, msg: 'Enter required data!');
    return false;
  }

  Future<void> _register() async {
    FireBaseResponse response =
        await Get.find<AuthGetxController>().register(user: user);
    if (response.stauts) {
      Get.snackbar("title", response.message);
      Get.off(() => HomeScreen());
    } else {
      Get.snackbar("title", response.message);
    }
  }

  User get user => User(
      email: _emailTextController.text,
      password: _passwordTextController.text,
      name: _userNameController.text,
      BD: _birthDateTextController.text,
      BTime: _birthTimeTextController.text);
}
