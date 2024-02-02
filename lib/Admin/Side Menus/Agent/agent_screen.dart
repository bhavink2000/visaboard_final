// ignore_for_file: missing_return

import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Get%20Access%20Token/get_access_token.dart';

import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import '../../App Helper/Search Data/Side Menus Search Data/search_agent_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/no_data_helper.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../side_menu.dart';
import 'agent_create_edit.dart';
import 'agent_log_history.dart';
import 'agent_wallet_screen.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({Key? key}) : super(key: key);

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {

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
        sideMenuProvider.fetchAgent(1, getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff0052D4),
      appBar: AppBar(
        title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("AGENT",style: AllHeader))),
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
                                    delegate: AgentSearch(context: context, access_token: getAccessToken.access_token)
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentCreateEdit(type: 'Create',access_token: getAccessToken.access_token)));
                    //openAgentBox();
                  },
                  child: Align(alignment: Alignment.topLeft,child: Text("Add \nAgent +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                ),
              ),
            ],
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
                    switch(value.agentDataList.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: value.agentDataList.data!.agentmdata!.agentsdata!.isNotEmpty ? ListView.builder(
                            itemCount: value.agentDataList.data!.agentmdata!.agentsdata!.length,
                            itemBuilder: (context, index){
                              var agentSData = value.agentDataList.data!.agentmdata!.agentsdata;

                              DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(agentSData![index].createdAt!);
                              var inputDate = DateTime.parse(parseDate.toString());
                              var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                              var outputDate = outputFormat.format(inputDate);

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
                                                              collapsed: buildCollapsed1(agentSData[index].id,agentSData[index].firstName),
                                                              expanded: buildExpanded1(agentSData[index].companyName,agentSData[index].status,),
                                                            ),
                                                            Expandable(
                                                              collapsed: buildCollapsed3(
                                                                agentSData[index].id,
                                                                agentSData[index].firstName,
                                                                agentSData[index].middleName,
                                                                agentSData[index].lastName,
                                                                agentSData[index].companyName,
                                                                agentSData[index].emailId,
                                                                agentSData[index].mobileNo,
                                                                agentSData[index].status,
                                                                agentSData[index].countryName,
                                                                agentSData[index].stateName,
                                                                agentSData[index].cityName,
                                                                agentSData[index].date,
                                                              ),
                                                              expanded: buildExpanded3(
                                                                agentSData[index].id,
                                                                agentSData[index].firstName,
                                                                agentSData[index].middleName,
                                                                agentSData[index].lastName,
                                                                agentSData[index].companyName,
                                                                agentSData[index].emailId,
                                                                agentSData[index].mobileNo,
                                                                agentSData[index].status,
                                                                agentSData[index].countryName,
                                                                agentSData[index].stateName,
                                                                agentSData[index].cityName,
                                                                agentSData[index].date,
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

                                      if (agentSData.length == 10 || index + 1 != agentSData.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 3.1),

                                      index + 1 == agentSData.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: sideMenuProvider.agentDataList.data!.agentmdata!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          sideMenuProvider.fetchAgent(curentindex + 1, getAccessToken.access_token);
                                        },
                                      ) : Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ) : const NoDataHelper(),
                        );
                    }
                  },
                ),
              ),
            ),
          )
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
  buildCollapsed3(id, fnm, mnm, lnm, cnm, mail, mobile, status, country, state, city, date) {
    return Container(
      color: Colors.white,
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
                    child: Text(mail ?? "",style: FottorR)
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
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Action",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentWalletScreen(
                          id: id ?? "",
                        )));
                      },
                      child: Icon(Icons.wallet,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentLogHistory(
                          id: id ?? "",
                        )));
                      },
                      child: Icon(Icons.history,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentCreateEdit(
                          type: 'Edit',
                          access_token: getAccessToken.access_token,
                          id: id,
                          fNM: fnm,
                          mNM: mnm,
                          lNM: lnm,
                          companyNM: cnm,
                          email: mail,
                          mobileNo: mobile,
                          country: country,
                          state: state,
                          city: city,
                          status: status,
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  buildExpanded1(cnm, status) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("Company",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(cnm ?? "",style: BackHeaderTopR)
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
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("Status",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(status ?? "",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(id, fnm, mnm, lnm, cnm, mail, mobile, status, country, state, city, date) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("Country",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(country ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("State",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(state ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("City",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(city ?? "",style: FottorR)
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
                    child: Text(date ?? "",style: FottorR)
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentWalletScreen(
                          id: id ?? "",
                        )));
                      },
                      child: Icon(Icons.wallet,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentLogHistory(
                          id: id ?? "",
                        )));
                      },
                      child: Icon(Icons.history,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentCreateEdit(
                          type: 'Edit',
                          access_token: getAccessToken.access_token,
                          id: id,
                          fNM: fnm,
                          mNM: mnm,
                          lNM: lnm,
                          companyNM: cnm,
                          email: mail,
                          mobileNo: mobile,
                          country: country,
                          state: state,
                          city: city,
                          status: status,
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
