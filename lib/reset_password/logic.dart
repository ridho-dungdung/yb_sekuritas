import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yb_sekuritas/login/view.dart';

class ResetPasswordLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  Database? database;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordConfController = TextEditingController().obs;
  RxString phoneNumber = ''.obs;
  RxBool onVisibilityPassword = true.obs;
  RxBool onVisibilityPasswordConf = true.obs;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    phoneNumber.value = Get.arguments;
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'yb_sekuritas.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, phone_number TEXT, email TEXT, password TEXT, otp TEXT)');
        });
  }

  void toGoLoginAgain() async {
    try {
      List<Map> users = await database!.rawQuery('SELECT * FROM User');
      print('COGSS ${users}');
      print('COGSS ${phoneNumber.value}');

      int count = await database!.rawUpdate(
          'UPDATE User SET password = ?, WHERE phone_number = ?',
          [newPasswordConfController.value.text.toString(), phoneNumber.value.toString()]);
      print('updated: $count');

      Get.snackbar(
        'Update account successful',
        'Reset password account successfully',
        colorText: Colors.white,
        backgroundColor: Colors.blue.shade600,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );

    } catch(err) {
      print(err);
      Get.snackbar(
        'Ops..',
        'Something wrong',

        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } finally {
      Get.offAll(LoginPage(),
          transition: Transition.upToDown
      );
    }
  }
}
