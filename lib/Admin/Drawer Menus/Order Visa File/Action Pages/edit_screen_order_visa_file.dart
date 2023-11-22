// ignore_for_file: missing_return
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/loading_always.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/Order%20Visa%20File/Edit%20Pages/business_visit_page.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/Order%20Visa%20File/Edit%20Pages/family_visit_page.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/Order%20Visa%20File/Edit%20Pages/funding_page.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/Order%20Visa%20File/Edit%20Pages/medical_ground_page.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/Order%20Visa%20File/Edit%20Pages/tourism_page.dart';

import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Edit Pages/academics_page.dart';
import '../Edit Pages/family_inforamtion_page.dart';
import '../Edit Pages/funding_sponsor_page.dart';
import '../Edit Pages/immigration_history_page.dart';
import '../Edit Pages/language_test_Page.dart';
import '../Edit Pages/personal_details_page.dart';
import '../Edit Pages/proposed_studies_page.dart';
import '../Edit Pages/spouse_details_page.dart';
import '../Edit Pages/work_experince_page.dart';
import 'service_requested.dart';


class EditOrderVisaFile extends StatefulWidget {
  var user_id, user_sop_id;
  EditOrderVisaFile({Key? key,this.user_id,this.user_sop_id}) : super(key: key);

  @override
  State<EditOrderVisaFile> createState() => _EditOrderVisaFileState();
}

class _EditOrderVisaFileState extends State<EditOrderVisaFile> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    Map body = {
      'user_id': '${widget.user_id}',
      'user_sop_id': '${widget.user_sop_id}'
    };
    print("Body -> $body");
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchOVFEdit(1, getAccessToken.access_token, body);
      });
    });
    // Future.delayed(const Duration(seconds: 5),(){
    //   openServiceRBox();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  String tabName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DrawerMenuProvider>(
        create: (BuildContext context)=>drawerMenuProvider,
        child: Consumer<DrawerMenuProvider>(
          builder: (context, value, __){
            switch(value.oVFEditData.status!){
              case Status.loading:
                return CenterLoading();
              case Status.error:
                return const ErrorHelper();
              case Status.completed:
                return SafeArea(
                  child: Expanded(
                    child: value.oVFEditData.data!.tabs!.isNotEmpty
                      ? PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: value.oVFEditData.data!.tabs!.length,
                      itemBuilder: (context, index){
                        var tab = value.oVFEditData.data!.tabs;
                        var item = value.oVFEditData.data!.data;
                        switch (tab![index].tab) {
                          case 'Personal Detail':
                            return PersonalDetailsPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Academics':
                          //case 'Personal Detail':
                            return AcademicsPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Language Tests':
                          //case 'Personal Detail':
                            return LanguageTestPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Work Experience':
                          //case 'Personal Detail':
                            return WorkExperincePage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Spouse Details':
                          //case 'Personal Detail':
                            return SpouseDetailsPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Proposed Studies':
                          //case 'Personal Detail':
                            return ProposedStudiesPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Funding / Sponsor':
                          //case 'Personal Detail':
                            return FundingSponsorPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Immigration History':
                          //case 'Personal Detail':
                            return ImmigrationHistoryPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Family Information':
                          //case 'Personal Detail':
                            return FamilyInfoPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Tourism':
                          //case 'Personal Detail':
                            return TourismPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Medical Grounds':
                          //case 'Personal Detail':
                             return MedicalGroundPage(
                               pagecontroller: _pageController,
                               editDetails: item!,
                               tabStatus: tab[index].status,
                               tabName: tab[index].tab,
                               user_id: widget.user_id,
                               user_sop_id: widget.user_sop_id,
                             );
                          case 'Family Visit':
                          //case 'Personal Detail':
                            return FamilyVisitPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Business Visit':
                          //case 'Personal Detail':
                            return BusinessVisitPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Funding':
                          //case 'Personal Detail':
                            return FundingPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    )
                      : Center(child: Text("No Form Data Found",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne),)),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Future openServiceRBox(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 40.0,
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/image/icon.png",width: 50,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (){},
                          child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18),)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "You Can Show Requested to Click on View",
                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: Text("Close",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text("View",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceRequested(u_sop_id: widget.user_sop_id)));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
