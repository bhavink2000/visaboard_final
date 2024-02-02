import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Service-Letter%20Provider/service_letter_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/app_routes_name.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/snackbar_msg_show.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Country-State-City Provider/country_state_city_provider.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';

class AdminCreateEdit extends StatefulWidget {
  var type;
  var id,afnm,amnm,alnm,aemail,amobile;
  AdminCreateEdit({Key? key,this.type,this.id,this.afnm,this.amnm,this.alnm,this.aemail,this.amobile}) : super(key: key);

  @override
  State<AdminCreateEdit> createState() => _AdminCreateEditState();
}

class _AdminCreateEditState extends State<AdminCreateEdit> {
  GetAccessToken getAccessToken = GetAccessToken();

  File? file;
  String activeinactive = "";
  TextEditingController adminfirstNM = TextEditingController();
  TextEditingController adminmiddleNM = TextEditingController();
  TextEditingController adminlastNM = TextEditingController();
  TextEditingController adminemail = TextEditingController();
  TextEditingController adminmobile = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    adminfirstNM.text = widget.afnm ?? '';
    adminmiddleNM.text = widget.amnm ?? '';
    adminlastNM.text = widget.alnm  ?? '';
    adminemail.text = widget.aemail ?? '';
    adminmobile.text = widget.amobile ?? '';
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getserviceList(getAccessToken.access_token);
        _getModuleList();
      });
    });
  }

  @override
  void dispose() {
    _selectedCountry = null;
    _selectedLetter = null;
    _selectedService = null;
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff0052D4),
      appBar: AppBar(
        title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("ADMIN DETAILS",style: AllHeader))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (){Navigator.of(context).pop();},
            icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: MainWhiteContainerDecoration,
              padding: MainWhiteContinerTopPadding,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildTextField('First Name', adminfirstNM),
                    buildTextField('Middle Name', adminmiddleNM),
                    buildTextField('Last Name', adminlastNM),
                    buildTextField('Email', adminemail),
                    buildTextField('Mobile', adminmobile),
                    Padding(
                      padding: const EdgeInsets.all(7),
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        //width: MediaQuery.of(context).size.width / 1.5,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Service Type',
                              hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                          ),
                          value: _selectedService,
                          isExpanded: true,
                          onTap: (){
                            if(_selectedLetter == null){
                              setState(() {
                                _getCountryList(getAccessToken.access_token);
                              });
                            }
                            else{
                              setState(() {
                                _selectedLetter = null;
                                _getCountryList(getAccessToken.access_token);
                              });
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedService = value as String?;
                              _getCountryList(getAccessToken.access_token);
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedService = value as String?;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: serviceList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        //width: MediaQuery.of(context).size.width / 1.5,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Country',
                              hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                          ),
                          value: _selectedCountry,
                          isExpanded: true,
                          onTap: (){
                            if(_selectedLetter == null){
                              setState(() {
                                _getCountryList(getAccessToken.access_token);
                                _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                              });
                            }
                            else{
                              setState(() {
                                _selectedLetter = null;
                                _getCountryList(getAccessToken.access_token);
                              });
                            }
                          },
                          onChanged: (country) {
                            if(_selectedLetter == null){
                              setState(() {
                                _selectedCountry = country as String?;
                                _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                              });
                            }
                            else{
                              setState(() {
                                _selectedLetter = null;
                                _getCountryList(getAccessToken.access_token);
                              });
                            }
                          },
                          items: countryList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        //width: MediaQuery.of(context).size.width / 1.5,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Letter Type',
                              hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                          ),
                          value: _selectedLetter,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedLetter = value as String?;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedLetter = value as String?;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: letterList?.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                            );
                          })?.toList() ?? [],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                  title: Text("Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
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
                                  title: Text("In-Active",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
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
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                      child: Container(
                       // width: MediaQuery.of(context).size.width / 2.1,
                        decoration: BoxDecoration(
                            color: PrimaryColorOne,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                        ),
                        child: Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: MultiSelectDialogField(
                              items: modulelist?.map((item) {
                                return MultiSelectItem(
                                    item.moduleid,item.modulename
                                );
                              })?.toList() ?? [],
                              selectedColor: PrimaryColorOne,
                              decoration: const BoxDecoration(border: Border()),
                              onSelectionChanged: (value){
                                _selectedModule = value;
                                print("ModuleList => $_selectedModule");
                              }, onConfirm: (Object) {  },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
                      child: InkWell(
                        onTap: (){
                          if(file == null || activeinactive.isEmpty){
                            SnackBarMessageShow.warningMSG('Fill All Field', context);
                          }
                          else{
                            if(_selectedService == null || _selectedCountry == null || _selectedLetter == null || _selectedModule == null){
                              SnackBarMessageShow.warningMSG('Select Service, Country, Letter, Module', context);
                            }
                            else{
                              adminCreateEditDetails();
                            }
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shadowColor: PrimaryColorOne.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(50)),color: PrimaryColorOne),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ),
                    )
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
            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,  fontSize: 12),
          ),
        ),
      ),
    );
  }


  String? _selectedService;
  List? serviceList;
  Future<String?> _getserviceList(var accesstoken) async {
    await http.get(
        Uri.parse(ApiConstants.getServiceType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        serviceList = data['data'];
      });
    });
  }

  String? _selectedCountry;
  List? countryList;
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

  String? _selectedLetter;
  List? letterList;
  Future<String?> _getletterList(var accesstoken,var selectService,var selectcountry) async {
    await http.post(
        Uri.parse(ApiConstants.getLetterType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({'service_id': selectService,'country_id': selectcountry})
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        letterList = data['data'];
      });
    });
  }

  List _selectedModule = [];
  var modulelist = [];
  Future<Map?> _getModuleList() async {
    await http.get(
        Uri.parse(ApiConstants.getModulesType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getAccessToken.access_token}',
        }
    ).then((response) {
      Map<String, dynamic> data = json.decode(response.body);
      final map = data['data'];
      modulelist = map.entries.map((e) => Module(e.key, e.value)).toList();
    });
  }

  Future adminCreateEditDetails() async {
    LoadingIndicater().onLoad(true, context);
    var adminStatus = activeinactive=="Active" ? 1 : 0;
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'admins[image]':await MultipartFile.fromFile(file!.path),
      'admins[first_name]': adminfirstNM.text,
      'admins[middle_name]' : adminmiddleNM.text,
      'admins[last_name]': adminlastNM.text,
      'admins[email_id]' : adminemail.text,
      'admins[mobile_no]' : adminmobile.text,
      'admin_role[0][service_type_id]' : _selectedService,
      'admin_role[0][country_id]' : _selectedCountry,
      'admin_role[0][letter_type_id][]' : _selectedLetter,
      'admin_module_role[module_id][]' : _selectedModule,
      'admins[status]' : adminStatus.toString(),
    });
    Response? response = await dio.post(
        widget.type == 'Create' ? ApiConstants.getAdminNewCreate : "${ApiConstants.getAdminUpdate}/${widget.id}",
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((onResponse){
      if(onResponse.statusCode == 200){
        SnackBarMessageShow.successsMSG('Successfully Perform', context);
        Navigator.pushNamed(context, AppRoutesName.dashboard);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(onResponse.statusCode == 400){
        LoadingIndicater().onLoadExit(false, context);
        SnackBarMessageShow.errorMSG('Email Id Already Taken', context);
        //Navigator.pushNamed(context, AppRoutesName.dashboard);
      }
      else if(onResponse.statusCode == 401){
        LoadingIndicater().onLoadExit(false, context);
        SnackBarMessageShow.errorMSG('Unauthorised Error', context);
        //Navigator.pushNamed(context, AppRoutesName.dashboard);
      }
      else{
        LoadingIndicater().onLoadExit(false, context);
        print("error code${onResponse.statusCode}");
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
      }
    }).catchError((e) => print("catchError ==>> ${e.response.toString()}"),);
  }
}
class Module {
  String moduleid;
  String modulename;
  Module(this.moduleid,this.modulename);
  @override
  String toString() {
    return "'${this.modulename}'";
    //return "'${this.id}', '${this.name}'";
    // return '{ ${this.id}, ${this.name} }';
  }
}