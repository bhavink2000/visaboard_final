// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
//
// import 'dart:convert';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
// import '../../Api Repository/api_urls.dart';
// import '../../Ui Helper/loading_always.dart';
// import '../../Ui Helper/ui_helper.dart';
// import '../../custom_pagination_widget.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
//
// class ClientSearch extends SearchDelegate{
//   var access_token;
//   BuildContext context;
//   ClientSearch({Key key,this.access_token,this.context});
//
//   var jsonData;
//   int curentindex = 0;
//   Future<List<dynamic>> getItemsData(var index) async {
//
//     final url = Uri.parse("${ApiConstants.getClientList}?page=$index");
//     final headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $access_token',
//     };
//     final body = {'search_text': query};
//     final response = await http.post(url, headers: headers, body: body);
//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body) as Map<String, dynamic>;
//       final itemList = jsonData['data']['data'] as List<dynamic>;
//       return itemList;
//     } else {
//       throw Exception('Failed to load items');
//     }
//   }
//
//   Future<List> loadNextPage(int page) async {
//     final itemList = await getItemsData(page);
//     return itemList;
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//     icon: const Icon(Icons.arrow_back),
//     onPressed: (){
//       close(context, null);
//     },
//   );
//
//   @override
//   List<Widget> buildActions(BuildContext context) => [
//     IconButton(
//       icon: const Icon(Icons.clear),
//       onPressed: (){
//         if(query.isEmpty) {
//           close(context, null);
//         }
//         else{
//           query = '';
//         }
//       },
//     ),
//   ];
//
//   @override
//   Widget buildResults(BuildContext context){
//     return FutureBuilder<List<dynamic>>(
//       future: getItemsData(curentindex + 1),
//       builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CenterLoading();
//         } else if (snapshot.hasError) {
//           final error = snapshot.error;
//           return Center(child: Text('Error: $error'));
//         } else {
//           final items = snapshot.data;
//           return ListView.builder(
//             padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//             itemCount: items.length,
//             itemBuilder: (BuildContext context, int index) {
//               final item = items[index];
//               return Column(
//                 children: [
//                   ExpandableNotifier(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                         child: ScrollOnExpand(
//                           child: Builder(
//                             builder: (context){
//                               var controller = ExpandableController.of(context, required: true);
//                               return InkWell(
//                                 onTap: (){
//                                   controller.toggle();
//                                 },
//                                 child: Card(
//                                   elevation: 5,
//                                   clipBehavior: Clip.antiAlias,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Expandable(
//                                         collapsed: buildCollapsed1(
//                                           item['id'],
//                                           item['first_name'],
//                                           item['middle_name'],
//                                           item['last_name'],
//                                           item['action'],
//                                         ),
//                                         expanded: buildExpanded1(
//                                           item['order_price'],
//                                           item['order_price'],
//                                         ),
//                                       ),
//                                       Expandable(
//                                         collapsed: buildCollapsed3(
//                                             item['agent_first_name'],
//                                             item['agent_last_name'],
//                                             item['mobile_no']
//                                         ),
//                                         expanded: buildExpanded3(
//                                           item['country_name'],
//                                           item['company_name'],
//                                           item['create_at'],
//                                           item['action'],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       )
//                   ),
//                   if (items.length == 10 || index + 1 != items.length)
//                     Container()
//                   else
//                     SizedBox(height: MediaQuery.of(context).size.height / 4),
//
//                   index + 1 == items.length ? CustomPaginationWidget(
//                     currentPage: curentindex,
//                     lastPage: jsonData['data']['last_page'],
//                     onPageChange: (page) {
//                       curentindex = page - 1;
//                       loadNextPage(curentindex + 1);
//                     },
//                   ) : Container(),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Container();
//   }
//
//   buildCollapsed1(var id, var firstNm, var middleNm, var lastNm, var user_sop_id) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: PrimaryColorOne,
//       padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
//       child: Row(
//         children: [
//           Container(
//               padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//               child: Text("$id" ?? "",style: FrontHeaderID)
//           ),
//           CardDots,
//           Expanded(
//             child: Container(
//                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                 child: Text("$firstNm $middleNm $lastNm" ?? "",style: FrontHeaderNM)
//             ),
//           ),
//           InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: user_sop_id)));
//             },
//             child: Container(
//                 padding: PaddingField,
//                 child: Icon(Icons.menu_open_sharp,color: Colors.white,size: 15,)
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   buildCollapsed3(var afNm, var alNm, var cNo) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.3,
//                 child: Text("Agent Name",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$afNm $alNm" ?? "",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.3,
//                 child: Text("Contact Number",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: InkWell(
//                 onTap: (){
//                   launch("tel://$cNo");
//                 },
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text("$cNo",style: FrontFottorR)
//                 ),
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
//
//   buildExpanded1(var service, var letter) {
//     return Container(
//       color: PrimaryColorOne,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 3.1,
//                   child: Text("Service",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text(service == null ? "" : "$service",style: BackHeaderTopR)
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 3.1,
//                   child: Text("Letter",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text(letter == null ? "" : "$letter",style: BackHeaderTopR)
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   buildExpanded3(var country,var companyNm,var createOn,var user_sop_id) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Foreign Country",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(country == null ? "" : "$country",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Company Name",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(companyNm == null ? "" : "$companyNm",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Create On",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$createOn",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Action",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: user_sop_id,)));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                 child: Container(
//                     padding: PaddingField,
//                     child: Icon(Icons.menu_open_sharp,color: PrimaryColorOne,size: 15,)
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }