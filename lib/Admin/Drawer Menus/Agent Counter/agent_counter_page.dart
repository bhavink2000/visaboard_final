// ignore_for_file: non_constant_identifier_names, missing_return

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_agent_counter_data.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import 'agent_counter_action.dart';

class AgentCounterPage extends StatefulWidget{
  AgentCounterPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AgentCounterPage();
  }
}

class _AgentCounterPage extends State<AgentCounterPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  File? file;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchAgentCounter(1, getAccessToken.access_token,'');
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
          title: Align(alignment: Alignment.topRight,child: Text("Agent Counter",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
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
                                      suffixIcon: Container(
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: (){
                                                  drawerMenuProvider.fetchAgentCounter(1, getAccessToken.access_token,data);
                                                },
                                                child: const Icon(Icons.search)
                                            ),
                                            InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    search = '';
                                                  });
                                                  drawerMenuProvider.fetchAgentCounter(1, getAccessToken.access_token,'');
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
                                      delegate: AgentCounterSearch(access_token: getAccessToken.access_token,context: context)
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
                  padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                  child: TextButton(
                    onPressed: (){
                      openAgentCounterBox();
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nAgent +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
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
                      switch(value.agentCounterDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.agentCounterDataList.data!.agentCounterData!.data!.length,
                              itemBuilder: (context, index){
                                var agentCounter = value.agentCounterDataList.data!.agentCounterData!.data;
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
                                                                  agentCounter![index].id
                                                                ),
                                                                expanded: buildExpanded1(
                                                                    agentCounter[index].sopOl,
                                                                    agentCounter[index].sopC,
                                                                  agentCounter[index].encAgentId
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                    agentCounter[index].firstName,
                                                                    agentCounter[index].mobileNo
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  agentCounter[index].emailId,
                                                                  agentCounter[index].countryName,
                                                                  agentCounter[index].stateName,
                                                                  agentCounter[index].cityName,
                                                                  agentCounter[index].companyName
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

                                        if (agentCounter!.length == 10 || index + 1 != agentCounter!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == agentCounter.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.agentCounterDataList.data!.agentCounterData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchAgentCounter(curentindex + 1, getAccessToken.access_token,data);
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
      ),
    );
  }

  buildCollapsed1(var agentId) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Agent Id",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text(agentId == null ? "" : "$agentId",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(var name, var mobile) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(name == null ? "" : "$name",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Mobie",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: InkWell(
                onTap: (){
                  launch("tel://$mobile");
                },
                child: Container(
                    padding: PaddingField,
                    child: Text(mobile == null ? "" : "$mobile",style: FottorR)
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  buildExpanded1(var totalT, var totalL, var agent_id) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text("Total Application count",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(totalT == null ? "" : "$totalT",style: BackHeaderTopR)
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
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text("Letter type wise count",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentCounterAction(agentId: agent_id,)));
                        },
                        child: Text("$totalL" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12,decoration: TextDecoration.underline)))
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var email, var country, var state, var city, var companyNM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Email",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(email == null ? "" : "$email",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(country == null ? "" : "$country",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("state",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(state == null ? "" : "$state",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("City",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(city == null ? "" : "$city",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Company Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(companyNM == null ? "" : "$companyNM",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }

  String status = "";
  File? image;
  final first_name = TextEditingController();
  final middle_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();

  openAgentCounterBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Agents Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                            InkWell(
                              onTap: (){Navigator.pop(context);},
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: PrimaryColorOne),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.close,color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5,color: PrimaryColorOne,),
                      formShowData('First Name', first_name),
                      formShowData('Middle Name', middle_name),
                      formShowData('Last Name', last_name),
                      formShowData('Email', email),
                      formShowData('Mobile', mobile),
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: PrimaryColorOne
                                    ),
                                    onPressed: ()async {
                                      try{
                                        FilePickerResult? pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                        if(pickedfile != null){
                                          setState((){
                                            file = File(pickedfile.files.single.path!);
                                          });
                                        }
                                      }
                                      on PlatformException catch (e) {
                                        print(" File not Picked ");
                                      }
                                    },
                                    child: file == null
                                        ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                        : const Text("File Picked",style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text("Status?",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),)
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                    value: "Active",
                                    groupValue: status,
                                    onChanged: (value){
                                      setState(() {
                                        status = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("In-Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                    value: "InActive",
                                    groupValue: status,
                                    onChanged: (value){
                                      setState(() {
                                        status = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                ),
                                child: Text("Discard",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                addAgent();
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                ),
                                child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),textAlign: TextAlign.center,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
    );
  }

  Widget formShowData(String label, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 7,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: '$label',
              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
          ),
        ),
      ),
    );
  }

  Future addAgent()async{
    LoadingIndicater().onLoad(true, context);
    var aStatus = status == "Active" ? 1 : 0;

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'first_name': first_name.text,
      'middle_name' : middle_name.text,
      'last_name': last_name.text,
      'email_id': email.text,
      'mobile_no': mobile.text,
      'status': aStatus.toString(),
      'image': await MultipartFile.fromFile(file!.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    });

    await dio.post(
        ApiConstants.getAgentCounterAdd,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        file = null;
        SnackBarMessageShow.successsMSG('SuccessFully Perform', context);
        Navigator.pushNamed(context, DrawerMenusName.agent_counter);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 400){
        file = null;
        SnackBarMessageShow.errorMSG('Email Id Has Already Been Taken', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 401){
        file = null;
        SnackBarMessageShow.errorMSG('Unauthorised Expired', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else{
        file = null;
        print("error code${response.statusCode}");
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }).onError((error, stackTrace){
      print("error=> $error");
    });
  }
}