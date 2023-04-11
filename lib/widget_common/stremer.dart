import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebase_consts.dart';
import '../controller/fav_getx_controller.dart';
import '../controller/product_controller.dart';
import '../services/firestor_services.dart';
import 'exit_dialog.dart';

StreamBuilder<QuerySnapshot<Object?>> spareStrem(
    ProductController controllerProduct) {
  return StreamBuilder(
    stream: FirestorServices.getProd(currentUser!.uid),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(child: loadingIndicator());
      } else if (snapshot.data!.docs.isEmpty) {
        //print(snapshot.data);
        return Center(
          child: "No products yet!".text.color(darkFontGrey).make(),
        );
      } else {
        var data = snapshot.data!.docs;
        return GetBuilder<FavgetXController>(
            builder: (controller) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        data.length,
                        (index) => Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 350,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          50.heightBox,
                                          Image.network(
                                            "${data[index]['image']}",
                                            width: 200,
                                            height: 150,
                                            fit: BoxFit.fill,
                                          ),
                                          const Spacer(),
                                          10.heightBox,
                                          "${data[index]['title']}"
                                              .text
                                              .fontFamily(semibold)
                                              .size(16)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${data[index]['price']} \$"
                                              .text
                                              .fontFamily(bold)
                                              .color(darkFontGrey)
                                              .color(redColor)
                                              .make(),
                                          10.heightBox,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.store,
                                                color: Colors.orange,
                                              ),
                                              4.widthBox,
                                              "4.6k"
                                                  .text
                                                  .fontFamily(regular)
                                                  .color(Colors.black)
                                                  .size(12)
                                                  .make(),
                                              50.widthBox,
                                              Icon(
                                                Icons.visibility,
                                                color: Colors.orange,
                                              ),
                                              4.widthBox,
                                              "12.4k"
                                                  .text
                                                  .fontFamily(regular)
                                                  .color(Colors.black)
                                                  .size(12)
                                                  .make(),
                                            ],
                                          ),
                                        ],
                                      )
                                          .box
                                          .white
                                          .roundedSM
                                          .shadowMd
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12))
                                          .padding(const EdgeInsets.all(8))
                                          .make(),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            if (Get.find<FavgetXController>()
                                                .getIsFav(data[index]['id'])) {
                                              FirestorServices.updateData(
                                                  false, currentUser!.uid);
                                              FirestorServices
                                                  .removeFromWishlist(
                                                      currentUser!.uid);

                                              VxToast.show(context,
                                                  msg: "Removed from wishlist");
                                            } else {
                                              FirestorServices.updateData(
                                                  true, currentUser!.uid);
                                              controllerProduct.addToWishlist(
                                                  data[index]['image'],
                                                  data[index]['title'],
                                                  data[index]['price'],
                                                  data[index]['id'],
                                                  context);
                                              Get.find<FavgetXController>()
                                                  .addToFav({
                                                'image': data[index]['image'],
                                                'title': data[index]['title'],
                                                'price': data[index]['price'],
                                                'id': data[index]['id'],
                                                'added_by': currentUser!.uid
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Get.find<FavgetXController>()
                                                    .getIsFav(data[index]['id'])
                                                ? redColor
                                                : Colors.grey,
                                          )),
                                    )
                                  ],
                                ),
                                5.widthBox
                              ],
                            )).toList(),
                  ),
                ));
      }
    },
  );
}

StreamBuilder<QuerySnapshot<Object?>> mainStrem(
    ProductController controllerProduct) {
  return StreamBuilder(
    stream: FirestorServices.getProd(currentUser!.uid),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(child: loadingIndicator());
      } else if (snapshot.data!.docs.isEmpty) {
        //print(snapshot.data);
        return Center(
          child: "No products yet!".text.color(darkFontGrey).make(),
        );
      } else {
        var data = snapshot.data!.docs;
        return GetBuilder<FavgetXController>(
            builder: (controller) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        data.length,
                        (index) => Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 350,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          50.heightBox,
                                          Image.network(
                                            "${data[index]['image']}",
                                            width: 200,
                                            height: 150,
                                            fit: BoxFit.fill,
                                          ),
                                          const Spacer(),
                                          10.heightBox,
                                          "${data[index]['title']}"
                                              .text
                                              .fontFamily(semibold)
                                              .size(16)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${data[index]['price']} \$"
                                              .text
                                              .fontFamily(bold)
                                              .color(darkFontGrey)
                                              .color(redColor)
                                              .make(),
                                          10.heightBox,
                                        ],
                                      )
                                          .box
                                          .white
                                          .roundedSM
                                          .shadowMd
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12))
                                          .padding(const EdgeInsets.all(8))
                                          .make(),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            if (Get.find<FavgetXController>()
                                                .getIsFav(data[index]['id'])) {
                                              FirestorServices.updateData(
                                                  false, currentUser!.uid);
                                              FirestorServices
                                                  .removeFromWishlist(
                                                      currentUser!.uid);

                                              VxToast.show(context,
                                                  msg: "Removed from wishlist");
                                            } else {
                                              FirestorServices.updateData(
                                                  true, currentUser!.uid);
                                              controllerProduct.addToWishlist(
                                                  data[index]['image'],
                                                  data[index]['title'],
                                                  data[index]['price'],
                                                  data[index]['id'],
                                                  context);
                                              Get.find<FavgetXController>()
                                                  .addToFav({
                                                'image': data[index]['image'],
                                                'title': data[index]['title'],
                                                'price': data[index]['price'],
                                                'id': data[index]['id'],
                                                'added_by': currentUser!.uid
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Get.find<FavgetXController>()
                                                    .getIsFav(data[index]['id'])
                                                ? redColor
                                                : Colors.grey,
                                          )),
                                    )
                                  ],
                                ),
                                5.widthBox
                              ],
                            )).toList(),
                  ),
                ));
      }
    },
  );
}
