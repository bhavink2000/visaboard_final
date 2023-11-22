// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:expandable/expandable.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Drawer Menus/Agent Counter/agent_counter_action.dart';
// import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
// import '../../Api Repository/api_urls.dart';
// import '../../Crud Operation/wallet_crud.dart';
// import '../../Global Service Helper/global_service_helper.dart';
// import '../../Routes/App Routes/app_routes_name.dart';
// import '../../Routes/App Routes/drawer_menus_routes_names.dart';
// import '../../Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
// import '../../Ui Helper/loading.dart';
// import '../../Ui Helper/loading_always.dart';
// import '../../Ui Helper/snackbar_msg_show.dart';
// import '../../Ui Helper/ui_helper.dart';
// import '../../custom_pagination_widget.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
//
// class AgentCounterSearch extends SearchDelegate{
//   var access_token;
//   BuildContext context;
//   AgentCounterSearch({Key key,this.access_token,this.context});
//
//   var jsonData;
//   int curentindex = 0;
//   Future<List<dynamic>> getItemsData(var index) async {
//
//     final url = Uri.parse("${ApiConstants.getAgentCounterList}?page=$index");
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
//                                         ),
//                                         expanded: buildExpanded1(
//                                           item['sopOl'],
//                                           item['sopC'],
//                                           item['enc_agent_id'],
//                                         ),
//                                       ),
//                                       Expandable(
//                                         collapsed: buildCollapsed3(
//                                             item['first_name'],
//                                             item['mobile_no'],
//                                         ),
//                                         expanded: buildExpanded3(
//                                           item['email_id'],
//                                           item['country_name'],
//                                           item['state_name'],
//                                           item['city_name'],
//                                           item['company_name'],
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
//   buildCollapsed1(var agentId) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: PrimaryColorOne,
//       padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//       child: Row(
//         children: [
//           Container(
//               padding: PaddingField,
//               child: Text("Agent Id",style: FrontHeaderID)
//           ),
//           CardDots,
//           Expanded(
//             child: Container(
//                 padding: PaddingField,
//                 child: Text(agentId == null ? "" : "$agentId",style: FrontHeaderNM)
//             ),
//           ),
//           Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
//         ],
//       ),
//     );
//   }
//   buildCollapsed3(var name, var mobile) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Name",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(name == null ? "" : "$name",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Mobie",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: InkWell(
//                 onTap: (){
//                   launch("tel://$mobile");
//                 },
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text(mobile == null ? "" : "$mobile",style: FottorR)
//                 ),
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
//
//   buildExpanded1(var totalT, var totalL, var agent_id) {
//     return Container(
//       color: PrimaryColorOne,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 2.5,
//                   child: Text("Total Application count",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text(totalT == null ? "" : "$totalT",style: BackHeaderTopR)
//                 ),
//               ),
//               Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
//               SizedBox(width: 5,)
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 2.5,
//                   child: Text("Letter type wise count",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentCounterAction(agentId: agent_id,)));
//                         },
//                         child: Text("$totalL" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12,decoration: TextDecoration.underline)))
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   buildExpanded3(var email, var country, var state, var city, var companyNM) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Email",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(email == null ? "" : "$email",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Country",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(country == null ? "" : "$country",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("state",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(state == null ? "" : "$state",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("City",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(city == null ? "" : "$city",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.1,
//                 child: Text("Company Name",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text(companyNM == null ? "" : "$companyNM",style: FottorR)
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget formShowData(String label, TextEditingController controller){
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.width / 7,
//         child: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//               hintText: '$label',
//               hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//           ),
//         ),
//       ),
//     );
//   }
//
// }