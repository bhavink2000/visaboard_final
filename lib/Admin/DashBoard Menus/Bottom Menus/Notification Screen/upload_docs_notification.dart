// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../App Helper/Ui Helper/ui_helper.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
//
//
// class UploadDocsNotifi extends StatefulWidget {
//   const UploadDocsNotifi({Key key}) : super(key: key);
//
//   @override
//   State<UploadDocsNotifi> createState() => _UploadDocsNotifi();
// }
//
// class _UploadDocsNotifi extends State<UploadDocsNotifi> {
//
//   File passwordcopy;
//   File offerLetter;
//   File otherDocs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back)
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//                   child: Text("Documents Upload"),
//                 )
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Align(alignment: Alignment.topLeft,child: Text("Student Document",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS),)),
//             ),
//             SizedBox(height: 10,),
//             Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Align(alignment: Alignment.topLeft,child: Text("Password Copy(Front, Last & All Remarked Pages)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),)),
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                     child: Card(
//                       elevation: 10,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: PrimaryColorOne
//                                 ),
//                                 onPressed: ()async {
//                                   try{
//                                     FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                     if(pickedfile != null){
//                                       setState((){
//                                         passwordcopy = File(pickedfile.files.single.path);
//                                       });
//                                     }
//                                   }
//                                   on PlatformException catch (e) {
//                                     print(" File not Picked ");
//                                   }
//                                 },
//                                 child: passwordcopy == null
//                                     ? Text("Choose File",style: TextStyle(color: Colors.white))
//                                     : Text("File Picked",style: TextStyle(color: Colors.white))
//                             ),
//                           ),
//                           Padding(
//                               padding: EdgeInsets.all(5),
//                               child: passwordcopy == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(passwordcopy.path.split('/').last,style: TextStyle(fontSize: 9),))
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Align(alignment: Alignment.topLeft,child: Text("Offer Letter",style: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),)),
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                     child: Card(
//                       elevation: 10,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: PrimaryColorOne
//                                 ),
//                                 onPressed: ()async {
//                                   try{
//                                     FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                     if(pickedfile != null){
//                                       setState((){
//                                         offerLetter = File(pickedfile.files.single.path);
//                                       });
//                                     }
//                                   }
//                                   on PlatformException catch (e) {
//                                     print(" File not Picked ");
//                                   }
//                                 },
//                                 child: offerLetter == null
//                                     ? Text("Choose File",style: TextStyle(color: Colors.white))
//                                     : Text("File Picked",style: TextStyle(color: Colors.white))
//                             ),
//                           ),
//                           Padding(
//                               padding: EdgeInsets.all(5),
//                               child: offerLetter == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(offerLetter.path.split('/').last,style: TextStyle(fontSize: 9),))
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10,),
//             Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Align(alignment: Alignment.topLeft,child: Text("Other Documents",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),)),
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                     child: Card(
//                       elevation: 10,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: PrimaryColorOne
//                                 ),
//                                 onPressed: ()async {
//                                   try{
//                                     FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                     if(pickedfile != null){
//                                       setState((){
//                                         otherDocs = File(pickedfile.files.single.path);
//                                       });
//                                     }
//                                   }
//                                   on PlatformException catch (e) {
//                                     print(" File not Picked ");
//                                   }
//                                 },
//                                 child: otherDocs == null
//                                     ? Text("Choose File",style: TextStyle(color: Colors.white))
//                                     : Text("File Picked",style: TextStyle(color: Colors.white))
//                             ),
//                           ),
//                           Padding(
//                               padding: EdgeInsets.all(5),
//                               child: otherDocs == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(otherDocs.path.split('/').last,style: TextStyle(fontSize: 9),))
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: (){},
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 80,vertical: 10),
//                 child: Container(
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: PrimaryColorOne,
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                   child: Text(
//                     "Submit Now",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
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
