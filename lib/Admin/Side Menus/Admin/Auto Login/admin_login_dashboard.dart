// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import '../../../App Helper/Ui Helper/ui_helper.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
// import 'client_profile_setting_admin_login.dart';
// import 'side_bar_auto_login.dart';
//
// class AdminLoginDashboard extends StatefulWidget {
//   AdminLoginDashboard({Key key}) : super(key: key);
//
//   @override
//   State<AdminLoginDashboard> createState() => _AdminLoginDashboardState();
// }
//
// class _AdminLoginDashboardState extends State<AdminLoginDashboard> {
//   bool isLoading;
//   @override
//   void initState() {
//     isLoading = true;
//     Future.delayed(Duration(seconds: 2),(){
//       setState(() {
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(25),
//                 bottomLeft: Radius.circular(25)
//             )
//         ),
//         //centerTitle: true,
//         //title: Text("VISABOARD",style: AllHeader),
//         elevation: 0,
//         backgroundColor: ScaffoldBackColor,
//         leading: IconButton(
//             onPressed: (){
//               showModalBottomSheet(
//                   context: context,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
//                   builder: (context) {
//                     return SideBarAutoLogin();
//                   }
//               );
//             },
//             icon: Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
//         ),
//         actions: [
//           IconButton(
//               onPressed: (){},
//               icon: Icon(Icons.notifications,color: Colors.white,size: 30,)
//           ),
//           IconButton(
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientProfileSetting()));
//               },
//               icon: Icon(Icons.person_pin,color: Colors.white,size: 30,)
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
//               child: Text(
//                 "DashBoard",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: Constants.OPEN_SANS,
//
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 2,
//                 //color: Colors.green,
//                 // decoration: BoxDecoration(
//                 //     color: Colors.white,
//                 //     borderRadius: BorderRadius.all(Radius.circular(30)),
//                 //     boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
//                 // ),
//                 //padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
//                 child: AnimationLimiter(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 6,
//                         mainAxisSpacing: 6),
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return AnimationConfiguration.staggeredList(
//                         position: index,
//                         duration: Duration(milliseconds: 1000),
//                         child: SlideAnimation(
//                           verticalOffset: 50.0,
//                           child: FadeInAnimation(
//                             curve: Curves.easeInOut,
//                             child: Padding(
//                               padding: EdgeInsets.all(5),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: PrimaryColorOne,
//                                     borderRadius: BorderRadius.circular(30),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: PrimaryColorOne.withOpacity(0.2),
//                                           spreadRadius: 1,
//                                           blurRadius: 5
//                                       )
//                                     ]),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(8),
//                                           child: Icon(
//                                             index == 0
//                                                 ? Icons.person
//                                                 : index == 1
//                                                 ? Icons.style_rounded
//                                                 : index == 2
//                                                 ? Icons.app_registration
//                                                 : index == 3
//                                                 ? Icons.account_box
//                                                 : index == 4
//                                                 ? Icons.account_balance_wallet
//                                                 : index == 5
//                                                 ? Icons.bar_chart
//                                                 : Icons.backpack,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         Expanded(
//                                             child: Padding(
//                                               padding: EdgeInsets.all(8),
//                                               child: Text(
//                                                 index == 0
//                                                     ? "Student"
//                                                     : index == 1
//                                                     ? "Visitor"
//                                                     : index == 2
//                                                     ? "Stu.Dependent"
//                                                     : index == 3
//                                                     ? "Super Visa"
//                                                     : index == 4
//                                                     ? "Valuation"
//                                                     : index == 5
//                                                     ? "ITR"
//                                                     : "Service",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     color: Colors.white,
//                                                     fontFamily: Constants.OPEN_SANS,
//                                                     letterSpacing: 1),
//                                               ),
//                                             ))
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Container(
//                                       padding: ContinerPaddingInside,
//                                       width: MediaQuery.of(context).size.width,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.circular(25)),
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                             child: Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Text(
//                                                   "Active  : 10",
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontFamily: Constants.OPEN_SANS),
//                                                 )),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.all(2),
//                                             child: Divider(
//                                               color: PrimaryColorTwo,
//                                               thickness: 1.5,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
//                                             child: Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Text(
//                                                   "Total : 120",
//                                                   style: TextStyle(
//                                                       fontFamily: Constants.OPEN_SANS,
//                                                       fontSize: 15),
//                                                 )),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
