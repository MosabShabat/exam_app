import 'dart:async';
import 'package:exam_app/model/user.dart' as modelUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'FirebaseResponse.dart';
import 'store_firebase.dart';

class AuthFireBase {
  // bool isLogin = false;
  FirebaseAuth instance = FirebaseAuth.instance;

  Future<FireBaseResponse> register({required modelUser.User myUser}) {
    return instance
        .createUserWithEmailAndPassword(
            email: myUser.email, password: myUser.password)
        .then((value) {
      value.user!.sendEmailVerification();
      myUser.id = value.user!.uid;
      return StoreFirebase().addUserData(myUser);
    }).onError((error, stackTrace) {
      return FireBaseResponse(stauts: false, message: error.toString());
    });
  }

  bool get isLogin => instance.currentUser != null;

  logout() {
    instance.signOut();
  }
}
