import 'dart:async';

import 'package:get/get.dart';
import 'package:yb_sekuritas/home/view.dart';
import 'package:yb_sekuritas/reset_password/view.dart';

class OtpPinLogic extends GetxController {
  RxString phoneNumber = ''.obs;
  RxInt countdown = 180.obs;
  RxBool showInvalidOtp = false.obs;
  RxString nextPage = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumber.value = Get.arguments['phone'];
    nextPage.value = Get.arguments['next_page'];
    playCountDown();
  }

  void playCountDown() {
    countdown.value = 180;
    Timer.periodic(
        Duration(seconds: 1),
            (Timer timer) {
          if(countdown.value == 0) {
            timer.cancel();
          } else {
            countdown.value--;
          }
        }
    );
  }

  void submit() {
    if(nextPage.value == 'home') {
      Get.offAll(HomePage(),
          transition: Transition.upToDown
      );
    } else {
      Get.to(ResetPasswordPage(),
          transition: Transition.rightToLeftWithFade,
        arguments: phoneNumber.value
      );
    }
  }
}
