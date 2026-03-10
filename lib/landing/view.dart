import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LandingLogic(),
      builder: (c) => Scaffold(
        body: Center(
          child: Image.asset('assets/icons/icon.jpg', height: 140, width: 140,),
        ),
      )
    );
  }
}
