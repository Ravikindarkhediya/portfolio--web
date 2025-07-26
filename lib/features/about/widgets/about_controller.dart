import 'package:get/get.dart';

class AboutController extends GetxController {
  var hoverMap = <String, RxBool>{};

  void setHover(String key, bool isHovering) {
    if (!hoverMap.containsKey(key)) {
      hoverMap[key] = false.obs;
    }
    hoverMap[key]!.value = isHovering;
  }

  RxBool isHovering(String key) {
    return hoverMap.putIfAbsent(key, () => false.obs);
  }
}
