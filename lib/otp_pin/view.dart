import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'logic.dart';

class OtpPinPage extends StatelessWidget {
  const OtpPinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OtpPinLogic(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Obx(() {
          String minutes = (c.countdown ~/ 60).toString().padLeft(2, '0');
          String seconds = (c.countdown % 60).toString().padLeft(2, '0');
          return Container(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Center(
                    child: Text('OTP Verification', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),)),
                Divider(color: Colors.transparent, height: 8,),
                Center(
                  child: Text('Enter the OTP sent to ${c.phoneNumber}',
                      style: TextStyle(fontSize: 16, color: Colors.grey)
                  ),
                ),
                Divider(color: Colors.transparent, height: 20,),
                PinInput(
                  length: 4,
                  builder: (context, cells) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cells.map((cell) {
                      return Container(
                        alignment: Alignment.center,
                        width: 64,
                        height: 68,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: cell.isFocused ? Colors.blue : Colors.black
                            ),
                            boxShadow: cell.isFocused ? [BoxShadow(
                              color:Color(0xFF1877F2),
                              blurRadius: 4,
                            )] : [],
                            color: Colors.white
                        ),
                        child: Text(cell.character ?? '', style: TextStyle(fontSize: 32),),
                      );
                    }).toList(),
                  ),
                  onCompleted: (value) {},
                ),
                Divider(color: Colors.transparent, height: 8,),
                if(c.showInvalidOtp.value) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Colors.red,),
                    VerticalDivider(color: Colors.transparent, width: 4,),
                    Text('Invalid OTP', style: TextStyle(fontSize: 14, color: Colors.red),)
                  ],
                ),
                Divider(color: Colors.transparent, height: 20,),
                if(c.countdown.value != 0) Center(
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Resend code in ',
                        style: TextStyle(fontSize: 16, color: Colors.grey)
                      ),
                      TextSpan(
                        text: minutes,
                        style: TextStyle(fontSize: 16, color: Colors.red)
                      ),
                      TextSpan(
                        text: ' : ',
                        style: TextStyle(fontSize: 16, color: Colors.red)
                      ),
                      TextSpan(
                        text: seconds,
                        style: TextStyle(fontSize: 16, color: Colors.red)
                      )
                    ]
                  )),
                ) else GestureDetector(
                  onTap: () => c.playCountDown(),
                  child: Center(
                    child: Text('Resend code', style: TextStyle(fontSize: 16, color: Color(0xFF1877F2)),),
                  ),
                )
              ],
            ),
          );
        }),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.zero),
              boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(-1, -2)
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
              onPressed: () => c.submit(),
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
