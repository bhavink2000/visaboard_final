// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_agent_qr_code_data.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
class AgentQRCodePage extends StatefulWidget{
  AgentQRCodePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AgentQRCodePage();
  }
}

class _AgentQRCodePage extends State<AgentQRCodePage>{

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
        drawerMenuProvider.fetchAgentQRCode(1, getAccessToken.access_token,'');
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  var imageURL = "https://visaboard.in/assets/uploads/agent/";
  Future<ImageProvider?> loadImageFromNetworkURL(var image) async {
    try {
      final response = await http.get(Uri.parse('$imageURL$image'));
      if (response.statusCode == 200) {
        return MemoryImage(response.bodyBytes);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    Map data = {
      'search_text': search
    };
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
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("AGENT QR",style: AllHeader)),
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
                              hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                            suffixIcon: Container(
                              width: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: (){
                                        drawerMenuProvider.fetchAgentQRCode(1, getAccessToken.access_token,data);
                                      },
                                      child: const Icon(Icons.search)
                                  ),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          search = '';
                                        });
                                        drawerMenuProvider.fetchAgentQRCode(1, getAccessToken.access_token,'');
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
                          onTap: (){
                            showSearch(
                                context: context,
                                delegate: AgentQRSearch(access_token: getAccessToken.access_token,context: context)
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
                      switch(value.agentQRCodeDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.agentQRCodeDataList.data!.aqrData!.agents!.agrsData!.length,
                              itemBuilder: (context, index){
                                var agentQRCode = value.agentQRCodeDataList.data!.aqrData!.agents!.agrsData;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: Column(
                                      children: [
                                        FadeInAnimation(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                            child: Card(
                                              elevation: 10,
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                              shadowColor: PrimaryColorTwo.withOpacity(0.8),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                //height: MediaQuery.of(context).size.height / 3,
                                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),color: PrimaryColorOne),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: MediaQuery.of(context).size.height / 3.5,
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: ContinerPaddingInside,
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(20),
                                                              topLeft: Radius.circular(20),
                                                              bottomLeft: Radius.circular(30),
                                                              bottomRight: Radius.circular(30)
                                                          ),color: Colors.white,
                                                        /*image: DecorationImage(
                                                          image: NetworkImage("$imageURL${agentQRCode[index].orCodeImage}"),
                                                        )*/
                                                      ),
                                                      child: FutureBuilder(
                                                        future: loadImageFromNetworkURL(agentQRCode![index].orCodeImage),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.done) {
                                                            if (snapshot.hasError || snapshot.data == null) {
                                                              return Center(
                                                                child: Text(
                                                                  'No QR Code',
                                                                  style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                                                              );
                                                            } else {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                    image: snapshot.data!,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            return CenterLoading();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(6),
                                                            child: Text("${agentQRCode[index].firstName ?? ""} ${agentQRCode[index].lastName ?? ""}",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        if (agentQRCode.length == 12 || index + 1 != agentQRCode.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == agentQRCode.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.agentQRCodeDataList.data!.aqrData!.agents!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchAgentQRCode(curentindex + 1, getAccessToken.access_token,data);
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
}