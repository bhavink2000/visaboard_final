// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class MarketingCreateEdit extends StatefulWidget {
  var type;
  var nm,number,mail,cnm,cadd,comment;
  MarketingCreateEdit({Key? key,this.type,this.nm,this.number,this.mail,this.cnm,this.cadd,this.comment}) : super(key: key);

  @override
  State<MarketingCreateEdit> createState() => _MarketingCreateEditState();
}

class _MarketingCreateEditState extends State<MarketingCreateEdit> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController name = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController companyNM = TextEditingController();
  TextEditingController companyAdd = TextEditingController();
  TextEditingController comments = TextEditingController();
  var yesno;
  File? file;
  @override
  void initState() {
    name.text = widget.nm;
    contactNo.text = widget.number;
    email.text = widget.mail;
    companyNM.text = widget.cnm;
    companyAdd.text = widget.cadd;
    comments.text = widget.comment;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      childDecoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("Marketing",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child: Text("Marketing Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                      ),
                      Divider(thickness: 1.5,color: PrimaryColorOne,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: name,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Name',
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
                            controller: contactNo,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Contact No',
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
                            controller: email,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
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
                            controller: companyNM,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Company Name',
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
                            controller: companyAdd,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Company Address',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: PrimaryColorOne
                                    ),
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
                              Padding(
                                  padding: EdgeInsets.all(5),
                                  child: file == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file!.path.split('/').last,style: TextStyle(fontSize: 9),))
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: comments,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Comments',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text("Registered?",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),)
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                    value: "Yes",
                                    groupValue: yesno,
                                    onChanged: (value){
                                      setState(() {
                                        yesno = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                    value: "No",
                                    groupValue: yesno,
                                    onChanged: (value){
                                      setState(() {
                                        yesno = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),color: PrimaryColorOne),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Dicsard",
                                      style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                VerticalDivider(thickness: 1.5,color: Colors.white,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: InkWell(
                                    onTap: (){},
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
