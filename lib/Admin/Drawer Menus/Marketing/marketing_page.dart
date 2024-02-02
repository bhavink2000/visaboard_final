// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_marketing_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class MarketingPage extends StatefulWidget{
  const MarketingPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MarketingPage();
  }
}

class _MarketingPage extends State<MarketingPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  final name = TextEditingController();
  final contactNo = TextEditingController();
  final email = TextEditingController();
  final companyNM = TextEditingController();
  final companyAdd = TextEditingController();
  final comments = TextEditingController();
  var yesno;
  File? file;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchMarketing(1, getAccessToken.access_token);
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("MARKETING",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        children: [
                          Flexible(
                            child: Card(
                              elevation: 8,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(40))
                                ),
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                      suffixIcon: const Icon(Icons.search)
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      search = value;
                                    });
                                  },
                                  onTap: (){
                                    showSearch(
                                      context: context,
                                      delegate: MarketingSearch(access_token: getAccessToken.access_token,context: context)
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                  child: TextButton(
                    onPressed: (){
                      openAddNew(
                          'Create',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          ''
                      );
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MarketingCreateEdit(type: 'Create')));
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nNew +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.marketingDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.marketingDataList.data!.marketingData!.data!.length,
                              itemBuilder: (context, index){
                                var marketingData = value.marketingDataList.data!.marketingData!.data;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: Column(
                                      children: [
                                        FadeInAnimation(
                                          child: ExpandableNotifier(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                child: ScrollOnExpand(
                                                  child: Builder(
                                                    builder: (context){
                                                      var controller = ExpandableController.of(context, required: true);
                                                      return InkWell(
                                                        onTap: (){
                                                          controller!.toggle();
                                                        },
                                                        child: Card(
                                                          elevation: 5,
                                                          clipBehavior: Clip.antiAlias,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expandable(
                                                                collapsed: buildCollapsed1(
                                                                  marketingData![index].id,
                                                                  marketingData[index].name,
                                                                ),
                                                                expanded: buildExpanded1(
                                                                    marketingData[index].name,
                                                                    marketingData[index].subadminName
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                    marketingData[index].contactNumber,
                                                                    marketingData[index].id,
                                                                    marketingData[index].name,
                                                                    marketingData[index].contactNumber,
                                                                    marketingData[index].emailId,
                                                                    marketingData[index].companyName,
                                                                    marketingData[index].companyAddress,
                                                                    marketingData[index].photo,
                                                                    marketingData[index].comment,
                                                                    marketingData[index].isRegistered,
                                                                    marketingData[index].createAt
                                                                ),
                                                                expanded: buildExpanded3(
                                                                    marketingData[index].id,
                                                                    marketingData[index].name,
                                                                    marketingData[index].contactNumber,
                                                                    marketingData[index].emailId,
                                                                    marketingData[index].companyName,
                                                                    marketingData[index].companyAddress,
                                                                    marketingData[index].photo,
                                                                    marketingData[index].comment,
                                                                    marketingData[index].isRegistered,
                                                                    marketingData[index].createAt
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),

                                        if (marketingData!.length == 10 || index + 1 != marketingData!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == marketingData.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.marketingDataList.data!.marketingData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchMarketing(curentindex + 1, getAccessToken.access_token);
                                          },
                                        ) : Container(),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildCollapsed1(var id,var name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("ID. $id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text(
                    "$name" ?? "",
                    style: FrontHeaderNM
                )
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
          SizedBox(width: 5,)
        ],
      ),
    );
  }
  buildCollapsed3(var mobile,var id,var nm, var cNo, var mail, var cNM, var companyAdd,var photo,var comment,var registered,var createdOn) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          showDataFront('Email', '$mail'),
          showDataFront('Company Name', '$cNM'),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Contact Number	",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: ()=>launch("tel://$mobile"),
                  child: Container(
                      padding: PaddingField,
                      child: Text("$mobile" ?? "",style: FottorR)
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Action",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        openAddNew('Edit', nm, cNo, mail, cNM, companyAdd, comment, registered,id);
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('VisaBoard Alert Dialog'),
                                content: const Text('Do you really want to delete?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        deleteMarketing(id);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); //close Dialog
                                    },
                                    child: const Text('Close'),
                                  )
                                ],
                              );
                            }
                        );
                      },
                      child: Icon(Icons.delete,color: PrimaryColorOne,size: 20,),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget showDataFront(var label, var data){
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 3.3,
            child: Text(
                "$label",
                style: FottorL
            )
        ),
        const Text(":",style: TextStyle(color: Colors.black)),
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text(
                  "$data" ?? "",
                  style: FottorR
              )
          ),
        ),
      ],
    );
  }

  buildExpanded1(var nm, var subANm) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          showDataBackTop('Sub Admin Name', '$subANm'),
        ],
      ),
    );
  }
  Widget showDataBackTop(var label, var data){
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("$label",style: BackHeaderTopL)
        ),
        CardDots,
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$data" ?? "",style: BackHeaderTopR)
          ),
        ),
        Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
        SizedBox(width: 5,)
      ],
    );
  }

  buildExpanded3(var id,var nm, var cNo, var mail, var cNM, var companyAdd,var photo,var comment,var registered,var createdOn) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          showDataBackSub('Company Address', '$companyAdd'),
          showDataBackSub('Photo', '$photo'),
          showDataBackSub('Comment', '$comment'),
          showDataBackSub('Registered', '$registered'),
          showDataBackSub('Created on', '$createdOn'),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Action",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        openAddNew('Edit', nm, cNo, mail, cNM, companyAdd, comment, registered,id);
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('VisaBoard Alert Dialog'),
                                content: const Text('Do you really want to delete?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        deleteMarketing(id);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); //close Dialog
                                    },
                                    child: const Text('Close'),
                                  )
                                ],
                              );
                            }
                        );
                      },
                      child: Icon(Icons.delete,color: PrimaryColorOne,size: 20,),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget showDataBackSub(var label, var data){
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 4,
            child: Text("$label",style: FottorL)
        ),
        const Text(":",style: TextStyle(color: Colors.black)),
        Expanded(
          child: Container(
              padding: PaddingField,
              child: Text("$data" ?? "",style: FottorR)
          ),
        )
      ],
    );
  }

  openAddNew(String type,String nm, String cNo, String mail, String cNm, String cAdd, String comment, String register, var id) {
    name.text = nm;
    contactNo.text = cNo;
    email.text = mail;
    companyNM.text = cNm;
    companyAdd.text = cAdd;
    comments.text = comment;

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Marketing Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                            InkWell(
                              onTap: (){Navigator.pop(context);},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: PrimaryColorOne),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.close,color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5,color: PrimaryColorOne,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.all(7),
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
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
                                        print("e -> $e");
                                      }
                                    },
                                    child: file == null
                                        ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                        : const Text("File Picked",style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: file == null
                                      ? const Text("No File Chosen",style: TextStyle(fontSize: 12))
                                      : Container(width: 120, child: Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9)))
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(50)),color: PrimaryColorOne),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: InkWell(
                                    onTap: (){
                                      file = null;
                                      yesno = null;
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Discard",
                                      style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(thickness: 1.5,color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: InkWell(
                                    onTap: (){
                                      if(name.text.isEmpty || contactNo.text.isEmpty || email.text.isEmpty || companyNM.text.isEmpty || companyAdd.text.isEmpty || comments.text.isEmpty){
                                        Fluttertoast.showToast(msg: 'Fill Required Field',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                      }
                                      else{
                                        if(file == null && yesno == ""){
                                          Fluttertoast.showToast(msg: 'Please Select File & Status',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                        }
                                        else{
                                          //print("callng");
                                          createEditMarketing(type,id);
                                        }
                                      }
                                    },
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
                  );
                },
              ),
            ),
          );
        }
    );
  }

  Future<void> deleteMarketing(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.get(Uri.parse("${ApiConstants.getMarketingDelete}$id/delete"), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.marketing);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

  Future createEditMarketing(var type, var id)async{
    LoadingIndicater().onLoad(true, context);
    var registeredStatus = yesno == "Yes" ? 1 : 0;

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = type == 'Create' ? FormData.fromMap({
      'name': name.text,
      'contact_number' : contactNo.text,
      'email_id': email.text,
      'company_name': companyNM.text,
      'company_address': companyAdd.text,
      'comment': comments.text,
      'registered' : registeredStatus.toString(),
      'photo': await MultipartFile.fromFile(file!.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    }) : FormData.fromMap({
      'name': name.text,
      'id' : id,
    });

    await dio.post(
        type == 'Create' ? ApiConstants.getMarketingAdd : ApiConstants.getMarketingUpdate,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        file = null;
        SnackBarMessageShow.successsMSG('SuccessFully Perform', context);
        Navigator.pushNamed(context, DrawerMenusName.marketing);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 400){
        file = null;
        SnackBarMessageShow.errorMSG('Email Id Has Already Been Taken', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 401){
        file = null;
        SnackBarMessageShow.errorMSG('Unauthorised Expired', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else{
        file = null;
        print("error code${response.statusCode}");
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }).onError((error, stackTrace){
      print("error=> $error");
    });
  }
}