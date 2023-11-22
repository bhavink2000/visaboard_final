// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Side Menus/Agent/agent_create_edit.dart';
import '../../../Side Menus/Agent/agent_log_history.dart';
import '../../../Side Menus/Agent/agent_wallet_screen.dart';
import '../../Api Repository/api_urls.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class AgentLogSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  AgentLogSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getAgentLogHistory}?page=$index");
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
                                          item['first_name'],
                                        ),
                                        expanded: buildExpanded1(),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['email_id'],
                                          item['mobile_no'],
                                          item['click_url'],
                                          item['content'],
                                          item['created_at'],
                                        ),
                                        expanded: buildExpanded3(),
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

  buildCollapsed1(id, fnm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
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
                child: Text(fnm ?? "",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(mail, mobile, link, content, date) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Email",style: FottorL)
              ),
              Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(mail ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Mobile",style: FottorL)
              ),
              Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(mobile ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Log Link",style: FottorL)
              ),
              Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: InkWell(
                        onTap: (){
                          launch(link);
                        },
                        child: Text(content ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 12,decoration: TextDecoration.underline)))
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Create On",style: FottorL)
              ),
              Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(date ?? "",style: FottorR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3() {
    return Container();
  }
}