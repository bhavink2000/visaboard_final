// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visaboard_final/Admin/Authentication%20Pages/OnBoarding/constants/constants.dart';

import '../../../App Helper/Ui Helper/ui_helper.dart';

class ClientProfileSetting extends StatefulWidget {
  ClientProfileSetting({Key? key}) : super(key: key);

  @override
  State<ClientProfileSetting> createState() => _ClientProfileSettingState();
}

class _ClientProfileSettingState extends State<ClientProfileSetting> {

  TextEditingController first_name = TextEditingController();
  TextEditingController middle_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController emailid = TextEditingController();

  File? file;
  String? status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColorOne,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,color: PrimaryColorOne,size: 40,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text("Hi Client",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS),),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Text("WelCome Back",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: Constants.OPEN_SANS),),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: first_name,
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: middle_name,
                            decoration: InputDecoration(
                                hintText: 'Middle Name',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: last_name,
                            decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: emailid,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: mobile,
                            decoration: InputDecoration(
                                hintText: 'Mobile',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne),
                                    onPressed: ()async {
                                      try{
                                        FilePickerResult? pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                        if(pickedfile != null){
                                          setState((){
                                            file = File(pickedfile.files.single.path!);
                                          });
                                        }
                                      }
                                      on PlatformException catch (e) {
                                        print(" File not Picked ");
                                      }
                                    },
                                    child: file == null
                                        ? Text("Choose File",style: TextStyle(color: Colors.white))
                                        : Text("File Picked",style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: file == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(file!.path.split('/').last,style: TextStyle(fontSize: 9),)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Rozorpay",style: TextStyle(fontSize: 18),)
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: RadioListTile(
                                      title: Text("Active"),
                                      value: "Active",
                                      groupValue: status,
                                      onChanged: (value){
                                        setState(() {
                                          status = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: RadioListTile(
                                      title: Text("InActive"),
                                      value: "InActive",
                                      groupValue: status,
                                      onChanged: (value){
                                        setState(() {
                                          status = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                          onPressed: (){
                            if(first_name.text.isEmpty || middle_name.text.isEmpty || last_name.text.isEmpty || mobile.text.isEmpty){
                              //SnackBarMessageShow.warningMSG('Fill All Field', context);
                            }
                            else{
                              if(file == null){
                                //SnackBarMessageShow.warningMSG('Please Select File & Status', context);
                              }
                              else{
                                //updateProfileDetails();
                              }
                            }
                          },
                          child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
