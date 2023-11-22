// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../Api Repository/api_urls.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class AgentQRSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  AgentQRSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getAgentQRCodeList}?page=$index");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    final body = {'agent_name': query};
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final itemList = jsonData['data']['agents']['data'] as List<dynamic>;
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      shadowColor: PrimaryColorTwo.withOpacity(0.8),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),color: PrimaryColorOne),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              padding: ContinerPaddingInside,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)
                                ),color: Colors.white,
                                /*image: DecorationImage(
                                                          image: NetworkImage("$imageURL${agentQRCode[index].orCodeImage}"),
                                                        )*/
                              ),
                              child: FutureBuilder(
                                future: loadImageFromNetworkURL(items[index]['image'],items[index]['or_code_image']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.hasError || snapshot.data == null) {
                                      return Center(
                                        child: Text(
                                          'No QR Code',
                                          style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                                      );
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: snapshot.data!,
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return CenterLoading();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text("${items[index]['first_name'] ?? ""} ${items[index]['last_name'] ?? ""}",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (items.length == 10 || index + 1 != items.length)
                    Container()
                  else
                    SizedBox(height: MediaQuery.of(context).size.height / 2.2),

                  index + 1 == items.length ? CustomPaginationWidget(
                    currentPage: curentindex,
                    lastPage: jsonData['data']['agents']['last_page'],
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

  Future<ImageProvider?> loadImageFromNetworkURL(var url,var image) async {
    try {
      final response = await http.get(Uri.parse('$url$image'));
      if (response.statusCode == 200) {
        return MemoryImage(response.bodyBytes);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }
}