// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// import '../../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
// import '../../../App Helper/Ui Helper/divider_helper.dart';
// import '../../../App Helper/Ui Helper/loading_always.dart';
// import '../../../App Helper/Ui Helper/ui_helper.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
// import '../../../Drawer Menus/Client/client_add_page.dart';
// import 'admin_login_dashboard.dart';
// import 'client_action_admin_login.dart';
// import 'side_bar_auto_login.dart';
//
// class ClientAdminLogin extends StatefulWidget {
//   ClientAdminLogin({Key? key}) : super(key: key);
//
//   @override
//   State<ClientAdminLogin> createState() => _ClientAdminLoginState();
// }
//
// class _ClientAdminLoginState extends State<ClientAdminLogin> {
//   bool? isLoading;
//
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
//   String search = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: PrimaryColorOne,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Align(
//             alignment: Alignment.topRight,
//             child: Text("CLIENT", style: AllHeader)
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//               showModalBottomSheet(
//                   context: context,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
//                   builder: (context) {
//                     return SideBarAutoLogin();
//                   }
//               );
//             },
//           icon: Icon(
//               Icons.menu_rounded,
//               color: Colors.white,
//               size: 30,
//           )
//         ),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.3,
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: Card(
//                             elevation: 8,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
//                             child: Container(
//                               height: MediaQuery.of(context).size.height / 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.all(Radius.circular(40))
//                               ),
//                               padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'Search',
//                                     hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
//                                     suffixIcon: Icon(Icons.search)
//                                 ),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     search = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
//                 child: TextButton(
//                   onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientAddPage()));
//                     //ClientAddPage();
//                   },
//                   child: Align(alignment: Alignment.topLeft,child: Text("Add \nClient +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: MainWhiteContainerDecoration,
//               padding: MainWhiteContinerTopPadding,
//               child: isLoading == false
//                   ? AnimationLimiter(
//                 child: ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return AnimationConfiguration.staggeredList(
//                       position: index,
//                       duration: Duration(milliseconds: 1000),
//                       child: SlideAnimation(
//                         horizontalOffset: 50.0,
//                         child: Column(
//                           children: [
//                             FadeInAnimation(
//                               child: Padding(
//                                 padding: CardLTRBPadding,
//                                 child: Card(
//                                   shape: CardShapeData,
//                                   elevation: 10,
//                                   child: Container(
//                                     padding: ContinerPaddingInside,
//                                     decoration: SubContainerDecoration,
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             IDDataShow(id: "1559"),
//                                             CardDots,
//                                             FnmLnmDataShow(firstName: "Jaspinder Singh Saini",lastName: "",)
//                                           ],
//                                         ),
//                                         DividerDrawer(),
//                                         Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Column(
//                                             children: [
//                                               ServiceTypeDataShow(serviceType: "Wes"),
//                                               LetterTypeDataShow(letterType: "WES Document (WES Fee as Applicable)"),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                       padding: PaddingField,
//                                                       width: MediaQuery.of(context).size.width / 4,
//                                                       child: Text(
//                                                           "Foreign Country",
//                                                           style: BackHeaderTopL)
//                                                   ),
//                                                   CardDots,
//                                                   Expanded(
//                                                     child: Container(
//                                                         padding: PaddingField,
//                                                         child: Text("Canada",
//                                                             style: BackHeaderTopR)),
//                                                   )
//                                                 ],
//                                               ),
//                                               CreateAtDataShow(createAt: "13 Oct 2022"),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                       padding: PaddingField,
//                                                       width: MediaQuery.of(context).size.width / 4,
//                                                       child: Text("Action", style: BackHeaderTopL)
//                                                   ),
//                                                   CardDots,
//                                                   InkWell(
//                                                     onTap: (){
//                                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientActionAdminLogin()));
//                                                     },
//                                                     child: Container(
//                                                         padding: PaddingField,
//                                                         child: Icon(Icons.menu_open_sharp,color: Colors.white,size: 20,)
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//                   : CenterLoading(),
//             )
//           )
//         ],
//       ),
//     );
//   }
// }
