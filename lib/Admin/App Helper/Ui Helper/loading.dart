import 'package:flutter/material.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/loading_always.dart';

class LoadingIndicater{
  void onLoad(bool showBox,BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingOnly();
        }
    );
  }

  void onLoadExit(bool exitBox,BuildContext context){
    if(exitBox){
      Future.delayed(Duration(milliseconds: 1),(){
        Navigator.pop(context);
      });
    }
  }
}