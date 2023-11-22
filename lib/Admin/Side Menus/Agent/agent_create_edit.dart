// ignore_for_file: non_constant_identifier_names, missing_return

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/snackbar_msg_show.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../side_menu.dart';

class AgentCreateEdit extends StatefulWidget {
  var type,access_token;
  var id,fNM,mNM,lNM,companyNM,email,mobileNo,country,state,city,status;
  AgentCreateEdit({Key? key,this.type,this.access_token,this.id,this.fNM,this.mNM,this.lNM,this.companyNM,this.email,this.mobileNo,this.country,this.state,this.city,this.status}) : super(key: key);

  @override
  State<AgentCreateEdit> createState() => _AgentCreateEditState();
}

class _AgentCreateEditState extends State<AgentCreateEdit> {

  File? file;
  final GlobalKey<ScaffoldState> key = GlobalKey();

  TextEditingController firstnm = TextEditingController();
  TextEditingController middlenm = TextEditingController();
  TextEditingController lastnm = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alternateemail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController landlinemobile = TextEditingController();

  TextEditingController companyname = TextEditingController();
  TextEditingController companyaddress = TextEditingController();

  TextEditingController bankname = TextEditingController();
  TextEditingController accountname = TextEditingController();
  TextEditingController accountno = TextEditingController();
  TextEditingController ifscno = TextEditingController();
  TextEditingController bankaddress = TextEditingController();

  TextEditingController linkedinurl = TextEditingController();
  TextEditingController facebookurl = TextEditingController();
  TextEditingController instagramurl = TextEditingController();
  TextEditingController twitterurl = TextEditingController();
  TextEditingController youtubenurl = TextEditingController();
  TextEditingController websitenurl = TextEditingController();

  String activeinactive = "";
  String sendEmail = "";
  String statusPPD = "";
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  String? selectCountry;
  String? selectState;
  String? selectCity;
  List? countryList;
  List? stateList;
  List? cityList;


