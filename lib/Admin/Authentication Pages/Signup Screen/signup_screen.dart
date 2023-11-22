import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visaboard_final/Admin/Authentication%20Pages/OnBoarding/constants/constants.dart';

import '../Login Screen/login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? password;
  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff0052D4),
                Color(0xff4364F7),
                Color(0xff6FB1FC),
              ]
          ),
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
                                      'Sing Up',
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
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: AnimationLimiter(
                    child: AnimationConfiguration.staggeredList(
                      position: 3,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TextField(
                            controller: name,
                            style: const TextStyle(color: Colors.white,),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              fillColor: Colors.lightBlueAccent,
                              labelText: 'Name',
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
                          child: TextField(
                            controller: email,
                            style: const TextStyle(color: Colors.white,),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              fillColor: Colors.lightBlueAccent,
                              labelText: 'Email',
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
                      position: 5,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TextField(
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
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
                  child: AnimationLimiter(
                    child: AnimationConfiguration.staggeredList(
                      position: 6,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
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
                              onPressed: () {},
                              child: const Text(
                                'Sign Up',
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 50),
                  child: AnimationLimiter(
                    child: AnimationConfiguration.staggeredList(
                      position: 7,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            alignment: Alignment.topRight,
                            //color: Colors.red,
                            //height: 20,
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  'Have we met before?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                  },
                                  child: const Text(
                                    'Sing in',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
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
    );
  }
}
