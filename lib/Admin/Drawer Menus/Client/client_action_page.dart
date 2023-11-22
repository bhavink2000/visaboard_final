// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../App Helper/Api Repository/api_urls.dart';
// import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
// import '../../App Helper/Ui Helper/divider_helper.dart';
// import '../../App Helper/Ui Helper/loading_always.dart';
// import '../../App Helper/Ui Helper/ui_helper.dart';
// import '../../Authentication Pages/OnBoarding/constants/constants.dart';
// import '../drawer_menus.dart';
// import 'client_action_inside_page.dart';
//
//
// class ClientAction extends StatefulWidget {
//   ClientAction({Key? key}) : super(key: key);
//
//   @override
//   State<ClientAction> createState() => _ClientActionState();
// }
//
// class _ClientActionState extends State<ClientAction> {
//
//   bool? isLoading;
//   bool isShow = false;
//   String access_token = "",token_type = "";
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   final _advancedDrawerController = AdvancedDrawerController();
//
//   @override
//   void initState() {
//     //loadSharedPrefs();
//     isLoading = true;
//     Future.delayed(Duration(seconds: 2),(){
//       setState(() {
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }
//
//   String search = '';
//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       key: _key,
//       drawer: CustomDrawer(controller: _advancedDrawerController,),
//       backdropColor: Color(0xff0052D4),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: Duration(milliseconds: 300),
//       childDecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
//       child: Scaffold(
//         backgroundColor: Color(0xff0052D4),
//         appBar: AppBar(
//           title: Align(alignment: Alignment.topRight,child: Text("Client",style: AllHeader)),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: IconButton(
//               onPressed: (){_advancedDrawerController.showDrawer();},
//               icon: Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
//           ),
//         ),
//         body: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width / 1.3,
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: Card(
//                               elevation: 8,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
//                               child: Container(
//                                 height: MediaQuery.of(context).size.height / 20,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(Radius.circular(40))
//                                 ),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: 'Search',
//                                       hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
//                                       suffixIcon: Icon(Icons.search)
//                                   ),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       search = value;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
//                   child: TextButton(
//                     onPressed: (){
//                       openAddClients();
//                     },
//                     child: Align(alignment: Alignment.topLeft,child: Text("Add \nClient +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),color: Colors.white,
//                 ),
//                 padding: MainWhiteContinerTopPadding,
//                 child: isLoading == false
//                     ? AnimationLimiter(
//                   child: ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     itemCount: 3,
//                     itemBuilder: (context, index){
//                       return AnimationConfiguration.staggeredList(
//                         position: index,
//                         duration: Duration(milliseconds: 1000),
//                         child: SlideAnimation(
//                           horizontalOffset: 50.0,
//                           child: Column(
//                             children: [
//                               FadeInAnimation(
//                                 child: Padding(
//                                   padding: CardLTRBPadding,
//                                   child: FlipCard(
//                                     direction: FlipDirection.HORIZONTAL,
//                                     speed: 500,
//                                     onFlipDone: (status) {
//                                       print(status);
//                                     },
//                                     front: Card(
//                                       shape: CardShapeData,
//                                       elevation: 10,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             padding: ContinerPaddingInside,
//                                             decoration: SubContainerDecoration,
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     IDDataShow(id: "1564",),
//                                                     CardDots,
//                                                     FnmLnmDataShow(firstName: "Pawanpreet",lastName: "Singh",)
//                                                   ],
//                                                 ),
//                                                 DividerDrawer(),
//                                                 Align(
//                                                   alignment: Alignment.topLeft,
//                                                   child: Column(
//                                                     children: [
//                                                       CountryDataShow(countryName: "United Kingdom",),
//                                                       ServiceTypeDataShow(serviceType: "Student",),
//                                                       LetterTypeDataShow(letterType: "Admission",),
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                               padding: PaddingField,
//                                                               width: MediaQuery.of(context).size.width / 4,
//                                                               child: Text("Status",style: FrontFottorR)
//                                                           ),
//                                                           CardDots,
//                                                           Expanded(
//                                                             child: Container(
//                                                                 padding: PaddingField,
//                                                                 child: Text("PayMent Pending",style: FrontFottorR)
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                               padding: PaddingField,
//                                                               width: MediaQuery.of(context).size.width / 4,
//                                                               child: Text("Action", style: FrontFottorL)
//                                                           ),
//                                                           CardDots,
//                                                           Padding(
//                                                             padding: EdgeInsets.all(2),
//                                                             child: InkWell(
//                                                               onTap: (){
//                                                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientInsideAction()));
//                                                               },
//                                                               child: Container(
//                                                                   padding: PaddingField,
//                                                                   child: Icon(Icons.chat,color: Colors.white,size: 20,)
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding: EdgeInsets.all(2),
//                                                             child: InkWell(
//                                                               onTap: (){
//                                                                 Fluttertoast.showToast(msg: 'payment add /just demo msg');
//                                                               },
//                                                               child: Container(
//                                                                   padding: PaddingField,
//                                                                   color: Colors.red.withOpacity(0.5),
//                                                                   child: Text("PayMent Add",style: FrontFottorR)
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     back: Card(
//                                       shape: CardShapeData,
//                                       elevation: 10,
//                                       child: Container(
//                                         padding: ContinerPaddingInside,
//                                         height: MediaQuery.of(context).size.height / 4,
//                                         decoration: SubContainerDecoration,
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             OrderPriceDataShow(orderPrice: "₹0.00",),
//                                             AgentNameDataShow(agentName: "Bhagwant Singh",),
//                                             CompanyNameDataShow(companyName: "bhagwant",),
//                                             AdminNameDataShow(adminName: "Manjusha Nair",),
//                                             UpDateOnDataShow(upDateOn: "24 Nov 2022 13:14:33",)
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 )
//                     : CenterLoading(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   TextEditingController fNM = TextEditingController();
//   TextEditingController mNM = TextEditingController();
//   TextEditingController lNM = TextEditingController();
//   openAddClients() {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
//             contentPadding: EdgeInsets.only(top: 10.0),
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                     child: Text("Clients Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
//                   ),
//                   Divider(thickness: 1.5,color: PrimaryColorOne,),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                       child: SizedBox(
//                         //width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.width / 7,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               hintText: 'Agent',
//                               hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                           ),
//                           value: _selectedService,
//                           isExpanded: true,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedService = value as String?;
//                               _getletterList(access_token,token_type,_selectedService);
//                             });
//                           },
//                           onSaved: (value) {
//                             setState(() {
//                               _selectedService = value as String?;
//                             });
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return "can't empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                           items: serviceList?.map((item) {
//                             return DropdownMenuItem(
//                               value: item['id'].toString(),
//                               child: Text(item['name']),
//                             );
//                           })?.toList() ?? [],
//                         ),
//                       )
//                   ),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                       child: SizedBox(
//                         //width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.width / 7,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               hintText: 'Service Type',
//                               hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                           ),
//                           value: _selectedService,
//                           isExpanded: true,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedService = value as String?;
//                               _getletterList(access_token,token_type,_selectedService);
//                             });
//                           },
//                           onSaved: (value) {
//                             setState(() {
//                               _selectedService = value as String?;
//                             });
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return "can't empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                           items: serviceList?.map((item) {
//                             return DropdownMenuItem(
//                               value: item['id'].toString(),
//                               child: Text(item['name']),
//                             );
//                           })?.toList() ?? [],
//                         ),
//                       )
//                   ),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                       child: SizedBox(
//                         //width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.width / 7,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               hintText: 'Country',
//                               hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                           ),
//                           value: _selectedCountry,
//                           isExpanded: true,
//                           onTap: (){
//                             if(_selectedState == null && _selectedCity == null){
//                                             setState(() {
//                                               _getStateList(access_token,token_type,_selectedCountry);
//                                             });
//                                           }
//                                           else{
//                                             setState(() {
//                                               _selectedCity = null;
//                                               _selectedState = null;
//                                               _getCountryList(access_token,token_type);
//                                             });
//                                           }
//                           },
//                           onChanged: (country) {
//                             if(_selectedState == null && _selectedCity == null){
//                                             setState(() {
//                                               _selectedCountry = country;
//                                               _getStateList(access_token,token_type,_selectedCountry);
//                                             });
//                                           }
//                                           else{
//                                             setState(() {
//                                               _selectedCity = null;
//                                               _selectedState = null;
//                                               _getCountryList(access_token,token_type);
//                                             });
//                                           }
//                           },
//                           items: countryList?.map((item) {
//                             return DropdownMenuItem(
//                               value: item['id'].toString(),
//                               child: Text(item['name']),
//                             );
//                           })?.toList() ?? [],
//                         ),
//                       )
//                   ),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                       child: SizedBox(
//                         //width: MediaQuery.of(context).size.width / 2,
//                         height: MediaQuery.of(context).size.width / 7,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               hintText: 'Letter Type',
//                               hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                           ),
//                           value: _selectedLetter,
//                           isExpanded: true,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedLetter = value as String?;
//                             });
//                           },
//                           onSaved: (value) {
//                             setState(() {
//                               _selectedLetter = value as String?;
//                             });
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return "can't empty";
//                             } else {
//                               return null;
//                             }
//                           },
//                           items: letterList?.map((item) {
//                             return DropdownMenuItem(
//                               value: item['id'].toString(),
//                               child: Text(item['name']),
//                             );
//                           })?.toList() ?? [],
//                         ),
//                       )
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.width / 7,
//                       child: TextField(
//                         controller: fNM,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                             hintText: 'First Name',
//                             hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.width / 7,
//                       child: TextField(
//                         controller: mNM,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                             hintText: 'Middle Name',
//                             hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.width / 7,
//                       child: TextField(
//                         controller: lNM,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                             hintText: 'Last Name',
//                             hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(32),
//                           bottomLeft: Radius.circular(30),
//                         ),color: PrimaryColorOne
//                     ),
//                     child: IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
//                             child: InkWell(
//                               onTap: (){
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "Discard",
//                                 style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           VerticalDivider(thickness: 1.5,color: Colors.white,),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//                             child: InkWell(
//                               onTap: (){},
//                               child: Text(
//                                 "Submit",
//                                 style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
//
//   String? _selectedService;
//   List? serviceList;
//   Future<String?> _getserviceList(var accesstoken,var token_type) async {
//     await http.get(
//         Uri.parse(ApiConstants.getServiceType),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accesstoken',
//         }
//     ).then((response) {
//       var data = json.decode(response.body);
//       setState(() {
//         serviceList = data['data'];
//       });
//     });
//   }
//
//   String? _selectedCountry;
//   List? countryList;
//   Future<String?> _getCountryList(var accesstoken,var token_type) async {
//     await http.get(
//         Uri.parse(ApiConstants.getCountry),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accesstoken',
//         }
//     ).then((response) {
//       print(response.body);
//       var data = json.decode(response.body);
//       setState(() {
//         countryList = data['data'];
//       });
//     });
//   }
//
//   String? _selectedLetter;
//   List? letterList;
//   Future<String?> _getletterList(var accesstoken,var token_type,var selectService) async {
//     await http.post(
//         Uri.parse(ApiConstants.getLetterType),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $accesstoken',
//         },
//         body: jsonEncode({'service_id': selectService})
//     ).then((response) {
//       var data = json.decode(response.body);
//       setState(() {
//         letterList = data['data'];
//       });
//     });
//   }
// }
