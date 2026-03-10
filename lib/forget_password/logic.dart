import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_sekuritas/otp_pin/view.dart';

class ForgetPasswordLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> fieldController = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void goToOtpPin() {
    Get.to(OtpPinPage(),
      transition: Transition.rightToLeft,
        arguments: {
          'phone': fieldController.value.text,
          'next_page': 'reset',
        }
    );
  }
}
