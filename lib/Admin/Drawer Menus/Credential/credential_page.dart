// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_credentials_data.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import 'credential_create_edit.dart';
class CredentialPage extends StatefulWidget{
  CredentialPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CredentialPage();
  }
}

class _CredentialPage extends State<CredentialPage>{

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
        drawerMenuProvider.fetchCredential(1, getAccessToken.access_token);
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
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0052D4),
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("CREDENTIAL",style: AllHeader)),
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
                                      delegate: CredentialsSearch(access_token: getAccessToken.access_token, context: context)
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CredentialCreateEdit(type: 'Create')));
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nNew +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
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
                      switch(value.credentialDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.credentialDataList.data!.credentialData!.data!.length,
                              itemBuilder: (context, index){
                                var credential = value.credentialDataList.data!.credentialData!.data;
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
                                                                  credential![index].id
                                                                ),
                                                                expanded: buildExpanded1(),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  credential[index].adminFirstName,
                                                                  credential[index].adminLastName,
                                                                  credential[index].appName,
                                                                  credential[index].link,
                                                                  credential[index].userName,
                                                                  credential[index].userId,
                                                                  credential[index].password,
                                                                  credential[index].createAt,
                                                                  credential[index].id,
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  credential[index].userName,
                                                                  credential[index].userId,
                                                                  credential[index].password,
                                                                  credential[index].createAt,
                                                                  credential[index].id,
                                                                  credential[index].appName,
                                                                  credential[index].link,
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

                                        if (credential!.length == 10 || index + 1 != credential.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == credential.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.credentialDataList.data!.credentialData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchCredential(curentindex + 1, getAccessToken.access_token);
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
  buildCollapsed1(var id) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              //width: MediaQuery.of(context).size.width / 4,
              child: Text("ID : $id" ?? "",style: FrontHeaderID)
          ),
          Spacer(),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
          SizedBox(width: 5)
        ],
      ),
    );
  }
  buildCollapsed3(var adminFnm, var adminLnm, var appNm, var link,var userNm, userId, var password, var createOn, var id) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3,
                child: Text("Sub Admin Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$adminFnm $adminLnm" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3,
                child: Text("App Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$appNm" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3,
                child: Text("Link",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: InkWell(
                      onTap: (){
                        link == null
                          ? Fluttertoast.showToast(msg: "No Url")
                          : launch("$link").then((value){
                            print("Launched URL");
                        }).onError((error, stackTrace){
                          print("error->$error");
                          Fluttertoast.showToast(msg: "Please Check URL is Valid?");
                        });
                      },
                      child: Text(link == null ? "" : "$link",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.blueAccent,fontSize: 12,decoration: TextDecoration.underline)))
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3,
                child: Text("Action",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CredentialCreateEdit(
                          type: 'Edit',
                          aNM: appNm == null ? '' : '$appNm',
                          uNM: userNm == null ? '' : '$userNm',
                          uId: userId == null ? '' : '$userId',
                          password: password == null ? '' : '$password',
                          link: link == null ? '' : '$link',
                          id: id == null ? '' : '$id',
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorTwo,size: 20,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('VisaBoard Alert Dialog'),
                              content: const Text('Do you really want to delete?'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      deleteCredential(id);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); //close Dialog
                                  },
                                  child: const Text('Close'),
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Icon(Icons.delete,color: PrimaryColorTwo,size: 20,),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3(var userNm, userId, var password, var createOn, var id, var appNm,var link) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Username",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(userNm == null ? '' : "$userNm",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("User ID",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$userId" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Password",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$password",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$createOn",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Action",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CredentialCreateEdit(
                          type: 'Edit',
                          aNM: appNm == null ? '' : '$appNm',
                          uNM: userNm == null ? '' : '$userNm',
                          uId: userId == null ? '' : '$userId',
                          password: password == null ? '' : '$password',
                          link: link == null ? '' : '$link',
                          id: id == null ? '' : '$id',
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorTwo,size: 20,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('VisaBoard Alert Dialog'),
                              content: const Text('Do you really want to delete?'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      deleteCredential(id);
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); //close Dialog
                                  },
                                  child: const Text('Close'),
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Icon(Icons.delete,color: PrimaryColorTwo,size: 20,),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Future<void> deleteCredential(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.get(Uri.parse("${ApiConstants.getCredentialDelete}$id/delete"), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.credential);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

}