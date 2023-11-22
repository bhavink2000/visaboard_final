import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../DashBoard Menus/main_dashboard.dart';
import 'client_admin_login.dart';

class SideBarAutoLogin extends StatefulWidget {
  SideBarAutoLogin({Key? key}) : super(key: key);

  @override
  State<SideBarAutoLogin> createState() => _SideBarAutoLoginState();
}

class _SideBarAutoLoginState extends State<SideBarAutoLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),
        color: PrimaryColorOne,
      ),
      //height: MediaQuery.of(context).size.height / 6,
      child: AnimationLimiter(
        child: AnimationConfiguration.staggeredList(
          position: 1,
          duration: Duration(milliseconds: 1000),
          child: SlideAnimation(
            verticalOffset: 75.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Main DashBoard",
                              style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS, fontSize: 13,
                                   color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ClientAdminLogin()));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Clients",
                              style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS, fontSize: 13,
                                   color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInAnimation(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_forward, color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Order Visa File",
                                style: TextStyle(
                                    fontFamily: Constants.OPEN_SANS, fontSize: 13,
                                     color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_forward_rounded, color: Colors.white,size: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Process",
                                style: TextStyle(
                                    fontFamily: Constants.OPEN_SANS, fontSize: 10,
                                     color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_forward_rounded, color: Colors.white,size: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Complate",
                                style: TextStyle(
                                    fontFamily: Constants.OPEN_SANS, fontSize: 10,
                                     color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_forward_rounded, color: Colors.white,size: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Hold",
                                style: TextStyle(
                                    fontFamily: Constants.OPEN_SANS, fontSize: 10,
                                     color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForms(name: 'Add Applicant')));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Internal Chat",
                              style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS, fontSize: 13,
                                   color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
