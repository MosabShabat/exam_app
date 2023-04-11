import 'package:get/get.dart';
import '../model/auth_firebase.dart';
import '../model/user.dart';

class AuthGetxController extends GetxController {
  register({required User user}) async {
    return await AuthFireBase().register(myUser: user);
  }
}
