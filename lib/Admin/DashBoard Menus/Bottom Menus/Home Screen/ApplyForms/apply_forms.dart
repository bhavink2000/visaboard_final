// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:visaboard_final/Admin/Authentication%20Pages/OnBoarding/constants/constants.dart';
//
// import '../../../../App Helper/Ui Helper/ui_helper.dart';
// import '../../../../Drawer Menus/drawer_menus.dart';
//
// class ApplyForms extends StatefulWidget {
//   var name;
//   ApplyForms({Key? key,this.name}) : super(key: key);
//
//   @override
//   State<ApplyForms> createState() => _ApplyFormsState();
// }
//
// class _ApplyFormsState extends State<ApplyForms> {
//
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   final _advancedDrawerController = AdvancedDrawerController();
//
//   String status = '';
//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       key: _key,
//       drawer: CustomDrawer(controller: _advancedDrawerController,),
//       backdropColor: Color(0xff0052D4),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: Duration(milliseconds: 300),
//       childDecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
//       child: Scaffold(
//         backgroundColor: Color(0xff0052D4),
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Align(alignment: Alignment.topRight,child: Text(widget.name.toString().toUpperCase(),style: AllHeader)),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: IconButton(
//               onPressed: (){_advancedDrawerController.showDrawer();},
//               icon: Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: widget.name == 'Quick Apply'
//                   ? SingleChildScrollView(
//                     child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(5),
//                                 bottomLeft: Radius.circular(5),
//                                 topRight: Radius.circular(25),
//                                 bottomRight: Radius.circular(25)
//                               ),
//                               color: PrimaryColorOne
//                             ),
//                             padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
//                             child: Text("Quick Apply",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: Constants.OPEN_SANS),),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Service Type',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedService,
//                               isExpanded: true,
//                               onChanged: (value) {
//                                 setState(() {
//                                   //_selectedService = value;
//                                   //_getletterList(access_token,token_type,_selectedService);
//                                 });
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   //_selectedService = value;
//                                 });
//                               },
//                               validator: (value) {
//                                 if (value == null) {
//                                   return "can't empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               items: serviceList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],
//                             ),
//                           )
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Country',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedCountry,
//                               isExpanded: true,
//                               onTap: (){
//                                 if(_selectedState == null && _selectedCity == null){
//                                                   setState(() {
//                                                     _getStateList(access_token,token_type,_selectedCountry);
//                                                   });
//                                                 }
//                                                 else{
//                                                   setState(() {
//                                                     _selectedCity = null;
//                                                     _selectedState = null;
//                                                     _getCountryList(access_token,token_type);
//                                                   });
//                                                 }
//                               },
//                               onChanged: (country) {
//                                 if(_selectedState == null && _selectedCity == null){
//                                                   setState(() {
//                                                     _selectedCountry = country;
//                                                     _getStateList(access_token,token_type,_selectedCountry);
//                                                   });
//                                                 }
//                                                 else{
//                                                   setState(() {
//                                                     _selectedCity = null;
//                                                     _selectedState = null;
//                                                     _getCountryList(access_token,token_type);
//                                                   });
//                                                 }
//                               },
//                               items: countryList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],
//                             ),
//                           )
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Letter Type',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedLetter,
//                               isExpanded: true,
//                               onChanged: (value) {
//                                 setState(() {
//                                   //_selectedLetter = value;
//                                 });
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   //_selectedLetter = value;
//                                 });
//                               },
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return "can't empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               items: letterList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],
//                             ),
//                           )
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Client Name',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'College / University Name',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Note',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Payment Options",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: Constants.OPEN_SANS,
//
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(4),
//                         child: Column(
//                           children: [
//                             RadioListTile(
//                               title: Text("VisaBoard Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
//                               value: "VisaBoard",
//                               groupValue: status,
//                               onChanged: (value){
//                                 setState(() {
//                                   status = value.toString();
//                                 });
//                               },
//                             ),
//                             RadioListTile(
//                               title: Text("Paytm",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
//                               value: "Paytm",
//                               groupValue: status,
//                               onChanged: (value){
//                                 setState(() {
//                                   status = value.toString();
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                           decoration: BoxDecoration(
//                             color: PrimaryColorOne,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                             child: Text(
//                               "Quick Apply",
//                               style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 2),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                 ),
//                   )
//                   : SingleChildScrollView(
//                     child: Column(
//                       children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(5),
//                                     bottomLeft: Radius.circular(5),
//                                     topRight: Radius.circular(25),
//                                     bottomRight: Radius.circular(25)
//                                 ),
//                                 color: PrimaryColorOne
//                             ),
//                             padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
//                             child: Text("Add Applicant",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: Constants.OPEN_SANS),),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Service Type',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedService,
//                               isExpanded: true,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedService = value;
//                                   _getletterList(access_token,token_type,_selectedService);
//                                 });
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   //_selectedService = value;
//                                 });
//                               },
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return "can't empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               items: serviceList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],
//                             ),
//                           )
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Country',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedCountry,
//                               isExpanded: true,
//                               onTap: (){
//                                 /*if(_selectedState == null && _selectedCity == null){
//                                                   setState(() {
//                                                     _getStateList(access_token,token_type,_selectedCountry);
//                                                   });
//                                                 }
//                                                 else{
//                                                   setState(() {
//                                                     _selectedCity = null;
//                                                     _selectedState = null;
//                                                     _getCountryList(access_token,token_type);
//                                                   });
//                                                 }*/
//                               },
//                               onChanged: (country) {
//                                 /*if(_selectedState == null && _selectedCity == null){
//                                                   setState(() {
//                                                     _selectedCountry = country;
//                                                     _getStateList(access_token,token_type,_selectedCountry);
//                                                   });
//                                                 }
//                                                 else{
//                                                   setState(() {
//                                                     _selectedCity = null;
//                                                     _selectedState = null;
//                                                     _getCountryList(access_token,token_type);
//                                                   });
//                                                 }*/
//                               },
//                               /*items: countryList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],*/
//                             ),
//                           )
//                       ),
//                       Padding(
//                           padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                           child: SizedBox(
//                             //width: MediaQuery.of(context).size.width / 2,
//                             height: MediaQuery.of(context).size.width / 7,
//                             child: DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Letter Type',
//                                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
//                               ),
//                               //value: _selectedLetter,
//                               isExpanded: true,
//                               onChanged: (value) {
//                                 setState(() {
//                                   //_selectedLetter = value;
//                                 });
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   //_selectedLetter = value;
//                                 });
//                               },
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return "can't empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               /*items: letterList?.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item['id'].toString(),
//                                   child: Text(item['name']),
//                                 );
//                               })?.toList() ?? [],*/
//                             ),
//                           )
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'First Name',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Middle Name',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Last Name',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Payment Options",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: Constants.OPEN_SANS,
//
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(4),
//                         child: Column(
//                           children: [
//                             RadioListTile(
//                               title: Text("VisaBoard Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
//                               value: "VisaBoard",
//                               groupValue: status,
//                               onChanged: (value){
//                                 setState(() {
//                                   status = value.toString();
//                                 });
//                               },
//                             ),
//                             RadioListTile(
//                               title: Text("Paytm",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
//                               value: "Paytm",
//                               groupValue: status,
//                               onChanged: (value){
//                                 setState(() {
//                                   status = value.toString();
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                           decoration: BoxDecoration(
//                             color: PrimaryColorOne,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                             child: Text(
//                               "Add Applicant",
//                               style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 2),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
