// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Drawer Menus/Agent Counter/agent_counter_action.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../Api Repository/api_urls.dart';
import '../../Crud Operation/wallet_crud.dart';
import '../../Global Service Helper/global_service_helper.dart';
import '../../Routes/App Routes/app_routes_name.dart';
import '../../Routes/App Routes/drawer_menus_routes_names.dart';
import '../../Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../Ui Helper/loading.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/snackbar_msg_show.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class MarketingSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  MarketingSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getMarketingList}?page=$index");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    final body = {'search_text': query};
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final itemList = jsonData['data']['data'] as List<dynamic>;
      return itemList;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List> loadNextPage(int page) async {
    final itemList = await getItemsData(page);
    return itemList;
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: (){
      close(context, null);
    },
  );

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty) {
          close(context, null);
        }
        else{
          query = '';
        }
      },
    ),
  ];

  final name = TextEditingController();
  final contactNo = TextEditingController();
  final email = TextEditingController();
  final companyNM = TextEditingController();
  final companyAdd = TextEditingController();
  final comments = TextEditingController();
  var yesno;
  File? file;

  @override
  Widget buildResults(BuildContext context){
    return FutureBuilder<List<dynamic>>(
      future: getItemsData(curentindex + 1),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CenterLoading();
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(child: Text('Error: $error'));
        } else {
          final items = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            itemCount: items!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Column(
                children: [
                  ExpandableNotifier(
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
                                          item['id'],
                                          item['name'],
                                        ),
                                        expanded: buildExpanded1(
                                          item['name'],
                                          item['subadmin_name'],
                                        ),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['contact_number'],
                                          item['id'],
                                          item['name'],
                                          item['contact_number'],
                                          item['email_id'],
                                          item['company_name'],
                                          item['company_address'],
                                          item['photo'],
                                          item['comment'],
                                          item['is_registered'],
                                          item['create_at'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['id'],
                                          item['name'],
                                          item['contact_number'],
                                          item['email_id'],
                                          item['company_name'],
                                          item['company_address'],
                                          item['photo'],
                                          item['comment'],
                                          item['is_registered'],
                                          item['create_at'],
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
                  if (items.length == 10 || index + 1 != items.length)
                    Container()
                  else
                    SizedBox(height: MediaQuery.of(context).size.height / 1.6),

                  index + 1 == items.length ? CustomPaginationWidget(
                    currentPage: curentindex,
                    lastPage: jsonData['data']['last_page'],
                    onPageChange: (page) {
                      curentindex = page - 1;
                      loadNextPage(curentindex + 1);
                    },
                  ) : Container(),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
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
    return Column(
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
    return Column(
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
      'Authorization': 'Bearer ${access_token}',
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
    dio.options.headers["authorization"] = "Bearer ${access_token}";
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