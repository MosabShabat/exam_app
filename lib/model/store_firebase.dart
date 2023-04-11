import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/model/user.dart';

import 'FirebaseResponse.dart';
import 'auth_firebase.dart';

class StoreFirebase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<FireBaseResponse> addUserData(User user) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(user.id)
          .set(user.toJson());
      return FireBaseResponse(stauts: true, message: "verify your account");
    } catch (e) {
      return FireBaseResponse(stauts: false, message: e.toString());
    }
  }

  Future<List<User>> getUserData() async {
    List<User> list = [];
    return await firebaseFirestore
        .collection("Users")
        .where('id', isEqualTo: AuthFireBase().instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        User u = User.fromJson(element.data());
        list.add(u);
      });
      return list;
    });
  }

  Future<List<User>> getAllUsers() async {
    List<User> list = [];
    return await firebaseFirestore
        .collection("Users")
        .where('id', isNotEqualTo: AuthFireBase().instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        User u = User.fromJson(element.data());
        list.add(u);
      });
      return list;
    });
  }

  updateUser(user) {
    firebaseFirestore.collection("Users").doc(user.id).update(user.tojson());
  }


}
