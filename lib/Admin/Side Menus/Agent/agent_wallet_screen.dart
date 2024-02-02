// ignore_for_file: missing_return

import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import '../../App Helper/Search Data/Side Menus Search Data/search_agent_wallet_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/no_data_helper.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../side_menu.dart';

class AgentWalletScreen extends StatefulWidget {
  var id;
  AgentWalletScreen({Key? key,this.id}) : super(key: key);

  @override
  State<AgentWalletScreen> createState() => _AgentWalletScreenState();
}

class _AgentWalletScreenState extends State<AgentWalletScreen> {

  GetAccessToken getAccessToken = GetAccessToken();
  SideMenuProvider sideMenuProvider = SideMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        Map sendData = {
          'id': widget.id.toString()
        };
        sideMenuProvider.fetchAgentWallet(1, getAccessToken.access_token,sendData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map sendData = {
      'id': widget.id.toString()
    };
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff0052D4),
      appBar: AppBar(
        title: InkWell(onTap: (){Navigator.pop(context);},child: Align(alignment: Alignment.topRight,child: Text("AGENT WALLET",style: AllHeader))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
                  builder: (context) {
                    return BackdropFilter(filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),child: SideMenus());
                  }
              );
            },
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
                            hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS)
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        onTap: (){
                          showSearch(
                            context: context,
                            delegate: AgentWalletSearch(context: context,access_token: getAccessToken.access_token));
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: search.isEmpty
                          ? Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(Icons.search,color: PrimaryColorOne),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(Icons.close, color: PrimaryColorOne,),
                      )
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: MainWhiteContainerDecoration,
              padding: MainWhiteContinerTopPadding,
              child: ChangeNotifierProvider<SideMenuProvider>(
                create: (BuildContext context) => sideMenuProvider,
                child: Consumer<SideMenuProvider>(
                  builder: (context, value, _){
                    switch(value.agentWalletDataList.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: value.agentWalletDataList.data!.data!.data!.isNotEmpty ? ListView.builder(
                            itemCount: value.agentWalletDataList.data!.data!.data!.length,
                            itemBuilder: (context, index){

                              var agentWalletTranSData = value.agentWalletDataList.data!.data!.data;

                              DateTime creditdate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(agentWalletTranSData![index].creditDate ?? "0000-00-00 00:00:00");
                              var cinputdate = DateTime.parse(creditdate.toString());
                              var coutputformat = DateFormat('MM/dd/yyyy hh:mm a');
                              var creditDate = coutputformat.format(cinputdate);

                              DateTime refunddate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(agentWalletTranSData![index].refundDate ?? "0000-00-00 00:00:00");
                              var rinputdate = DateTime.parse(refunddate.toString());
                              var routputformat = DateFormat('MM/dd/yyyy hh:mm a');
                              var refundDate = routputformat.format(rinputdate);

                              DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(agentWalletTranSData![index].createdAt ?? "0000-00-00 00:00:00");
                              var inputDate = DateTime.parse(parseDate.toString());
                              var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                              var createdAtDate = outputFormat.format(inputDate);

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
                                                              collapsed: buildCollapsed1(agentWalletTranSData[index].id,agentWalletTranSData[index].firstName),
                                                              expanded: buildExpanded1(agentWalletTranSData[index].creditAmount,agentWalletTranSData[index].debitAmount),
                                                            ),
                                                            Expandable(
                                                              collapsed: buildCollapsed3(agentWalletTranSData[index].serviceName,agentWalletTranSData[index].letterTypeName),
                                                              expanded: buildExpanded3(agentWalletTranSData[index].orderPrice,creditDate,refundDate),
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

                                      if (agentWalletTranSData.length == 10 || index + 1 != agentWalletTranSData.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 1.68),

                                      index + 1 == agentWalletTranSData.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: sideMenuProvider.agentWalletDataList.data!.data!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          sideMenuProvider.fetchAgentWallet(curentindex + 1, getAccessToken.access_token,sendData);
                                        },
                                      ) : Container()
                                    ],
                                  ),
                                ),
                              );
                            },
                          ) : NoDataHelper(),
                        );
                    }
                  },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
  buildCollapsed1(id, fnm) {
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
                child: Text(fnm ?? "",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(snm, lnm) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Service Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(snm ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Letter Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(lnm ?? "",style: FottorR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  buildExpanded1(credit, debit) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Credit",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$credit" ?? "",style: BackHeaderTopR)
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
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Debit",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$debit" ?? "",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(lprice, cancel,refund) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Letter Price",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$lprice" ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Payment On",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("" ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Cancel",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(cancel ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Refund On",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(refund ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Action",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("",style: FottorR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
