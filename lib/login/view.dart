import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginLogic(),
      builder: (c) => Scaffold(
        body: Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.circle, color: Color(0xFF007D04), size: 24,)
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 20),
                child: c.registerOn.value ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello!', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold , color: Color(0xFF1877F2)),),
                    Divider(height: 10, color: Colors.transparent,),
                    Text('Sign up get Started', style: TextStyle(fontSize: 20, color: Color(0xFF4E4B66)),)
                  ],
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),),
                    Text('Again!', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold , color: Color(0xFF1877F2)),),
                    Divider(height: 10, color: Colors.transparent,),
                    Text('Welcome back you’ve\nbeen missed', style: TextStyle(fontSize: 20, color: Color(0xFF4E4B66)),)
                  ],
                ),
              ),
              Form(
                key: c.formKey,
                  child: Column(
                    children: [
                      if(c.registerOn.value) TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Color(0xFF1877F2))
                          ),
                          labelText: 'Name',
                        ),
                        keyboardType: TextInputType.text,
                        controller: c.nameController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name'; // Error message
                          }
                          return null; // Input is valid
                        },
                      ),
                      if(c.registerOn.value) Divider(height: 14, color: Colors.transparent,),
                      if(c.registerOn.value) TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Color(0xFF1877F2))
                          ),
                          labelText: 'Phone number',
                        ),
                        keyboardType: TextInputType.number,
                        controller: c.phoneNumberController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number'; // Error message
                          }
                          return null; // Input is valid
                        },
                      ),
                      if(c.registerOn.value) Divider(height: 14, color: Colors.transparent,),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Color(0xFF1877F2))
                          ),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: c.emailController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Email'; // Error message
                          }
                          return null; // Input is valid
                        },
                      ),
                      Divider(height: 14, color: Colors.transparent,),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Color(0xFF1877F2))
                          ),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () => c.onVisibilityPassword.value = !c.onVisibilityPassword.value,
                            icon: c.onVisibilityPassword.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                          )
                        ),
                        obscureText: c.onVisibilityPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        controller: c.passwordController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid Password'; // Error message
                          }
                          if(c.registerOn.value) {
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }

                            String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regExp = RegExp(pattern);

                            if (!regExp.hasMatch(value)) {
                              return 'Must include uppercase, lowercase, digit, and special char';
                            }
                          }
                          return null; // Input is valid
                        },
                      ),
                      if(c.registerOn.value) Divider(height: 14, color: Colors.transparent,),
                      if(c.registerOn.value) TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Color(0xFF1877F2))
                          ),
                          labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                                onPressed: () => c.onVisibilityPasswordConf.value = !c.onVisibilityPasswordConf.value,
                                icon: c.onVisibilityPasswordConf.value ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                            )
                        ),
                        obscureText: c.onVisibilityPasswordConf.value,
                        keyboardType: TextInputType.visiblePassword,
                        controller: c.passwordConfController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid Confirm Password'; // Error message
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }

                          if(value != c.passwordController.value.text) {
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
                      Divider(height: 8, color: Colors.transparent,),
                      if(!c.registerOn.value) Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => c.rememberSelect(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(c.rememberOn.value) Icon(Icons.check_box, size: 26, color: Color(0xFF1877F2),)
                                else Icon(Icons.check_box_outline_blank, size: 26, color: Color(0xFF1877F2),),
                                VerticalDivider(color: Colors.transparent, width: 6,),
                                Text('Remember me', style: TextStyle(color: Color(0xFF4E4B66)),)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => c.goToForgetPassword(),
                            child: Text('Forget the password ?', style: TextStyle(color: Color(0xFF1877F2)),),
                          )
                        ],
                      ),
                      Divider(color: Colors.transparent, height: 16,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              backgroundColor: Color(0xFF1877F2),
                              padding: EdgeInsets.symmetric(vertical: 14)
                          ),
                          onPressed: () {
                            if(c.formKey.currentState!.validate()) {
                              c.goToHome();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(c.registerOn.value ? 'Sign up' : 'Login', style: TextStyle(fontSize: 16, color: Colors.white),),
                            ],
                          )
                      ),
                      Divider(color: Colors.transparent, height: 16,),
                      Text('or continue with', style: TextStyle(color: Colors.grey)),
                      Divider(color: Colors.transparent, height: 16,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              backgroundColor: Colors.grey.shade100,
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24)
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/icons/google.png', height: 20, width: 20,),
                              VerticalDivider(color: Colors.transparent, width: 8,),
                              Text('Google', style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          )
                      ),
                      Divider(color: Colors.transparent, height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don’t have an account ? ', style: TextStyle(color: Colors.grey),),
                          GestureDetector(
                            onTap: () => c.signUpOrLogin(),
                            child: Text(c.registerOn.value ? 'Login' : 'Sign Up',
                              style: TextStyle(color: Color(0xFF1877F2)),),
                          )
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        )) ,
      )
    );
  }
}
