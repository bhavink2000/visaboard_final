// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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

class OVFAddApplicant extends StatefulWidget {
  const OVFAddApplicant({Key? key}) : super(key: key);

  @override
  State<OVFAddApplicant> createState() => _OVFAddApplicantState();
}

class _OVFAddApplicantState extends State<OVFAddApplicant> {

  GetAccessToken getAccessToken = GetAccessToken();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController first_name = TextEditingController();
  TextEditingController middle_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  bool priceVisible = false;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getAgentList(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        _getserviceList(getAccessToken.access_token);
      });
    });
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
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("Clients Details".toString().toUpperCase(),style: AllHeader)),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                child: Icon(Icons.person_pin_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Agent',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedAgent,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAgent = value as String?;
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _selectedAgent = value as String?;
                                    });
                                  },
                                  validator: (value) {  
                                    if (value == null) {
                                      return "can't empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: agentList?.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['first_name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    );
                                  })?.toList() ?? [],
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
                                child: Icon(Icons.room_service,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Service Type',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedService,
                                  isExpanded: true,
                                  onTap: (){
                                    setState(() {
                                      _selectedService = null;
                                      _selectedCountry = null;
                                      _selectedLetter = null;
                                      countryList!.clear();
                                      letterList!.clear();
                                      _getCountryList(getAccessToken.access_token);
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value as String?;
                                      _selectedCountry = null;
                                      _selectedLetter = null;
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
                                child: Icon(Icons.code,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
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
                                        _selectedLetter == null ;
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
                                        _selectedLetter == null;
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
                                child: Icon(Icons.legend_toggle,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Letter Type',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedLetter,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    if(letterList!.isNotEmpty){
                                      setState(() {
                                        _selectedLetter = value as String?;
                                        _selectedLetterPrice = double.parse(letterList!.firstWhere((item) =>
                                        item['id'].toString() == _selectedLetter)['price'].toString()).toString();
                                        priceVisible = true;
                                      });
                                    }
                                    else{
                                      print("else");
                                    }
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
                                    print("letterList->$letterList");
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Row(
                                        children: [
                                          Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)),
                                          const SizedBox(width: 5),
                                          Text("(Price :- ${item['price']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                        ],
                                      ),
                                    );
                                  })?.toSet()?.toList() ?? [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      formDataShow('First Name', first_name),
                      formDataShow('Middle Name', middle_name),
                      formDataShow('last Name', last_name),
                      Visibility(
                        visible: priceVisible,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quantity",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                    TextFormField(
                                        controller: quantity,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Add Quantity',
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order Price",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                    TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintText: _selectedLetterPrice,
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        )
                                    ),
                                  ],
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
                                _selectedService = null;
                                _selectedCountry = null;
                                _selectedLetter = null;
                                _selectedLetterPrice = null;
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
                                if(first_name.text.isEmpty || middle_name.text.isEmpty || last_name.text.isEmpty || quantity.text.isEmpty){
                                  Fluttertoast.showToast(msg: 'Fill Required Field',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                }
                                else{
                                  if(_selectedAgent == null || _selectedService == null || _selectedCountry == null || _selectedLetter == null){
                                    Fluttertoast.showToast(msg: 'Fill Required Field',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                  }
                                  else{
                                    addApplicant();
                                  }
                                }
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
        ),
      ),
    );
  }
  Widget formDataShow(String label, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Card(
        elevation: 5,
        color: PrimaryColorOne,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Icon(Icons.person_pin,color: Colors.white),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: TextField(
                controller: controller,
                style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '$label',
                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String? _selectedAgent;
  List? agentList;
  Future<String?> _getAgentList(var accesstoken) async {
    await http.post(
        Uri.parse(ApiConstants.getAgentList),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        agentList = data['data']['data'];
      });
      print("agentList->$agentList");
    });
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
  String? _selectedLetterPrice;
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
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        letterList = data['data'];
      });
    });
  }

  Future addApplicant()async{
    print("token->${getAccessToken.access_token}");
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop[agent_id]': _selectedAgent,
      'user_sop[service_type_id]' : _selectedService,
      'user_sop[country_id]': _selectedCountry,
      'user_sop[letter_type_id]': _selectedLetter,
      'user[first_name]': first_name.text,
      'user[middle_name]': middle_name.text,
      'user[last_name]': last_name.text,
      'user_sop[order_qty]': quantity.text,
      'order_price': _selectedLetterPrice,
    });
    print("formData-->${formData.fields}");

    var response = await dio.post(
        ApiConstants.getClientAdd,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    );
    print("response code ->${response.statusCode}");
    print("response Message ->${response.statusMessage}");
    if(response.statusCode == 200){
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var message = jsonResponse['message'];

      print("Status -> $status");
      print("Message -> $message");

      if (status == 200) {
        SnackBarMessageShow.successsMSG('$message', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
        LoadingIndicater().onLoadExit(false, context);
      } else {
        SnackBarMessageShow.errorMSG('$message', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }
    else{
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
      LoadingIndicater().onLoadExit(false, context);
    }
  }
}
