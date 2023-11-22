// ignore_for_file: missing_return

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_cancel_transaction.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class CancelTransactionPage extends StatefulWidget{
  CancelTransactionPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CancelTransactionPage();
  }
}

class _CancelTransactionPage extends State<CancelTransactionPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchCancelTransaction(1, getAccessToken.access_token);
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
          title: Align(alignment: Alignment.topRight,child: Text("CANCEL TRANSACTION",style: AllHeader)),
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
                                delegate: CancelTransactionSearch(access_token: getAccessToken.access_token,context: context)
                            );
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.cancelTDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.cancelTDataList.data!.cancelTData!.data!.length,
                              itemBuilder: (context, index){
                                var cancelT = value.cancelTDataList.data!.cancelTData!.data;
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
                                                                  cancelT![index].id,
                                                                  cancelT[index].firstName,
                                                                  cancelT[index].middleName,
                                                                  cancelT[index].lastName
                                                                ),
                                                                expanded: buildExpanded1(
                                                                  cancelT[index].price
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  cancelT[index].serviceName,
                                                                  cancelT[index].letterTypeName,
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  cancelT[index].agentFirstName,
                                                                  cancelT[index].agentLastName,
                                                                  cancelT[index].paymentDate,
                                                                  cancelT[index].createAt,
                                                                  cancelT[index].cancelStatus
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

                                        if (cancelT!.length == 10 || index + 1 != cancelT.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == cancelT.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.cancelTDataList.data!.cancelTData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchCancelTransaction(curentindex + 1, getAccessToken.access_token);
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

  buildCollapsed1(var id, var f_nm, var m_nm, var l_nm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                child: Text("$f_nm $m_nm $l_nm",style: FrontHeaderNM)
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
        ],
      ),
    );
  }
  buildCollapsed3(var s_nm, var l_nm) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Service Type",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$s_nm" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Letter Type",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$l_nm" ?? "",style: FottorR)
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
            Container(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: Text("Cancel",style: TextStyle(color: Colors.red,fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontWeight: FontWeight.bold))
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1(var price) {
    return Container(
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text("Price",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$price" ?? "",style: BackHeaderTopR)
                ),
              ),
              const Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,)
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var a_fnm, var a_lnm, var payment_on, var cancel_on, var cancel_status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Agent Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$a_fnm $a_lnm",style: FottorR)
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
                  child: Text("$payment_on" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Cancel On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$cancel_on" ?? "",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }
}