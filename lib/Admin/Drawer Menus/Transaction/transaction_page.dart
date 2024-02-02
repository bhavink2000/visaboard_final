// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Drawer%20Data%20Provider/drawer_menu_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_transaction_data.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class TransactionPage extends StatefulWidget{
  TransactionPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TransactionPage();
  }
}

class _TransactionPage extends State<TransactionPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  final exportDate = TextEditingController();
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchTransaction(1, getAccessToken.access_token);
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("TRANSACTION",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                          delegate: TransactionSearch(access_token: getAccessToken.access_token,context: context)
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
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            //barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                contentPadding: const EdgeInsets.only(top: 10.0),
                                content: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState){
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: MediaQuery.of(context).size.width / 6,
                                              child: TextField(
                                                controller: exportDate,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                    labelText: "Month Year"
                                                ),
                                                onTap: () async {
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101)
                                                  );
                                                  if(pickedDate != null ){
                                                    String formattedDate = DateFormat('yyyy-MM').format(pickedDate);
                                                    setState(() {
                                                      exportDate.text = formattedDate;
                                                    });
                                                  }else{
                                                    Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                                  }
                                                },
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
                                                        exportDate.clear();
                                                        Navigator.pop(context);
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
                                                        exportDocs('Export');
                                                      },
                                                      child: Text(
                                                        "Export",
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
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                        child: Text("Export",style: TextStyle(fontFamily: Constants.OPEN_SANS)),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            //barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                contentPadding: const EdgeInsets.only(top: 10.0),
                                content: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState){
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: MediaQuery.of(context).size.width / 6,
                                              child: TextField(
                                                controller: exportDate,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                    labelText: "Month Year"
                                                ),
                                                onTap: () async {
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101)
                                                  );
                                                  if(pickedDate != null ){
                                                    String formattedDate = DateFormat('yyyy-MM').format(pickedDate);
                                                    setState(() {
                                                      exportDate.text = formattedDate;
                                                    });
                                                  }else{
                                                    Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                                  }
                                                },
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
                                                        exportDate.clear();
                                                        Navigator.pop(context);
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
                                                        exportDocs('Download');
                                                      },
                                                      child: Text(
                                                        "Download",
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
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                        child: Text("Download",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.transactionDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.transactionDataList.data!.transactionData!.data!.length,
                              itemBuilder: (context, index){
                                var transactionData = value.transactionDataList.data!.transactionData!.data;
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
                                                                  transactionData![index].userId,
                                                                  transactionData[index].firstName,
                                                                  transactionData[index].lastName
                                                                ),
                                                                expanded: buildExpanded1(
                                                                  transactionData[index].orderPrice,
                                                                  transactionData[index].allowUsd
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  transactionData[index].serviceName,
                                                                  transactionData[index].letterTypeName
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  transactionData[index].invoiceId,
                                                                  transactionData[index].agentFirstName,
                                                                  transactionData[index].agentLastName,
                                                                  transactionData[index].paymentDate,
                                                                  transactionData[index].cancelDate,
                                                                  '${transactionData[index].cancelStatus}',
                                                                  '${transactionData[index].action}',
                                                                  '${transactionData[index].status}',
                                                                  transactionData[index].encId
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

                                        if (transactionData!.length == 10 || index + 1 != transactionData!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == transactionData.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.transactionDataList.data!.transactionData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchTransaction(curentindex + 1, getAccessToken.access_token);
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
                ),
              ),
            )
          ],
        ),
      ),
    );
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
    return Container(
      color: Colors.white,
      child: Column(
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
      ),
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
              SizedBox(width: 5,),
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
    return Container(
      color: Colors.white,
      child: Column(
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
      ),
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
            backgroundColor: Colors.white,
            content: Column(
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
          );
        }
    );
  }

  Future<void> cancelTransactionRecord(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
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

  var pdfData;
  Future<void> exportDocs(type) async {

    final url = Uri.parse(type == 'Export' ? ApiConstants.getTransactionExport : ApiConstants.getTransactionDownlaod);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    final body = {'month_year': exportDate.text};
    final response = await http.post(url, headers: headers, body: body);
    var pdfData = response.bodyBytes;

    if (response.statusCode == 200) {
      final file = type == 'Export' ? File('/storage/emulated/0/Download/visaBoard_xlsx_file.xlsx') : File('/storage/emulated/0/Download/visaBoard_zip_file.zip');
      await file.writeAsBytes(pdfData);
      Fluttertoast.showToast(msg: "$file");
      exportDate.clear();
      Navigator.pop(context);
      setState(() {});
    }
    else if(response.statusCode == 500){
      Fluttertoast.showToast(msg: "No File Found");
      exportDate.clear();
      Navigator.pop(context);
    }
    else {
      exportDate.clear();
      throw Exception('Failed to load items');
    }
  }
}