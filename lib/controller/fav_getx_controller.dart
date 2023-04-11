import 'package:get/get.dart';

class FavgetXController extends GetxController {
  List<Map> s = [];

  addToFav(product) {
    s.add(product);
    update();
  }

  getIsFav(productId) {
    return s.where((element) => element['id'] == productId).isNotEmpty;
  }

  removeFromFav(productId) {
    s.removeWhere((element) => element['id'] == productId);
    update();
  }

  
}
