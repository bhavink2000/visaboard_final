import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class CredentialCreateEdit extends StatefulWidget {
  var type;
  var aNM,uNM,uId,password,link,id;
  CredentialCreateEdit({Key? key,this.type,this.aNM,this.uNM,this.uId,this.password,this.link,this.id}) : super(key: key);

  @override
  State<CredentialCreateEdit> createState() => _CredentialCreateEditState();
}

class _CredentialCreateEditState extends State<CredentialCreateEdit> {

  GetAccessToken getAccessToken = GetAccessToken();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController? appName = TextEditingController();
  TextEditingController? userName = TextEditingController();
  TextEditingController? userId = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? link = TextEditingController();

  @override
  void initState() {
    getAccessToken.checkAuthentication(context, setState);
    appName!.text = widget.aNM ?? '';
    userName!.text = widget.uNM ?? '';
    userId!.text = widget.uId ?? '';
    password!.text = widget.password ?? '';
    link!.text = widget.link ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
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
          title: Align(alignment: Alignment.topRight,child: Text("CREDENTIAL DETAILS",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),color: Colors.white,),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Card(
                          elevation: 5,
                          color: PrimaryColorOne,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Icon(Icons.app_settings_alt_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: appName,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'App Name',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Card(
                          elevation: 5,
                          color: PrimaryColorOne,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Icon(Icons.account_circle_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: userName,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Card(
                          elevation: 5,
                          color: PrimaryColorOne,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Icon(Icons.account_circle,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: userId,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'User Id',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Card(
                          elevation: 5,
                          color: PrimaryColorOne,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Icon(Icons.password_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: password,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Card(
                          elevation: 5,
                          color: PrimaryColorOne,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Icon(Icons.link,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: link,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Link',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                appName = null;
                                userName = null;
                                userId = null;
                                password = null;
                                link = null;
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                ),
                                child: Text("Discard",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                createEditCredential(widget.type);
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Future createEditCredential(type)async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = type == 'Create' ? FormData.fromMap({
     'app_name': appName!.text,
      'user_name' : userName!.text,
      'user_id': userId!.text,
      'password': password!.text,
      'link': link!.text,
    }) : FormData.fromMap({
      'app_name': appName!.text,
      'user_name' : userName!.text,
      'user_id': userId!.text,
      'password': password!.text,
      'link': link!.text,
      'id': '${widget.id}',
    });

    await dio.post(
        type == 'Create' ? ApiConstants.getCredentialAdd : ApiConstants.getCredentialUpdate,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        SnackBarMessageShow.successsMSG('SuccessFully Perform', context);
        Navigator.pushNamed(context, DrawerMenusName.credential);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 400){
        SnackBarMessageShow.errorMSG('Email Id Has Already Been Taken', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 401){
        SnackBarMessageShow.errorMSG('Unauthorised Expired', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else{
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
