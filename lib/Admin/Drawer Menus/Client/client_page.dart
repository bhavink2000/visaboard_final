// ignore_for_file: non_constant_identifier_names, missing_return
import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_clients_data.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Order Visa File/order_visa_file.dart';
import '../drawer_menus.dart';
import 'client_action_page.dart';
import 'client_add_page.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ClientPage();
  }
}

class _ClientPage extends State<ClientPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  FocusNode searchFocus = FocusNode();
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchClient(1, getAccessToken.access_token,'');
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    Map data = {
      'search_text': search
    };
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(
        controller: _advancedDrawerController,
      ),
      backdropColor: PrimaryColorOne,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: PrimaryColorOne,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight, child: Text("CLIENT", style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                _advancedDrawerController.showDrawer();
              },
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 30,)
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
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
                                  focusNode: searchFocus,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                      suffixIcon: Container(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                drawerMenuProvider.fetchClient(1, getAccessToken.access_token,data);
                                              },
                                              child: const Icon(Icons.search)
                                            ),
                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  search = '';
                                                });
                                                drawerMenuProvider.fetchClient(1, getAccessToken.access_token,'');
                                              },
                                              child: const Icon(Icons.close)
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      search = value;
                                    });
                                  },
                                  /*onTap: (){
                                    showSearch(
                                        context: context,
                                        delegate: ClientSearch(access_token: getAccessToken.access_token,context: context)
                                    );
                                  },*/
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
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: TextButton(
                    onPressed: (){
                      searchFocus.unfocus();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientAddPage()));
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add +\nApplicant",style: TextStyle(fontSize: 10,fontFamily: Constants.OPEN_SANS,color: Colors.white),textAlign: TextAlign.center)),
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
                      switch(value.clientDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.clientDataList.data!.clientData!.data!.length,
                              itemBuilder: (context, index) {
                                var client = value.clientDataList.data!.clientData!.data;
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
                                                                  client![index].id,
                                                                  client[index].firstName,
                                                                  client[index].middleName,
                                                                  client[index].lastName,
                                                                  client[index].action
                                                                ),
                                                                expanded: buildExpanded1(
                                                                  client[index].serviceName,
                                                                  client[index].letterTypeName
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  client[index].agentFirstName,
                                                                  client[index].agentLastName,
                                                                  client[index].mobileNo
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  client[index].countryName,
                                                                  client[index].companyName,
                                                                  client[index].createAt,
                                                                  client[index].action
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

                                        if (client!.length == 10 || index + 1 != client.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == client.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.clientDataList.data!.clientData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchClient(curentindex + 1, getAccessToken.access_token, data);
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
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  buildCollapsed1(var id, var firstNm, var middleNm, var lastNm, var user_sop_id) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("$id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("$firstNm $middleNm $lastNm" ?? "",style: FrontHeaderNM)
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: user_sop_id)));
            },
            child: Container(
                padding: PaddingField,
                child: Icon(Icons.menu_open_sharp,color: Colors.white,size: 15,)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(var afNm, var alNm, var cNo) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Agent Name",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$afNm $alNm" ?? "",style: FrontFottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Contact Number",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: (){
                    launch("tel://$cNo");
                  },
                  child: Container(
                      padding: PaddingField,
                      child: Text("$cNo",style: FrontFottorR)
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildExpanded1(var service, var letter) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Service",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(service == null ? "" : "$service",style: BackHeaderTopR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Letter",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(letter == null ? "" : "$letter",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var country,var companyNm,var createOn,var user_sop_id) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Foreign Country",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(country == null ? "" : "$country",style: FrontFottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Company Name",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(companyNm == null ? "" : "$companyNm",style: FrontFottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Create On",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$createOn",style: FrontFottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("Action",style: FrontFottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: user_sop_id,)));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Container(
                      padding: PaddingField,
                      child: Icon(Icons.menu_open_sharp,color: PrimaryColorOne,size: 15,)
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}