  @override
  void initState() {
    _getCountryList(widget.access_token);
    firstnm.text = widget.fNM;
    middlenm.text = widget.mNM;
    lastnm.text = widget.lNM;
    companyname.text = widget.companyNM;
    email.text = widget.email;
    mobile.text = widget.mobileNo;
    //activeinactive = widget.status;
    selectCountry = widget.country;
    selectState = widget.state;
    selectCity = widget.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff0052D4),
      appBar: AppBar(
        title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("AGENT DETAILS",style: AllHeader))),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: widget.type == 'Create' ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Text("Agents Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                    ),
                    Divider(thickness: 1.5,color: PrimaryColorOne,),

                    buildTextField('First Name', firstnm),
                    buildTextField('Middle Name', middlenm),
                    buildTextField('last Name', lastnm),
                    buildTextField('Email', email),
                    buildTextField('Mobile', mobile),
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
                                  groupValue: activeinactive,
                                  onChanged: (value){
                                    setState(() {
                                      activeinactive = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("In-Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                  value: "InActive",
                                  groupValue: activeinactive,
                                  onChanged: (value){
                                    setState(() {
                                      activeinactive = value.toString();
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
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),color: PrimaryColorOne),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    file = null;
                                    firstnm.text = '';
                                    middlenm.text = '';
                                    lastnm.text = '';
                                    email.text = '';
                                    mobile.text = '';
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Discard",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const VerticalDivider(thickness: 1.5,color: Colors.white,),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    if(firstnm.text.isEmpty || middlenm.text.isEmpty || lastnm.text.isEmpty || email.text.isEmpty || mobile.text.isEmpty){
                                      SnackBarMessageShow.warningMSG('Fill All Field', context);
                                    }else{
                                      if(activeinactive.isEmpty || file == null){
                                        SnackBarMessageShow.warningMSG('Please Select File & Status', context);
                                      }
                                      else{
                                        createEditAgent();
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ) : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Text("Agents Details",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                    ),
                    Divider(thickness: 1.5,color: PrimaryColorOne,),
                    buildTextField('First Name', firstnm),
                    buildTextField('Middle Name', middlenm),
                    buildTextField('last Name', lastnm),
                    buildTextField('Email', email),
                    buildTextField('Alternate Email', alternateemail),
                    buildTextField('Mobile', mobile),
                    buildTextField('Land line No. (If any)', landlinemobile),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Business Registration Proof (if applicable)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                          ),
                          Card(
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
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    RadioListTile(
                      title: Text("Send Email Notification To Your ALternate Email Address?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                      value: "Yes",
                      groupValue: sendEmail,
                      onChanged: (value){
                        setState(() {
                          sendEmail = value.toString();
                        });
                      },
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
                                  groupValue: activeinactive,
                                  onChanged: (value){
                                    setState(() {
                                      activeinactive = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("In-Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                  value: "InActive",
                                  groupValue: activeinactive,
                                  onChanged: (value){
                                    setState(() {
                                      activeinactive = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    buildTextField('Company Name', companyname),
                    buildTextField('Company Address', companyaddress),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Proprietor / Partner / Director",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),)
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.3,
                                    height: MediaQuery.of(context).size.height / 20,
                                    child: RadioListTile(
                                      title: Text("Proprietor",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                      value: "Proprietor",
                                      groupValue: statusPPD,
                                      onChanged: (value){
                                        setState(() {
                                          statusPPD = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.4,
                                    height: MediaQuery.of(context).size.height / 20,
                                    child: RadioListTile(
                                      title: Text("Partner",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                                      value: "Partner",
                                      groupValue: statusPPD,
                                      onChanged: (value){
                                        setState(() {
                                          statusPPD = value.toString();
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
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 20,
                            child: RadioListTile(
                              title: Text("Director",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                              value: "Director",
                              groupValue: statusPPD,
                              onChanged: (value){
                                setState(() {
                                  statusPPD = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    buildTextField('Bank Name', bankname),
                    buildTextField('Account Name', accountname),
                    buildTextField('Account No', accountno),
                    buildTextField('IFSC No', ifscno),
                    buildTextField('Bank Address', bankaddress),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Country',
                              hintStyle: TextStyle(fontSize: 12)
                          ),
                          value: _selectedCountry,
                          isExpanded: true,
                          onTap: (){
                            if(_selectedState == null && _selectedCity == null){
                              setState(() {
                                _getStateList(widget.access_token,_selectedCountry);
                              });
                            }
                            else{
                              setState(() {
                                _selectedCity = null;
                                _selectedState = null;
                                _getCountryList(widget.access_token);
                              });
                            }
                          },
                          onChanged: (country) {
                            if(_selectedState == null && _selectedCity == null){
                              setState(() {
                                _selectedCountry = country as String?;
                                _getStateList(widget.access_token,_selectedCountry);
                              });
                            }
                            else{
                              setState(() {
                                _selectedCity = null;
                                _selectedState = null;
                                _getCountryList(widget.access_token);
                              });
                            }
                          },
                          items: countryList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'State',
                              hintStyle: TextStyle(fontSize: 12)
                          ),
                          value: _selectedState,
                          isExpanded: true,
                          onTap: (){
                            if(_selectedCity == null){
                              setState(() {
                                _getCityList(widget.access_token,_selectedCountry,_selectedState);
                              });
                            }
                            else{
                              setState(() {
                                _selectedCity = null;
                                _getStateList(widget.access_token,  _selectedCountry);
                              });
                            }
                          },
                          onChanged: (state) {
                            if(_selectedCity == null){
                              setState(() {
                                _selectedState = state as String?;
                                _getCityList(widget.access_token,_selectedCountry,_selectedState);
                              });
                            }
                            else{
                              setState(() {
                                _selectedCity = null;
                                _getStateList(widget.access_token,_selectedCountry);
                              });
                            }
                          },
                          items: stateList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'City',
                              hintStyle: TextStyle(fontSize: 12)
                          ),
                          value: _selectedCity,
                          isExpanded: true,
                          onChanged: (city) {
                            setState(() {
                              _selectedCity = city as String?;
                            });
                          },
                          items: cityList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),

                    buildTextField('Linked-In URL', linkedinurl),
                    buildTextField('Facebook URL', facebookurl),
                    buildTextField('Facebook URL', facebookurl),
                    buildTextField('Instagram URL', instagramurl),
                    buildTextField('Twitter URL', twitterurl),
                    buildTextField('Youtube URL', youtubenurl),
                    buildTextField('Yor Website URL', websitenurl),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),color: PrimaryColorOne),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    file = null;
                                    firstnm.text = '';
                                    middlenm.text = '';
                                    lastnm.text = '';
                                    email.text = '';
                                    mobile.text = '';
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Discard",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const VerticalDivider(thickness: 1.5,color: Colors.white,),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    if(firstnm.text.isEmpty || middlenm.text.isEmpty || lastnm.text.isEmpty || email.text.isEmpty || mobile.text.isEmpty){
                                      SnackBarMessageShow.warningMSG('Fill All Field', context);
                                    }else{
                                      if(activeinactive.isEmpty || file == null){
                                        SnackBarMessageShow.warningMSG('Please Select File & Status', context);
                                      }
                                      else{
                                        createEditAgent();
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 7,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
          ),
        ),
      ),
    );
  }

  Future<String?> _getCountryList(var accesstoken) async {
    await http.get(
        Uri.parse(ApiConstants.getCountry),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        countryList = data['data'];
      });
    });
  }

  Future<String?> _getStateList(var accesstoken,var selectCountry) async {
    await http.post(
        Uri.parse(ApiConstants.getState),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({'country_id': selectCountry})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        stateList = data['data'];
      });
    });
  }

  Future<String?> _getCityList(var accesstoken,var selectCountry,var selectState) async {
    await http.post(
        Uri.parse(ApiConstants.getCity),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({
          'country_id': selectCountry,
          'state_id': selectState})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        cityList = data['data'];
      });
    });
  }

  Future createEditAgent()async{
    LoadingIndicater().onLoad(true, context);
    var adminStatus = activeinactive == "Active" ? 1 : 0;

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${widget.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'first_name': firstnm.text,
      'middle_name' : middlenm.text,
      'last_name': lastnm.text,
      'email_id': email.text,
      'mobile_no': mobile.text,
      'status': adminStatus.toString(),
      'alt_email_id' : alternateemail.text,
      'alt_mobile_no' : landlinemobile.text,
      'country_id' : _selectedCountry.toString(),
      'state_id' : _selectedState.toString(),
      'city_id' : _selectedCity.toString(),
      'linkedin_link' : linkedinurl.text,
      'facebook_link' : facebookurl.text,
      'instagram_link' : instagramurl.text,
      'twitter_link' : twitterurl.text,
      'youtube_link' : youtubenurl.text,
      'website_link' : websitenurl.text,
      'image': await MultipartFile.fromFile(file!.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    });

    await dio.post(
        widget.type == 'Create' ? ApiConstants.getAgentNewCreate : "${ApiConstants.getAgentUpdate}/${widget.id}",
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        file = null;
        SnackBarMessageShow.successsMSG('SuccessFully Perform', context);
        Navigator.pushNamed(context, AppRoutesName.dashboard);
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
