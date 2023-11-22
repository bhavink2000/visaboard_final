// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Authentication%20Provider/authentication_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/snackbar_msg_show.dart';
import 'package:visaboard_final/Admin/Authentication%20Pages/OnBoarding/constants/constants.dart';
import 'package:visaboard_final/Admin/Authentication%20Pages/Signup%20Screen/signup_screen.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{

  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

  bool loading = false;
  //Future<UserLogin> obj;

  SharedPreferences? logindata;
  @override
  void initState(){
    super.initState();
    loading = true;
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        loading = false;
      });
    });
    intll();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  void intll()async{
    logindata = await SharedPreferences.getInstance();
  }

  /*Future login()async{
    _onLoad(true);
    setState(() {
      loading = true;
    });
    var url = ApiConstants.Login;
    var response = await http.post(Uri.parse(url), body: {
      "email_id": 'info@visaboard.in',
      "password": 'Mission@1'
    });
    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      logindata.setString('username', username.text);
      logindata.setBool('login', false);
      Map userDataRequest =
      {
        'email_id': 'info@visaboard.in',
        'password': 'Mission@1',
      };
      obj = ApiDrawerMenu().userLogin(ApiConstants.Login,userDataRequest);
      await obj?.then((value) async {
        if(value?.status == 200)
        {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.remove('userData');
          Map<String, dynamic> userData = {
            "id": value?.data?.id,
            "first_name": value?.data?.firstName,
            "middle_name": value?.data?.middleName,
            "last_name": value?.data?.lastName,
            "email_id": value?.data?.emailId,
            "mobile_no": value?.data?.mobileNo,
            "image":value?.data?.image,
            "status":value?.data?.status,
            "created_at":value?.data?.createdAt,
            "updated_at":value?.data?.updatedAt,
            "access_token": value.accessToken,
            "token_type": value.tokenType,
          };
          setState(() {
            loading = false;
          });
          String encodedMap = json.encode(userData);
          sharedPreferences.setString('userData', encodedMap);
          SnackBarMessageShow.successsMSG('SuccessFully Login', context);
          Navigator.pushNamed(context, AppRoutesName.dashboard);
        }
        else
        {
          SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        }
      });
    }
    else{
      SnackBarMessageShow.warningMSG('UserName & Password Invalid', context);
    }
  }*/

  void _onLoad(bool showBox) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingLogin();
        }
    );
  }
  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<AuthProvider>(context);
    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LoginPageGradient,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Padding(
                      padding: EdgeInsets.only(top: 60, left: 10),
                      child: AnimationLimiter(
                        child: AnimationConfiguration.staggeredList(
                          position: 1,
                          duration: Duration(milliseconds: 1000),
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Text(
                                    'Sing in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            Container(height: 60,),
                            Center(
                              child: AnimationLimiter(
                                child: AnimationConfiguration.staggeredList(
                                  position: 2,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Text(
                                        'VisaBoard Mobile Application',
                                        style: TextStyle(fontSize: 24, color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                        position: 3,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: TextField(
                              controller: username,
                              style: const TextStyle(color: Colors.white,),
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                fillColor: Colors.lightBlueAccent,
                                labelText: 'UserName',
                                labelStyle: TextStyle(color: Colors.white70,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                        position: 4,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: password,
                                  style: const TextStyle(color: Colors.white,),
                                  obscureText: obScured,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    labelText: 'Password',
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(
                                          obScured
                                              ?
                                          Icons.visibility_sharp
                                              :
                                          Icons.visibility_off_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelStyle: const TextStyle(color: Colors.white70,),
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                            child: AlertDialog(
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                              contentPadding: const EdgeInsets.only(top: 10.0),
                                              content: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("Visaboard", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,fontSize: 18),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                                      child: TextField(
                                                        controller: email,
                                                        style: TextStyle(color: PrimaryColorOne),
                                                        decoration: InputDecoration(
                                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: PrimaryColorOne.withOpacity(0.5))),
                                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: PrimaryColorOne)),
                                                          fillColor: Colors.lightBlueAccent,
                                                          labelText: 'Email',
                                                          labelStyle: TextStyle(color: PrimaryColorOne.withOpacity(0.5),),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        TextButton(
                                                          child: Text("Discard",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                                          onPressed: (){
                                                            email.text = "";
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                                          onPressed: (){
                                                            forgotPasswordData();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  child: Text("Forgot Password",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 50, left: 200),
                    child: AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                        position: 5,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff0052D4),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if(username.text.isEmpty || password.text.isEmpty){
                                    SnackBarMessageShow.warningMSG('Fill All Field', context);
                                  }
                                  else{
                                    Map data = {
                                      "email_id": username.text,
                                      "password": password.text
                                    };
                                    userAuth.loginApi(data, context);
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xff0052D4),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void forgotPasswordData() async {
    var url = ApiConstants.ForgotPassword;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email_id": email.text,
        },
      );
      final jsonData = json.decode(response.body);
      var bodyStatus = jsonData['status'];
      var bodyMSG = jsonData['data'];
      print("response--->${response.statusCode}");
      print("response--->${response.body}");
      if (response.statusCode == 200) {
        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushNamed(context, AppRoutesName.login);
        } else {
          SnackBarMessageShow.errorMSG('$bodyMSG', context);
        }
      } else {
        if(bodyStatus == 400){
          SnackBarMessageShow.errorMSG('Invalid Email Id', context);
        }
        else{
          SnackBarMessageShow.errorMSG('Failed to load data', context);
        }
      }
    } catch (e) {
      print(e.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}