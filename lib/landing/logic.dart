import 'package:get/get.dart';

class LandingLogic extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Future.delayed(
        Duration(seconds: 1), () {
      Get.offNamed('/login');
    }
    );
  }
}
