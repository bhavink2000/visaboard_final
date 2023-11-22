// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../Api Repository/api_urls.dart';
import '../../Routes/App Routes/app_routes_name.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/snackbar_msg_show.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class TransactionSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  TransactionSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getTransactionList}?page=$index");
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
                                          item['user_id'],
                                          item['first_name'],
                                          item['last_name'],
                                        ),
                                        expanded: buildExpanded1(
                                          item['order_price'],
                                          item['order_price'],
                                        ),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                            item['service_name'],
                                            item['letter_type_name']
                                        ),
                                        expanded: buildExpanded3(
                                            item['invoice_id'],
                                            item['agent_first_name'],
                                            item['agent_last_name'],
                                            item['payment_date'],
                                            item['cancel_date'],
                                            item['cancel_status'],
                                            item['action'],
                                            item['status'],
                                            item['enc_id'],
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

  buildCollapsed1(var uId, var fNM, var lNM) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("$uId" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$fNM $lNM" ?? "",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(var sType, var lType) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Service",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$sType" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Letter",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$lType" ?? "",style: FottorR)
              ),
            )
          ],
        )
      ],
    );
  }

  buildExpanded1(var orderprice, var allowUSD) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("Price",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(allowUSD == '1' ? "" : "$orderprice" ?? "",style: BackHeaderTopR)
                ),
              ),
              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
              SizedBox(width: 5,)
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text("USD Price",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(allowUSD != '1' ? " " :"$orderprice" ?? "",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var invoice, var agentFNM, var agentLNM,var paymenton, var cancelon,var cancelStatus,var action, var status,var id) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        showFottorData('Invoice Number', '$invoice'),
        showFottorData('Agent Name', '$agentFNM $agentLNM'),
        showFottorData('Payment On', '$paymenton'),
        showFottorData('Cancel On', '$cancelon'),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Action",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            action == '1' ? Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
              child: Container(
                  padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                  color: Colors.red.withOpacity(0.5),
                  child: Text("cancel",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),)),
            ) : action == '2' ? InkWell(
              onTap: (){
                openActionButton(id);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Container(
                    padding: PaddingField,
                    child: Icon(Icons.menu_open_sharp,color: PrimaryColorOne,size: 15)
                ),
              ),
            ) : Container(),
          ],
        ),
      ],
    );
  }

  Widget showFottorData(var label, var data){
    return Row(
      children: [
        Container(
            padding: PaddingField,
            width: MediaQuery.of(context).size.width / 3.5,
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
  openActionButton(var id) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 40.0,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/image/icon.png",width: 50,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Are you sure you want to cancel order? Agent will get refund into their system wallet.",
                      style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: Text("Cancel",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text("Ok",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        onPressed: (){
                          cancelTransactionRecord(id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> cancelTransactionRecord(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${access_token}',
    };
    try {
      final response = await http.get(Uri.parse("${ApiConstants.getCancelTransactionRecord}?id=$id"), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.transaction);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }
}