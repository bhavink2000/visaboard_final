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
import '../../../Drawer Menus/Credential/credential_create_edit.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../../Drawer Menus/Supplier/supplier_create_edit.dart';
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

class SupplierSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  SupplierSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getSupplierList}?page=$index");
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
                                          item['contact_person_name'],
                                        ),
                                        expanded: buildExpanded1(
                                          item['university_name'],
                                          item['university_email_id'],
                                        ),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['agency_name'],
                                          item['contact_number'],
                                          item['agency_email_id'],
                                          item['id'],
                                          item['university_name'],
                                          item['university_email_id'],
                                          item['agency_name'],
                                          item['contact_person_name'],
                                          item['contact_number'],
                                          item['country_name'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['admin_first_name'],
                                          item['admin_last_name'],
                                          item['country_name'],
                                          item['agency_email_id'],
                                          item['create_at'],
                                          item['id'],
                                          item['university_name'],
                                          item['university_email_id'],
                                          item['agency_name'],
                                          item['contact_person_name'],
                                          item['contact_number'],
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
                    SizedBox(height: MediaQuery.of(context).size.height / 1.9),

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

  buildCollapsed1(var id, var name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("$id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text(name == null ? "" : "$name",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(var agencyNM, var mobile,var agencyEId,var id,var uNm, var uEmail, var aNM,var cNm,var cNo,var country) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Agency Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(agencyNM == null ? '' : "$agencyNM",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Contact Number",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: (){
                    launch("tel://$mobile");
                  },
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierCreateEdit(
                          type: 'Edit',
                          countryId: country,
                          uniNM: uNm == null ? '' : '$uNm',
                          unEm: uEmail == null ? '' : '$uEmail',
                          agencynm: aNM == null ? '' : '$aNM',
                          agencyemail: agencyEId == null ? '' : '$agencyEId',
                          contactp: cNm == null ? '' : '$cNm',
                          contactno: cNo == null ? '' : '$cNo',
                          id: id,
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
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
                                        deleteSupplier(id);
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

  buildExpanded1(var universityNM, var universityEmail) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("University Name",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(universityNM == null ? "" : "$universityNM",style: BackHeaderTopR)
                ),
              ),
              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
              SizedBox(width: 5,),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("University Email ID",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(universityEmail == null ? "" : "$universityEmail",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var subAdminFNM, var subAdminLNM, var country, var agencyEmail, var createOn, var id,var uNm, var uEmail, var aNM,var cNm,var cNo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Sub Admin Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$subAdminFNM $subAdminLNM" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$country" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Agency Email ID",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(agencyEmail == null ? "" : "$agencyEmail"?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$createOn" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierCreateEdit(
                        type: 'Edit',
                        countryId: country,
                        uniNM: uNm == null ? '' : '$uNm',
                        unEm: uEmail == null ? '' : '$uEmail',
                        agencynm: aNM == null ? '' : '$aNM',
                        agencyemail: agencyEmail == null ? '' : '$agencyEmail',
                        contactp: cNm == null ? '' : '$cNm',
                        contactno: cNo == null ? '' : '$cNo',
                        id: id,
                      )));
                    },
                    child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                  ),
                ),
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
                                      deleteSupplier(id);
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

  Future<void> deleteSupplier(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${access_token}',
    };
    try {
      final response = await http.get(Uri.parse("${ApiConstants.getSupplierDelete}$id/delete"), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.supplier);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}