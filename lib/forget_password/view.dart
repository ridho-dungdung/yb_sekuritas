import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForgetPasswordLogic(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: ListView(
            children: [
              Text('Forget', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),),
              Text('Password', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),),
              Divider(color: Colors.transparent, height: 8,),
              Text('Don’t worry! it happens. Please enter the address associated with your account.',
                style: TextStyle(fontSize: 16, color: Colors.grey),),
              Divider(color: Colors.transparent, height: 18,),
              Form(
                key: c.formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1877F2))
                    ),
                    // labelText: 'Email ID / Mobile Phone',
                    labelText: 'Mobile Phone number',
                  ),
                  keyboardType: TextInputType.number,
                  controller: c.fieldController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number'; // Error message
                    }
                    return null; // Input is valid
                  },
                ),
              )
            ],
          ),
        ),
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
                  c.goToOtpPin();
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
