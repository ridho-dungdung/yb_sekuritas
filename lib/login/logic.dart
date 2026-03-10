import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yb_sekuritas/forget_password/view.dart';
import 'package:path/path.dart';
import 'package:yb_sekuritas/otp_pin/view.dart';

class LoginLogic extends GetxController {
  Database? database;
  RxBool rememberOn = true.obs;
  RxBool registerOn = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> passwordConfController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  RxBool onVisibilityPassword = true.obs;
  RxBool onVisibilityPasswordConf = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'yb_sekuritas.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, phone_number TEXT, email TEXT, password TEXT, otp TEXT)');
        });
  }
  
  void rememberSelect() {
    rememberOn.value = !rememberOn.value;
  } 
  
  void goToForgetPassword() {
    Get.to(ForgetPasswordPage(),
      transition: Transition.rightToLeftWithFade
    );
  }
  
  void signUpOrLogin() {
    if(registerOn.value) {
      emailController.value.value = TextEditingValue(text: '');
      passwordController.value.value = TextEditingValue(text: '');
    } else {
      nameController.value.value = TextEditingValue(text: '');
      phoneNumberController.value.value = TextEditingValue(text: '');
      emailController.value.value = TextEditingValue(text: '');
      passwordController.value.value = TextEditingValue(text: '');
      passwordConfController.value.value = TextEditingValue(text: '');
    }
    registerOn.value = !registerOn.value;
  }

  void goToHome() async {
    try {
      if(registerOn.value) {
        await database!.transaction((trn) async {
          int id1 = await trn.rawInsert(
              'INSERT INTO User(name, phone_number, email, password, otp) VALUES(?, ?, ?, ?, ?)',
              [nameController.value.text, phoneNumberController.value.text, emailController.value.text, passwordController.value.text, true]
          );
        });

        List<Map> users = await database!.rawQuery('SELECT * FROM User');
        if(users.any((user) => user['email'] == emailController.value.text)){
          emailController.value = TextEditingController(text: '');
          passwordController.value = TextEditingController(text: '');
          registerOn.value = false;

          Get.snackbar(
            'Sign up successful',
            'Create new account successfully',
            colorText: Colors.white,
            backgroundColor: Colors.blue.shade600,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
        }
      } else {
        List<Map> users = await database!.rawQuery('SELECT * FROM User');
        print('COGG inserted2: $users');
        if(users.any((user) => user['email'] == emailController.value.text)) {
          Map user  = users.firstWhere((user) => user['email'] == emailController.value.text);
          if(user['password'] == passwordController.value.text) {
            if(user['otp'] == '1') {
              Get.to(OtpPinPage(),
                transition: Transition.downToUp,
                arguments: {
                  'phone': user['phone_number'],
                  'next_page': 'home',
                }
              );
            } else {
              Get.offNamed('/home');
            }
          } else {
            Get.snackbar(
              'Password in correct',
              'please enter try again password',
              colorText: Colors.white,
              backgroundColor: Colors.red.shade600,
              forwardAnimationCurve: Curves.elasticInOut,
              reverseAnimationCurve: Curves.easeOut,
            );
          }
        } else {
          Get.snackbar(
            'Account not fount',
            'please enter try again email & password',
            colorText: Colors.white,
            backgroundColor: Colors.red.shade600,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
        }
      }
    } catch(err) {
      print('Error fetch Users Favorit by SQLlite: $err');
    }

  }
}
