import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../consts/firebase_consts.dart';
import '../../controller/product_controller.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/exit_dialog.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Favoutites"
            .text
            .fontFamily(semibold)
            .color(Colors.black)
            .size(18)
            .make(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.grey,
              )),
          20.widthBox,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            StreamBuilder(
              stream: FirestorServices.getWishlist(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  //  print(snapshot.data);
                  return Center(
                    child: "No Wishlist yet!".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: FirestorServices.getWishlist(
                                  currentUser!.uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: loadingIndicator());
                                } else if (snapshot.data!.docs.isEmpty) {
                                  //print(snapshot.data);
                                  return Center(
                                    child: "No products yet!"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                } else {
                                  var data = snapshot.data!.docs;
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Stack(children: [
                                        Container(
                                          height: 300,
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
                                            ],
                                          )
                                              .box
                                              .white
                                              .roundedSM
                                              .shadowMd
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .padding(const EdgeInsets.all(12))
                                              .make(),
                                        ),
                                        Positioned(
                                          right: 10,
                                          top: 0,
                                          child: IconButton(
                                              onPressed: () {
                                                FirestorServices
                                                    .removeFromWishlist(
                                                        currentUser!.uid);
                                                VxToast.show(context,
                                                    msg:
                                                        "Removed from wishlist");
                                              },
                                              icon: Icon(Icons.favorite,
                                                  color: redColor)),
                                        )
                                      ]);
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
