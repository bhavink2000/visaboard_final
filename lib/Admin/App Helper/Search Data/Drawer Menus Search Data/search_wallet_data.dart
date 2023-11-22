// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../Api Repository/api_urls.dart';
import '../../Crud Operation/wallet_crud.dart';
import '../../Global Service Helper/global_service_helper.dart';
import '../../Routes/App Routes/app_routes_name.dart';
import '../../Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/snackbar_msg_show.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class WalletSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  WalletSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getWalletTransaction}?page=$index");
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

  String? selectedAgent;
  List<String> selectedItemValue = [];
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> pch = ["Pending","Success", "Cancel"];
    return pch.map((value) => DropdownMenuItem(
      value: value,
      child: Text(value,style: TextStyle(color: PrimaryColorOne),),
    )).toList();
  }

  final globalService = GlobalService();
  Future<void> _fetchAgentList() async {
    await globalService.getAgentList(access_token);
  }
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
                                          item['agent_first_name'],
                                          item['agent_middle_name'],
                                          item['agent_last_name'],
                                        ),
                                        expanded: buildExpanded1(),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                            item['status'],
                                            index,
                                            item['enc_id']
                                        ),
                                        expanded: buildExpanded3(
                                          item['credit_amount'],
                                          item['debit_amount'],
                                          item['credit_date'],
                                          item['debit_date'],
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

  buildCollapsed1(var id, var a_fnm, var a_mnm, var a_lnm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: PaddingField,
      child: Row(
        children: [
          IDDataShow(id: "$id"),
          CardDots,
          Text(" ${a_fnm ?? ''} ${a_mnm ?? ''} ${a_lnm ?? ''}", style: BackHeaderTopR),
          Spacer(),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
          SizedBox(width: 5,),
        ],
      ),
    );
  }
  buildCollapsed3(var status, var index,var e_id) {
    return Container(
      color: Colors.white,
      child: StatefulBuilder(
        builder: (context, StateSetter setState){
          return Row(
            children: [
              Container(
                  padding: PaddingField,
                  //color: Colors.yellow,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Status",style: FrontFottorR)
              ),
              const Text(":",style: TextStyle(color: Colors.black87)),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: status == "Pending"
                      ? SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.width / 9,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        decoration: const InputDecoration(border: InputBorder.none,
                            hintText: 'Status', hintStyle: TextStyle(fontSize: 10,color: Colors.black)
                        ),
                        items: _dropDownItem(),
                        value: selectedItemValue[index].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily: Constants.OPEN_SANS,decoration: TextDecoration.underline),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            selectedItemValue[index] = value!;
                            updateWalletStatus(e_id,selectedItemValue[index]);
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            selectedItemValue[index] = value!;
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
                  )
                      : Container(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Text(
                          "$status",
                          style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              color: status == "Success" ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold
                          )
                      )
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3(var c_am, var d_am, var c_date, var d_date) {
    return Container(
      padding: ContinerPaddingInside,
      //decoration: SubContainerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("Credit Amount",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$c_am",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("Credit Date",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$c_date",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("Debit Amount",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$d_am",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("Debit Date",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$d_date",style: FottorR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future updateWalletStatus(var eId, var selectedStatus)async{
    var status = selectedStatus == "Pending" ? 0 : selectedStatus == "Success" ? 1 : 2;
    if (status != null) {
      try {
        final response = await WalletCrud.updateWallet(eId, status, access_token);
        if (response.statusCode == 200) {
          var jsonResponse = response.data;
          var status = jsonResponse['status'];
          var message = jsonResponse['message'];
          if (status == 200) {
            SnackBarMessageShow.successsMSG('$message', context);
            Navigator.pushNamed(context, DrawerMenusName.wallet_page_d);
          } else {
            Navigator.pop(context);
            SnackBarMessageShow.errorMSG('$message', context);
          }
        } else {
          Navigator.pop(context);
          SnackBarMessageShow.errorMSG('Something went wrong', context);
        }
      } catch (error) {
        Navigator.pop(context);
        SnackBarMessageShow.errorMSG('$error', context);
      }
    } else {
      Navigator.pop(context);
      SnackBarMessageShow.errorMSG('Status cannot be empty', context);
    }
  }
}