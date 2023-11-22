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
import '../../../Drawer Menus/Order Visa File/Action Pages/chat_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Action Pages/edit_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Action Pages/upload_docs_screen.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../Api Repository/api_urls.dart';
import '../../Routes/App Routes/app_routes_name.dart';
import '../../Routes/App Routes/drawer_menus_routes_names.dart';
import '../../Ui Helper/loading.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/snackbar_msg_show.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class OVFPaymentSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  OVFPaymentSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getOrderVisaFileList}?page=$index");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    final body = {'search_text': query,'status_as': '9'};
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
                                          item['first_name'],
                                          item['last_name'],
                                        ),
                                        expanded: buildExpanded1(
                                          item['action']['edit_status'],
                                          item['action']['send_msg_4_upload_docs_status'],
                                          item['action']['upload_docs_status'],
                                          item['action']['chat_status'],
                                          item['action']['add_subdomain_status'],
                                          item['action']['invoice_pdf_status'],
                                          item['enc_user_id'],
                                          item['enc_id'],
                                          item['invoice_pdf'],
                                          item['id'],
                                          item['enc_id'],
                                          item['first_name'],
                                          item['last_name'],
                                          item['service_name'],
                                          item['letter_type_name'],
                                          item['country_name'],
                                          item['order_price'],
                                        ),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['letter_type_name'],
                                          item['company_name'],
                                          item['action']['edit_status'],
                                          item['action']['send_msg_4_upload_docs_status'],
                                          item['action']['upload_docs_status'],
                                          item['action']['chat_status'],
                                          item['action']['add_subdomain_status'],
                                          item['action']['invoice_pdf_status'],
                                          item['enc_user_id'],
                                          item['enc_id'],
                                          item['invoice_pdf'],
                                          item['id'],
                                          item['enc_id'],
                                          item['first_name'],
                                          item['last_name'],
                                          item['service_name'],
                                          item['letter_type_name'],
                                          item['country_name'],
                                          item['order_price'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['service_name'],
                                          item['agent_first_name'],
                                          item['agent_last_name'],
                                          item['admin_first_name'],
                                          item['admin_last_name'],
                                          item['country_name'],
                                          item['order_price'],
                                          item['update_at'],
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
                    SizedBox(height: MediaQuery.of(context).size.height / 4),

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

  buildCollapsed1(var id, var firstNm, var lastNm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Case Id. $id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$firstNm $lastNm",style: FrontHeaderNM)
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
        ],
      ),
    );
  }
  buildCollapsed3(var letter, var company,var edit, var msg, var upload, var chat, var subdomain ,var invoice,var user_id, var user_sop_id,
      var invoiceNm, var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.3,
                child: Text("Letter",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$letter" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.3,
                child: Text("Company",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(company == null ? "" : "$company",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.3,
                child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black,fontSize: 11))
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Row(
              children: [
                edit == 0 ? Container() :InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.edit,color: PrimaryColorOne,size: 15,),
                  ),
                ),
                msg == 0 ? Container() : InkWell(
                  onTap: (){
                    openSendNewMessage(user_sop_id);
                  },
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.mail,color: PrimaryColorOne,size: 15,),
                  ),
                ),
                upload == 0 ? Container() : InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                  },
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.upload,color: PrimaryColorOne,size: 15,),
                  ),
                ),
                chat == 0 ? Container() : InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenOrderVisaFile(
                      client_id: c_id,
                      c_id: id,
                      client_fnm: c_fnm,
                      client_lnm: c_lnm,
                      service_nm: s_nm,
                      letter_nm: l_nm,
                      country_nm: country_nm,
                      order_p: o_price,
                      u_sop_id: user_sop_id,
                    )));
                  },
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.chat,color: PrimaryColorOne,size: 15,),
                  ),
                ),
                subdomain == 0 ? Container() : InkWell(
                  onTap: (){
                    addSubdomain(user_id, user_sop_id);
                  },
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.cloud_done_outlined,color: PrimaryColorOne,size: 15,),
                  ),
                ),
                invoice == 0 ? Container() : InkWell(
                  onTap: (){
                    launch("$invoiceNm");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.picture_as_pdf_rounded,color: PrimaryColorOne,size: 15,),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1(var edit, var msg, var upload, var chat, var subdomain ,var invoice,var user_id, var user_sop_id,
      var invoiceNm, var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 11))
              ),
              const Text(":",style: TextStyle(color: Colors.white)),
              Row(
                children: [
                  edit == 0 ? Container() :InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.edit,color: Colors.white,size: 15,),
                    ),
                  ),
                  msg == 0 ? Container() : InkWell(
                    onTap: (){
                      openSendNewMessage(user_sop_id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.mail,color: Colors.white,size: 15,),
                    ),
                  ),
                  upload == 0 ? Container() : InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.upload,color: Colors.white,size: 15,),
                    ),
                  ),
                  chat == 0 ? Container() : InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenOrderVisaFile(
                        client_id: c_id,
                        c_id: id,
                        client_fnm: c_fnm,
                        client_lnm: c_lnm,
                        service_nm: s_nm,
                        letter_nm: l_nm,
                        country_nm: country_nm,
                        order_p: o_price,
                        u_sop_id: user_sop_id,
                      )));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.chat,color: Colors.white,size: 15,),
                    ),
                  ),
                  subdomain == 0 ? Container() : InkWell(
                    onTap: (){
                      addSubdomain(user_id, user_sop_id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.cloud_done_outlined,color: Colors.white,size: 15,),
                    ),
                  ),
                  invoice == 0 ? Container() : InkWell(
                    onTap: (){
                      launch("$invoiceNm");
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.picture_as_pdf_rounded,color: Colors.white,size: 15,),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
              SizedBox(width: 5,)
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var service, var agentFnm,var agentLnm, var adminFnm, var adminLnm,var country,var orderPrice, var updateOn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        showFormDataE3('Service', '$service'),
        showFormDataE3('Agent Name', '$agentFnm $agentLnm'),
        showFormDataE3('Admin Name', '$adminFnm $adminLnm'),
        showFormDataE3('Country', '$country'),
        showFormDataE3('Order Price', '$orderPrice'),
        showFormDataE3('Update On', '$updateOn'),
      ],
    );
  }


  Widget showFormDataE3(var label, var data){
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


  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  File? file;
  String? _selectedValueemail;
  List<String> listOfValueemail = ['Complete Email', 'Query Email'];
  openSendNewMessage(var userid) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                          InkWell(
                            onTap: (){Navigator.pop(context);},
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: PrimaryColorOne),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.close,color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5,color: PrimaryColorOne,),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: subject,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Subject',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: message,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select Email Type',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedValueemail,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValueemail = value!;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValueemail = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfValueemail.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
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
                                      ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                      : const Text("File Picked",style: TextStyle(color: Colors.white))
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(30),
                          ),color: PrimaryColorOne
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  file = null;
                                  subject.text = "";
                                  message.text = "";
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
                                  sendMessage(userid);
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
    ).then((value){
    });
  }

  Future sendMessage(var userid)async{
    var emailType = _selectedValueemail == 'Complete Email' ? 1 : 2;
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop_id': userid,
      'user_inbox[subject]' : subject.text,
      'user_inbox[message]': message.text,
      'email_send_type': emailType,
      'user_inbox_file[file][]': await MultipartFile.fromFile(file!.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    });

    var response = await dio.post(
        ApiConstants.SendMessage,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    );
    print("response code ->${response.statusCode}");
    print("response Message ->${response.statusMessage}");
    if(response.statusCode == 200){
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var message = jsonResponse['message'];

      print("Status -> $status");
      print("Message -> $message");

      if (status == 200) {
        SnackBarMessageShow.successsMSG('$message', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
        LoadingIndicater().onLoadExit(false, context);
      } else {
        SnackBarMessageShow.errorMSG('$message', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }
    else{
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
      LoadingIndicater().onLoadExit(false, context);
    }
  }

  Future<void> addSubdomain(var uId, var uSId) async {
    print("callling");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${access_token}',
    };
    try {
      var subDomain = "${ApiConstants.getAddSubDomain}$uId/$uSId/add-subdomain";
      print("url -> $subDomain");
      final response = await http.get(
          Uri.parse(subDomain),
          headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}