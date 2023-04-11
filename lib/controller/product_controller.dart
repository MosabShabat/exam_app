import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/controller/fav_getx_controller.dart';
import 'package:get/get.dart';
import '../consts/consts.dart';
import '../consts/firebase_consts.dart';

class ProductController {

  addToWishlist(image, title, price, id, context) async {
    await FirebaseFirestore.instance.collection('wishlist').doc(id).set({
      'image': image,
      'title': title,
      'price': price,
      'id': id,
      'added_by': currentUser!.uid
    });

    Get.find<FavgetXController>().addToFav({
      'image': image,
      'title': title,
      'price': price,
      'id': id,
      'added_by': currentUser!.uid
    });
    VxToast.show(context, msg: "Added to wishlist");
  }
}
//w42h1zaB5ga8TdeejkXg2u4FFuv2