import 'package:flutter/material.dart';

import '../App Helper/Ui Helper/ui_helper.dart';
import 'OnBoarding/constants/constants.dart';

class InternetConnectionHelper extends StatelessWidget {
  const InternetConnectionHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Image(image: AssetImage("assets/gif/no-connection.gif"),width: 250)),
          const SizedBox(height: 20),
          Text(
            "Please Connect \n Internet Connection",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne,letterSpacing: 1)
          )
        ],
      ),
    );
  }
}
