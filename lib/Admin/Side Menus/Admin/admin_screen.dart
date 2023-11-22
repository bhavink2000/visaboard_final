// ignore_for_file: missing_return

import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import '../../App Helper/Search Data/Side Menus Search Data/search_admin_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/no_data_helper.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../side_menu.dart';
import 'Auto Login/admin_login_dashboard.dart';
import 'admin_create_edit.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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
        sideMenuProvider.fetchAdmin(1, getAccessToken.access_token);
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
        title: Align(alignment: Alignment.topRight,child: Text("ADMIN",style: AllHeader)),
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
                                    delegate: AdminSearch(context: context,access_token: getAccessToken.access_token));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminCreateEdit(type: 'Create')));
                  },
                  child: Align(alignment: Alignment.topLeft,child: Text("Add \nAdmin +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: MainWhiteContainerDecoration,
              padding: MainWhiteContinerTopPadding,
              child: ChangeNotifierProvider<SideMenuProvider>(
                create: (BuildContext context) => sideMenuProvider,
                child: Consumer<SideMenuProvider>(
                  builder: (context, value, _){
                    switch(value.adminDataList.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: value.adminDataList.data!.adminmdata!.adminsdata!.isNotEmpty ? ListView.builder(
                            itemCount: value.adminDataList.data!.adminmdata!.adminsdata!.length,
                            itemBuilder: (context, index){
                              var adminlistSData = value.adminDataList.data!.adminmdata!.adminsdata;
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
                                                              collapsed: buildCollapsed1(adminlistSData![index].id,adminlistSData[index].firstName),
                                                              expanded: buildExpanded1(),
                                                            ),
                                                            Expandable(
                                                              collapsed: buildCollapsed3(
                                                                  adminlistSData[index].emailId,
                                                                  adminlistSData[index].mobileNo,
                                                                adminlistSData[index].id,
                                                                adminlistSData[index].firstName,
                                                                adminlistSData[index].middleName,
                                                                adminlistSData[index].lastName,
                                                                adminlistSData[index].emailId,
                                                              ),
                                                              expanded: buildExpanded3(
                                                                adminlistSData[index].id,
                                                                adminlistSData[index].firstName,
                                                                adminlistSData[index].middleName,
                                                                adminlistSData[index].lastName,
                                                                adminlistSData[index].emailId,
                                                                adminlistSData[index].mobileNo,
                                                                adminlistSData[index].status,
                                                                adminlistSData[index].date,
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

                                      if (adminlistSData!.length == 10 || index + 1 != adminlistSData.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 4),

                                      index + 1 == adminlistSData.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: sideMenuProvider.adminDataList.data!.adminmdata!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          sideMenuProvider.fetchAdmin(curentindex + 1, getAccessToken.access_token);
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
  buildCollapsed1(id, name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
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
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(email, mobile,id, fnm, mnm, lnm, mail) {
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
                ],
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
              ],
            )
          ],
        ),
      ],
    );
  }
}
