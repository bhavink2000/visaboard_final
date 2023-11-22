// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:visaboard_final/Admin/App%20Helper/Get%20Access%20Token/get_access_token.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/app_routes_name.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/snackbar_msg_show.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Models/DashBoard Model/profile_model.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  bool isLoading = true;
  var id;
  TextEditingController first_name = TextEditingController();
  TextEditingController middle_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController emailid = TextEditingController();

  String? status;
  File? file;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getProfile();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: isLoading == false ? AnimationLimiter(
        child: profileData.isNotEmpty ? ListView.builder(
          itemCount: profileData.length,
          itemBuilder: (context, index){
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1000),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: PrimaryColorOne
                            ),
                            child: TextField(
                              controller: first_name,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.person_pin,color: PrimaryColorOne,),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: PrimaryColorOne
                            ),
                            child: TextField(
                              controller: middle_name,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.person,color: PrimaryColorOne,),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: PrimaryColorOne
                            ),
                            child: TextField(
                              controller: last_name,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.person_outline,color: PrimaryColorOne,),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: PrimaryColorOne
                            ),
                            child: TextField(
                              controller: mobile,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.phone_android,color: PrimaryColorOne,),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: PrimaryColorOne
                            ),
                            child: TextField(
                              controller: emailid,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(Icons.email_outlined,color: PrimaryColorOne,),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne),
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
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Rozorpay",style: TextStyle(fontSize: 18),)
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: RadioListTile(
                                      title: const Text("Active"),
                                      value: "Active",
                                      groupValue: status,
                                      onChanged: (value){
                                        setState(() {
                                          status = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: RadioListTile(
                                      title: const Text("InActive"),
                                      value: "InActive",
                                      groupValue: status,
                                      onChanged: (value){
                                        setState(() {
                                          status = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                          onPressed: (){
                            if(first_name.text.isEmpty || middle_name.text.isEmpty || last_name.text.isEmpty || mobile.text.isEmpty){
                              SnackBarMessageShow.warningMSG('Fill All Field', context);
                            }
                            else{
                              if(file == null){
                                SnackBarMessageShow.warningMSG('Please Select File & Status', context);
                              }
                              else{
                                updateProfileDetails();
                              }
                            }
                          },
                          child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) : const ErrorHelper(),
      ) : CenterLoading(),
    );
  }

  late Future<ProfileModel?> profileOBJ;
  List<ProfileData> profileData = [];
  getProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      profileOBJ = ApiFuture().getMe(ApiConstants.getProfile,getAccessToken.access_token);
      await profileOBJ.then((value) async {
        profileData.add(value!.profiledata!);
      });
      setState(() {
        id = profileData[0].id;
        first_name.text = profileData[0].firstName!;
        middle_name.text = profileData[0].middleName!;
        last_name.text = profileData[0].lastName!;
        mobile.text = profileData[0].mobileNo!;
        emailid.text = profileData[0].emailId!;
      });
      setState(() {
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      SnackBarMessageShow.warningMSG('Internet Connection Problem', context);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      SnackBarMessageShow.errorMSG('Data Fetching Error', context);
      print(e);
    }
  }

  void _onLoad(bool showBox) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingOnly();
        }
    );
  }
  Future updateProfileDetails() async {
    _onLoad(true);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.UpdateProfile));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath("admin[image]", file!.path));
    request.fields['admin[first_name]'] = first_name.text;
    request.fields['admin[middle_name]'] = middle_name.text;
    request.fields['admin[last_name]'] = last_name.text;
    request.fields['admin[mobile_no]'] = mobile.text;

    await request.send().then((response) {
      if(response.statusCode == 200){
        SnackBarMessageShow.successsMSG('Update Successfully', context);
        Navigator.pushNamed(context, AppRoutesName.dashboard);
      }
      else{
        _onLoadExit(true);
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        print("error code${response.statusCode}");
      }
    });
  }
  void _onLoadExit(bool exitBox){
    if(exitBox){
      Future.delayed(const Duration(milliseconds: 1),(){
        file = null;
        status = "";
        Navigator.pop(context);
      });
    }
  }
}
