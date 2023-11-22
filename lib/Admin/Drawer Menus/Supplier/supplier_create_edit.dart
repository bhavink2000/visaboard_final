import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:http/http.dart' as http;
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class SupplierCreateEdit extends StatefulWidget {
  var type,id;
  var countryId,uniNM,unEm,agencynm,agencyemail,contactp,contactno;
  SupplierCreateEdit({Key? key,this.type,this.id,this.countryId,this.uniNM,this.unEm,this.agencynm,this.agencyemail,this.contactp,this.contactno}) : super(key: key);

  @override
  State<SupplierCreateEdit> createState() => _SupplierCreateEditState();
}

class _SupplierCreateEditState extends State<SupplierCreateEdit> {

  GetAccessToken getAccessToken = GetAccessToken();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController? universityNM = TextEditingController();
  TextEditingController? universityEmail = TextEditingController();
  TextEditingController? agencyNM = TextEditingController();
  TextEditingController? agencyEmail = TextEditingController();
  TextEditingController? contactPerson = TextEditingController();
  TextEditingController? contactNumber = TextEditingController();

  @override
  void initState() {
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getCountryList(getAccessToken.access_token);
      });
    });
    //_selectedCountry = widget.countryId;

    universityNM!.text = widget.uniNM ?? '';
    universityEmail!.text = widget.unEm ?? '';
    agencyNM!.text = widget.agencynm ?? '';
    agencyEmail!.text = widget.agencyemail ?? '';
    contactPerson!.text = widget.contactp ?? '';
    contactNumber!.text = widget.contactno ?? '';
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
          title: Align(alignment: Alignment.topRight,child: Text("SUPPLIER DETAILS",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),color: Colors.white,
                ),
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
                                child: Icon(Icons.code_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.width / 7.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Country',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedCountry,
                                  isExpanded: true,
                                  onChanged: (country) {
                                    setState(() {
                                      _selectedCountry = country as String?;
                                    });
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
                                child: Icon(Icons.school,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: universityNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'University name',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                child: Icon(Icons.email_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: universityEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'University Email ID',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                child: Icon(Icons.compass_calibration_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: agencyNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Agency Name',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                child: Icon(Icons.attach_email_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: agencyEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Agency Email Id',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                child: Icon(Icons.person_pin,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: contactPerson,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Contact Person Name',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                child: Icon(Icons.call_end_rounded,color: Colors.white),
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: TextField(
                                  controller: contactNumber,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                      hintText: 'Contact Number',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                universityNM = null;
                                _selectedCountry = null;
                                universityEmail = null;
                                agencyNM = null;
                                agencyEmail = null;
                                contactPerson = null;
                                contactNumber = null;
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
                                createEditSupplier();
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


  Future createEditSupplier()async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = widget.type == 'Create' ? FormData.fromMap({
      'country_id': _selectedCountry.toString(),
      'university_name' : universityNM!.text,
      'university_email_id': universityEmail!.text,
      'agency_name': agencyNM!.text,
      'agency_email_id': agencyEmail!.text,
      'contact_person_name': contactPerson!.text,
      'contact_number' : contactNumber!.text,
    }) : FormData.fromMap({
      'country_id': _selectedCountry.toString(),
      'university_name' : universityNM!.text,
      'university_email_id': universityEmail!.text,
      'agency_name': agencyNM!.text,
      'agency_email_id': agencyEmail!.text,
      'contact_person_name': contactPerson!.text,
      'contact_number' : contactNumber!.text,
      'id': widget.id,
    });

    await dio.post(
        widget.type == 'Create' ? ApiConstants.getSupplierAdd : ApiConstants.getSupplierUpdate,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        SnackBarMessageShow.successsMSG('SuccessFully Perform', context);
        Navigator.pushNamed(context, DrawerMenusName.supplier);
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
