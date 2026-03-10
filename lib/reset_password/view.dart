import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ResetPasswordLogic(),
        builder: (c) => Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: Obx(() => Container(
            margin: EdgeInsets.all(24),
            child: ListView(
              children: [
                Text('Reset', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),),
                Text('Password', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),),
                Divider(color: Colors.transparent, height: 18,),
                Form(
                    key: c.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Color(0xFF1877F2))
                              ),
                              labelText: 'New Password',
                              suffixIcon: IconButton(
                                  onPressed: () => c.onVisibilityPassword.value = !c.onVisibilityPassword.value,
                                  icon: c.onVisibilityPassword.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                              )
                          ),
                          obscureText: c.onVisibilityPassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          controller: c.newPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid Password'; // Error message
                            }

                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }

                            String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regExp = RegExp(pattern);

                            if (!regExp.hasMatch(value)) {
                              return 'Must include uppercase, lowercase, digit, and special char';
                            }

                            return null; // Input is valid
                          },
                        ),
                        Divider(color: Colors.transparent, height: 16,),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(color: Color(0xFF1877F2))
                              ),
                              labelText: 'Confirm new password',
                              suffixIcon: IconButton(
                                  onPressed: () => c.onVisibilityPasswordConf.value = !c.onVisibilityPasswordConf.value,
                                  icon: c.onVisibilityPasswordConf.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                              )
                          ),
                          obscureText: c.onVisibilityPasswordConf.value,
                          keyboardType: TextInputType.visiblePassword,
                          controller: c.newPasswordConfController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid Password'; // Error message
                            }

                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }

                            if(value != c.newPasswordController.value.text) {
                              return 'Password not match';
                            }

                            String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'Must include uppercase, lowercase, digit, and special char';
                            }

                            return null; // Input is valid
                          },
                        ),
                      ],
                    )
                )
              ],
            ),
          )),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.zero),
                boxShadow: [BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, -2)
                )]
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: Color(0xFF1877F2),
                    padding: EdgeInsets.symmetric(vertical: 14)
                ),
                onPressed: () {
                  if(c.formKey.currentState!.validate()) {
                    c.toGoLoginAgain();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                )
            ),
          ),
        )
    );
  }
}
