// ignore_for_file: missing_return

import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/no_data_helper.dart';
import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../side_menu.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
        sideMenuProvider.fetchContactUs(1, getAccessToken.access_token);
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
        title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("CONTACT US",style: AllHeader))),
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
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: MainWhiteContainerDecoration,
              padding: MainWhiteContinerTopPadding,
              child: ChangeNotifierProvider<SideMenuProvider>(
                create: (BuildContext context)=> sideMenuProvider,
                child: Consumer<SideMenuProvider>(
                  builder: (context, value, _){
                    switch(value.contactUsDataList.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: ListView.builder(
                            itemCount: value.contactUsDataList.data!.data!.data!.length,
                            itemBuilder: (context, index){
                              final contactUsData = value.contactUsDataList.data!.data!.data!;
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
                                                        //controller.toggle();
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        clipBehavior: Clip.antiAlias,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Expandable(
                                                              collapsed: buildCollapsed1(
                                                                  contactUsData[index].id,
                                                                  contactUsData[index].firstName,
                                                                  contactUsData[index].lastName
                                                              ),
                                                              expanded: buildExpanded1(),
                                                            ),
                                                            Expandable(
                                                              collapsed: buildCollapsed3(
                                                                  contactUsData[index].emailId,
                                                                  contactUsData[index].mobileNo
                                                              ),
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

                                      if (contactUsData.length == 10 || index + 1 != contactUsData.length)
                                        Container()
                                      else
                                        SizedBox(height: MediaQuery.of(context).size.height / 4),

                                      index + 1 == contactUsData.length ? CustomPaginationWidget(
                                        currentPage: curentindex,
                                        lastPage: sideMenuProvider.contactUsDataList.data!.data!.lastPage!,
                                        onPageChange: (page) {
                                          setState(() {
                                            curentindex = page - 1;
                                          });
                                          sideMenuProvider.fetchContactUs(curentindex + 1, getAccessToken.access_token);
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
    );
  }
  buildCollapsed1(var id, var fname, var lname) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
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
                child: Text("$fname $lname",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(var email, var mobile) {
    return Column(
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
                  child: Text("$email" ?? "",style: FottorR)
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
                onTap: ()=>launch("tel://$mobile"),
                child: Container(
                    padding: PaddingField,
                    child: Text("$mobile" ?? "",style: FottorR)
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3() {
    return Container();
  }
}
