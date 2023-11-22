// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Crud Operation/wallet_crud.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Global Service Helper/global_service_helper.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_wallet_data.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';


class WalletPageD extends StatefulWidget{
  WalletPageD({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _WalletPageD();
  }
}

class _WalletPageD extends State<WalletPageD>{

  final GlobalKey<ScaffoldState> key = GlobalKey();
  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();
  final globalService = GlobalService();

  String? selectedAgent;
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchWalletTransaction(1, getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        _fetchAgentList();
      });
    });
  }
  Future<void> _fetchAgentList() async {
    await globalService.getAgentList(getAccessToken.access_token);
    setState(() {});
  }

  List<String> selectedItemValue = [];
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> pch = ["Pending","Success", "Cancel"];
    return pch.map((value) => DropdownMenuItem(
      value: value,
      child: Text(value,style: TextStyle(color: PrimaryColorOne),),
    )).toList();
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
          title: Align(alignment: Alignment.topRight,child: Text("WALLET",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
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
                                      delegate: WalletSearch(access_token: getAccessToken.access_token,context: context)
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
                      openAddWallet();
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nBalance +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                  ),
                ),
              ],
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
                      switch(value.walletTDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.walletTDataList.data!.walletTData!.data!.length,
                              itemBuilder: (context, index){
                                var walletT = value.walletTDataList.data!.walletTData!.data;
                                for (int i = 0; i < value.walletTDataList.data!.walletTData!.data!.length; i++) {
                                  selectedItemValue.add("Pending");
                                }
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
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
                                                                  walletT![index].id,
                                                                  walletT[index].agentFirstName,
                                                                  walletT[index].agentMiddleName,
                                                                  walletT[index].agentLastName
                                                                ),
                                                                expanded: buildExpanded1(index),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  walletT[index].status,
                                                                  index,
                                                                  walletT[index].encId
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  walletT[index].creditAmount,
                                                                  walletT[index].debitAmount,
                                                                  walletT[index].creditDate,
                                                                  walletT[index].debitDate,
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

                                        if (walletT!.length == 10 || index + 1 != walletT.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == walletT.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.walletTDataList.data!.walletTData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchWalletTransaction(curentindex + 1, getAccessToken.access_token);
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
      child: Row(
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
      ),
    );
  }

  buildExpanded1(var index) {
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

  TextEditingController amount = TextEditingController();
  openAddWallet() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: SizedBox(
                        //width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 7,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Agent',
                              hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                          ),
                          value: selectedAgent,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              selectedAgent = value as String?;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              selectedAgent = value as String?;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: globalService.agentList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['first_name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                            );
                          })?.toList() ?? [],
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 7,
                      child: TextField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            hintText: 'amount',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                selectedAgent = null;
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
                              onTap: () async {
                                if (amount.text.isNotEmpty) {
                                  try {
                                    final response = await WalletCrud.addWallet(selectedAgent!, amount.text, getAccessToken.access_token);
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
                                  SnackBarMessageShow.errorMSG('Withdraw amount cannot be empty', context);
                                }
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
              ),
            ),
          );
        }
    );
  }

  Future updateWalletStatus(var eId, var selectedStatus)async{
    var status = selectedStatus == "Pending" ? 0 : selectedStatus == "Success" ? 1 : 2;
    if (status != null) {
      try {
        final response = await WalletCrud.updateWallet(eId, status, getAccessToken.access_token);
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

