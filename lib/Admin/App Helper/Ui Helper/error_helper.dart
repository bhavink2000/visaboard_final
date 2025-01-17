import 'package:flutter/material.dart';

class ErrorHelper extends StatelessWidget {
  const ErrorHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(image: AssetImage("assets/gif/try_again.png"),width: 250),
      ),
    );
  }
}
