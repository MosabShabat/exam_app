import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controller/fav_getx_controller.dart';

class FirestorServices {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static getProd(uid) {
    return FirebaseFirestore.instance
        .collection('prod')
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static updateData(isFav, docId) {
    final DocumentReference docRef =
        db.collection('prod').doc('mBNlptBL0LoI4csH54gc');
    docRef.update({'isFav': isFav}).then((value) {
      //   print('isFav field updated successfully for document with ID $docId.');
    }).catchError((error) {
      print('Failed to update isFav field for document with ID $docId: $error');
    });
  }

  static getWishlist(uid) {
    return FirebaseFirestore.instance
        .collection('wishlist')
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static void removeFromWishlist(docId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('added_by', isEqualTo: docId)
        .get();
    if (snapshot.size > 0) {
      await FirebaseFirestore.instance
          .collection('wishlist')
          .doc(snapshot.docs[0].id)
          .delete();
      Get.find<FavgetXController>().removeFromFav(snapshot.docs[0].id);
     // print('Product removed from wishlist!');
    } else {
      print('Product not found in wishlist!');
    }
  }
}
