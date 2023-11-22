// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Side Menus/Admin/admin_create_edit.dart';
import '../../Api Repository/api_urls.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';

class AdminSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  AdminSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getAdminList}?page=$index");
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
                                            item['mobile_no']
                                        ),
                                        expanded: buildExpanded3(
                                          item['id'],
                                          item['first_name'],
                                          item['middle_name'],
                                          item['last_name'],
                                          item['email_id'],
                                          item['mobile_no'],
                                          item['status'],
                                          item['date'],
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

  buildCollapsed1(id, name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Id. $id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text(name ?? "",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(email, mobile) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Email",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(email ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Mobile",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: (){
                    launch("tel://$mobile");
                  },
                  child: Container(
                      padding: PaddingField,
                      child: Text(mobile ?? "",style: FottorR)
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3(id, fnm, mnm, lnm, mail, mobile, status, createat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Status",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(status ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(createat ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Action",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCreateEdit(
                        type: 'Edit',
                        id: id ?? "",
                        afnm: fnm ?? "",
                        amnm: mnm ?? "",
                        alnm: lnm ?? "",
                        aemail: mail ?? "",
                        amobile: mobile ?? "",
                      )));
                    },
                    child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                    },
                    child: Icon(Icons.history,color: PrimaryColorOne,size: 20,),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLoginDashboard()));
                    },
                    child: Icon(Icons.login,color: PrimaryColorOne,size: 20,),
                  ),
                ),*/
              ],
            )
          ],
        ),
      ],
    );
  }
}