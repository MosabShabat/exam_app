import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/consts/consts.dart';
import 'package:exam_app/consts/firebase_consts.dart';
import 'package:exam_app/widget_common/small_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/lists.dart';
import '../../controller/fav_getx_controller.dart';
import '../../controller/product_controller.dart';
import '../../services/firestor_services.dart';
import '../../widget_common/exit_dialog.dart';
import '../../widget_common/stremer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tapController;
  @override
  void initState() {
    super.initState();
    tapController = TabController(length: 3, vsync: this);
  }

  // var isFav = false.obs;

  @override
  Widget build(BuildContext context) {
    Get.put(FirestorServices());
    var controllerProduct = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Discover"
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Categories"
                          .text
                          .fontFamily(regular)
                          .color(Colors.black)
                          .size(18)
                          .make(),
                      "View all"
                          .text
                          .fontFamily(regular)
                          .color(Colors.orange)
                          .size(18)
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          categoriesImages.length,
                          (index) => Row(
                                children: [
                                  Column(
                                    children: [
                                      fullContainer(
                                        width: 200.0,
                                        height: 120.0,
                                        widget: Image.asset(
                                          categoriesImages[index],
                                          width: 200.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        )
                                            .box
                                            .white
                                            .roundedSM
                                            .shadowMd
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .padding(const EdgeInsets.all(12))
                                            .make(),
                                      ),
                                      10.heightBox,
                                      categoriesList[index]
                                          .text
                                          .fontFamily(regular)
                                          .color(Colors.black)
                                          .size(18)
                                          .make(),
                                    ],
                                  ),
                                  5.widthBox
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Recommend for You"
                          .text
                          .fontFamily(regular)
                          .color(Colors.black)
                          .size(18)
                          .make(),
                      "View all"
                          .text
                          .fontFamily(regular)
                          .color(Colors.orange)
                          .size(18)
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  mainStrem(controllerProduct),
                  20.heightBox,
                  Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        child: TabBarView(controller: tapController, children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Ym9va3xlbnwwfHwwfHw%3D&w=1000&q=80",
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Ym9va3xlbnwwfHwwfHw%3D&w=1000&q=80",
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Ym9va3xlbnwwfHwwfHw%3D&w=1000&q=80",
                                    fit: BoxFit.cover)),
                          ),
                        ]),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10,
                        child: Center(
                          child: TabPageSelector(
                            controller: tapController,
                            selectedColor: Colors.white,
                            indicatorSize: 14,
                            // color: Colors.purple,
                            borderStyle: BorderStyle.solid,
                          ),
                        ),
                      )
                    ],
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Valentine's Day"
                          .text
                          .fontFamily(regular)
                          .color(Colors.black)
                          .size(18)
                          .make(),
                      "View all"
                          .text
                          .fontFamily(regular)
                          .color(Colors.orange)
                          .size(18)
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  mainStrem(controllerProduct),
                  20.heightBox,
                  "Popular Products"
                      .text
                      .fontFamily(regular)
                      .color(Colors.black)
                      .size(18)
                      .make(),
                  20.heightBox,
                  spareStrem(controllerProduct),
                  20.heightBox,
                  spareStrem(controllerProduct),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
