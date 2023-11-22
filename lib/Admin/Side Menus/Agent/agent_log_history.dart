// ignore_for_file: missing_return

import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import '../../App Helper/Search Data/Side Menus Search Data/search_agent_log_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/no_data_helper.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../side_menu.dart';

class AgentLogHistory extends StatefulWidget {
  var id;
  AgentLogHistory({Key? key,this.id}) : super(key: key);

  @override
  State<AgentLogHistory> createState() => _AgentLogHistoryState();
}

class _AgentLogHistoryState extends State<AgentLogHistory> {

  GetAccessToken getAccessToken = GetAccessToken();
  SideMenuProvider sideMenuProvider = SideMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        Map sendData = {
          'id': widget.id.toString()
        };
        sideMenuProvider.fetchAgentLog(1, getAccessToken.access_token,sendData);
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
      backgroundColor: Color(0xff0052D4),
      appBar: AppBar(
        title: InkWell(onTap: (){Navigator.pop(context);},child: Align(alignment: Alignment.topRight,child: Text("AGENT LOG HISTORY",style: AllHeader))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
                  builder: (context) {
                    return BackdropFilter(filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),child: SideMenus());
                  }
              );
            },
            icon: Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              children: [
                Flexible(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                            delegate: AgentLogSearch(context: context, access_token: getAccessToken.access_token)
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: search.isEmpty
                          ? Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Icons.search,color: PrimaryColorOne),
                      )
                          : Padding(
                        padding: EdgeInsets.all(2),
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
                child: ChangeNotifierProvider<SideMenuProvider>(
                  create: (BuildContext context) => sideMenuProvider,
                  child: Consumer<SideMenuProvider>(
                    builder: (context, value, _){
                      switch(value.agentLogDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: value.agentLogDataList.data!.data!.data!.isNotEmpty ? ListView.builder(
                              itemCount: value.agentLogDataList.data!.data!.data!.length,
                              itemBuilder: (context, index){
                                var agentLogSData = value.agentLogDataList.data!.data!.data;
                                DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(agentLogSData![index].createdAt!);
                                var inputDate = DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                                var outputDate = outputFormat.format(inputDate);

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: Column(
                                      children: [
                                        FadeInAnimation(
                                          child: ExpandableNotifier(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                child: ScrollOnExpand(
                                                  child: Builder(
                                                    builder: (context){
                                                      var controller = ExpandableController.of(context, required: true);
                                                      return InkWell(
                                                        onTap: (){
                                                          //controller.toggle();
                                                        },
                                                        child: Card(
                                                          elevation: 5,
                                                          clipBehavior: Clip.antiAlias,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expandable(
                                                                collapsed: buildCollapsed1(agentLogSData[index].id,agentLogSData[index].firstName),
                                                                expanded: buildExpanded1(),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(agentLogSData[index].emailId,agentLogSData[index].mobileNo, agentLogSData[index].clickUrl, agentLogSData[index].content, outputDate),
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
                                        ),
                                        if (agentLogSData.length == 10 || index + 1 != agentLogSData.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 3),

                                        index + 1 == agentLogSData.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: sideMenuProvider.agentLogDataList.data!.data!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            sideMenuProvider.fetchAgentLog(curentindex + 1, getAccessToken.access_token,sendData);
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
          )
        ],
      ),
    );
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
