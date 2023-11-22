import 'package:flutter/material.dart';

import '../../Authentication Pages/OnBoarding/constants/constants.dart';

class LoadingLogin extends StatelessWidget {
  LoadingLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/gif/icon.gif",width: 50)),
            SizedBox(height: 10),
            Text('Login...',style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,letterSpacing: 3),)
          ],
        ),
      ),
    );
  }
}

class LoadingOnly extends StatelessWidget {
  LoadingOnly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/gif/icon.gif",width: 30)),
          SizedBox(height: 10),
          Text('Loading...',style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15,letterSpacing: 3),)
        ],
      ),
    );
  }
}

class CenterLoading extends StatelessWidget {
  CenterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("assets/gif/icon.gif",width: 30));
  }
}

