
// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Dashboard%20Data%20Provider/dashboard_data_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/loading_always.dart';
import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import 'ApplyForms/apply_forms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  GetAccessToken getAccessToken = GetAccessToken();
  DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        dashboardDataProvider.fetchDashBoardCounter(1, getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                  child: AnimationLimiter(
                    child: AnimationConfiguration.staggeredList(
                      position: 3,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Text(
                            "Hi, \nSuper Admin",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: Constants.OPEN_SANS,

                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,//color: Colors.yellow,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: ChangeNotifierProvider<DashboardDataProvider>(
                create: (BuildContext context)=>dashboardDataProvider,
                child: Consumer<DashboardDataProvider>(
                  builder: (context, value, __){
                    switch(value.dashBoardCounterData.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return AnimationLimiter(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                childAspectRatio: 2.3/2
                            ),
                            itemCount: value.dashBoardCounterData.data!.data!.length,
                            itemBuilder: (context, index) {
                              var dashBoardCounter = value.dashBoardCounterData.data!.data;
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 800),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Card(
                                        color: const Color(0xff0a6fb8),
                                        elevation: 8,
                                        shadowColor: PrimaryColorOne.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                '${dashBoardCounter![index].serviceName}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Constants.OPEN_SANS,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding: ContinerPaddingInside,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                                    child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          "Active  : ${dashBoardCounter[index].activeServiceCount}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: Constants.OPEN_SANS
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: Divider(
                                                      color: Color(0xff0a6fb8),
                                                      thickness: 1.5,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                                    child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          "Total : ${dashBoardCounter[index].serviceCount}",
                                                          style: TextStyle(
                                                              fontFamily: Constants.OPEN_SANS,
                                                              fontSize: 15),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
}
