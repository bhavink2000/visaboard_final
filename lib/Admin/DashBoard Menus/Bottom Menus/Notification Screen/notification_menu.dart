// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Search%20Data/search_notification_data.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../../App Helper/Ui Helper/loading.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../App Helper/custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Drawer Menus/Client/client_add_page.dart';
import '../../../Drawer Menus/Order Visa File/Action Pages/chat_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Action Pages/edit_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Action Pages/upload_docs_screen.dart';
import 'chat_screen_notification.dart';
import 'edit_screen_notification.dart';
import 'upload_docs_notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        dashboardDataProvider.fetchNotification(1, getAccessToken.access_token);
      });
    });
  }

  List<String>? selectedItemValue = [];
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> pch = ["Process", "Complete", "Hold"];
    return pch.map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    )).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                    delegate: NotificationSearch(context: context,access_token: getAccessToken.access_token)
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientAddPage()));
                  },
                  child: Align(alignment: Alignment.topLeft,child: Text("Add \nApplicant +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne))),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: ChangeNotifierProvider<DashboardDataProvider>(
                create: (BuildContext context)=>dashboardDataProvider,
                child: Consumer<DashboardDataProvider>(
                  builder: (context, value, __){
                    switch(value.notificationData.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.notificationData.data!.notificationData!.data!.length,
                            itemBuilder: (context, index){
                              var notifi = value.notificationData.data!.notificationData!.data;
                              for (int i = 0; i < notifi!.length; i++) {
                                selectedItemValue!.add("Process");
                              }
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
                                                                notifi[index].userId,
                                                                notifi[index].firstName,
                                                                notifi[index].lastName,
                                                              ),
                                                              expanded: buildExpanded1(
                                                                index,
                                                                notifi[index].action!.editStatus ?? 0,
                                                                notifi[index].action!.sendMsg4UploadDocsStatus ?? 0,
                                                                notifi[index].action!.uploadDocsStatus ?? 0,
                                                                notifi[index].action!.chatStatus ?? 0,
                                                                notifi[index].action!.addSubdomainStatus ?? 0,
                                                                notifi[index].action!.invoicePdfStatus ?? 0,
                                                                  notifi[index].encUserId,
                                                                  notifi[index].encId,
                                                                  notifi[index].invoicePdf,
                                                                  notifi[index].id,
                                                                  notifi[index].encId,
                                                                  notifi[index].firstName,
                                                                  notifi[index].lastName,
                                                                  notifi[index].serviceName,
                                                                  notifi[index].letterTypeName,
                                                                  notifi[index].countryName,
                                                                  notifi[index].orderPrice,
                                                                notifi[index].showDropdown,
                                                                notifi[index].statusDropdown
                                                              ),
                                                            ),
                                                            Expandable(
                                                              collapsed: buildCollapsed3(
                                                                notifi[index].agentFirstName,
                                                                notifi[index].agentLastName,
                                                                notifi[index].adminFirstName,
                                                                notifi[index].adminLastName,
                                                                  index,
                                                                  notifi[index].action!.editStatus ?? 0,
                                                                  notifi[index].action!.sendMsg4UploadDocsStatus ?? 0,
                                                                  notifi[index].action!.uploadDocsStatus ?? 0,
                                                                  notifi[index].action!.chatStatus ?? 0,
                                                                  notifi[index].action!.addSubdomainStatus ?? 0,
                                                                  notifi[index].action!.invoicePdfStatus ?? 0,
                                                                  notifi[index].encUserId,
                                                                  notifi[index].encId,
                                                                  notifi[index].invoicePdf,
                                                                  notifi[index].id,
                                                                  notifi[index].encId,
                                                                  notifi[index].firstName,
                                                                  notifi[index].lastName,
                                                                  notifi[index].serviceName,
                                                                  notifi[index].letterTypeName,
                                                                  notifi[index].countryName,
                                                                  notifi[index].orderPrice,
                                                                  notifi[index].showDropdown,
                                                                  notifi[index].statusDropdown
                                                              ),
                                                              expanded: buildExpanded3(
                                                                notifi[index].serviceName,
                                                                notifi[index].letterTypeName,
                                                                notifi[index].countryName,
                                                                notifi[index].orderPrice,
                                                                notifi[index].companyName,
                                                                notifi[index].updateAt,
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

                                      if (notifi.length == 10 || index + 1 != notifi.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 1.75),

                                      index + 1 == notifi.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: dashboardDataProvider.notificationData.data!.notificationData!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          dashboardDataProvider.fetchNotification(curentindex + 1, getAccessToken.access_token);
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
              )
            ),
          )
        ],
      ),
    );
  }

  buildCollapsed1(var userId, var fnm, var lnm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Client Id. $userId" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$fnm $lnm",style: FrontHeaderNM)
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(var afNm, var alNm, var adfNm, var adlNm,
      var index,var edit, var msg, var docs, var chat, var subdomain, var invoice,var user_id, var user_sop_id, var invoiceNm,
      var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var showDropdown,var statusD
      ) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Agent Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$afNm $alNm",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Admin Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$adfNm $adlNm",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Status",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: showDropdown == 1 ? Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.height / 20,
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.white,
                      decoration: const InputDecoration(border: InputBorder.none,
                          hintText: 'Status', hintStyle: TextStyle(fontSize: 10)
                      ),
                      items: _dropDownItem(),
                      value: selectedItemValue![index].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily: Constants.OPEN_SANS,decoration: TextDecoration.underline,color: PrimaryColorOne),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedItemValue![index] = value!;
                          var oStatus = selectedItemValue![index] == 'Process'
                              ? 2
                              : selectedItemValue![index] == 'Complete'
                              ? 1
                              : 3;
                          print("oStatus -> $oStatus");
                          openChangesStatusMessageBox(user_sop_id, oStatus);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          selectedItemValue![index] = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    )
                ) : Container(
                  padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                  child: Text(statusD == 'Payment Pending' ? "$statusD" : "$statusD",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.red),),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black,fontSize: 12))
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.mail,color: PrimaryColorOne,size: 15,),
                    ),
                  ),
                  docs == 0 ? Container() : InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                    },
                    child: Padding(
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.chat,color: PrimaryColorOne,size: 15,),
                    ),
                  ),
                  subdomain == 0 ? Container() : InkWell(
                    onTap: (){
                      addSubdomain(user_id, user_sop_id);
                    },
                    child: Padding(
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
      ),
    );
  }

  buildExpanded1(var index,var edit, var msg, var docs, var chat, var subdomain, var invoice,var user_id, var user_sop_id, var invoiceNm,
      var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var showDropdown,var statusD) {
    return Container(
      /*color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Status",style: BackHeaderTopL)
              ),
              CardDots,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: showDropdown == 1 ? Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    height: MediaQuery.of(context).size.height / 20,
                    child: DropdownButtonFormField(
                      dropdownColor: PrimaryColorOne,
                      decoration: const InputDecoration(border: InputBorder.none,
                          hintText: 'Status', hintStyle: TextStyle(fontSize: 10)
                      ),
                      items: _dropDownItem(),
                      value: selectedItemValue[index].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily: Constants.OPEN_SANS,decoration: TextDecoration.underline,color: Colors.white),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedItemValue[index] = value;
                          var oStatus = selectedItemValue[index] == 'Process'
                              ? 2
                              : selectedItemValue[index] == 'Complete'
                              ? 1
                              : 3;
                          print("oStatus -> $oStatus");
                          openChangesStatusMessageBox(user_sop_id, oStatus);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          selectedItemValue[index] = value;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
                    )
                ) : Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(statusD == 'Payment Pending' ? "$statusD" : "$statusD",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.red),),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
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
                  docs == 0 ? Container() : InkWell(
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
              )
            ],
          ),
        ],
      ),*/
    );
  }
  buildExpanded3(var sType, var lType, var country, var oPrice, var cNm, var updateOn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Service",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$sType",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Letter Type",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$lType",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$country",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Order Price	",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("₹$oPrice",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Company Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$cNm",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Updated On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$updateOn",style: FottorR)
              ),
            )
          ],
        ),
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
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.close,color: Colors.white,),
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
                                  _selectedValueemail = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValueemail = value;
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
                                  selectedItemValue = null;
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
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
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
        Navigator.pushNamed(context, AppRoutesName.dashboard);
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

  openChangesStatusMessageBox(var uSopId, var oVFStatus){
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
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: message,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Message',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
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
                                  message.text = '';
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
                                  changesOVFStatus(uSopId, oVFStatus);
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
                  ],
                );
              },
            ),
          );
        }
    );
  }

  Future changesOVFStatus(var uSopId, var oVFStatus)async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop_id': uSopId,
      'status' : oVFStatus,
      'user_inbox[message]': message.text,
    });
    var response = await dio.post(
        ApiConstants.getOVFChanges,
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
        Navigator.pushNamed(context, AppRoutesName.dashboard);
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
      'Authorization': 'Bearer ${getAccessToken.access_token}',
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
        Navigator.pushNamed(context, AppRoutesName.dashboard);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}
