import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class FamilyVisitPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus, tabName;
  FamilyVisitPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<FamilyVisitPage> createState() => _FamilyVisitPageState();
}

class _FamilyVisitPageState extends State<FamilyVisitPage> {

  final inviterName = TextEditingController();
  final visitDuration = TextEditingController();
  final inviterAddress = TextEditingController();
  final visitReason = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();

  String? faRelation;
  String? faOccupation;
  String? faResidency;
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getRelationType(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        getOccupationType(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        getResidencyStatus(getAccessToken.access_token);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.tabName}",
                          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,letterSpacing: 1),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text("[ 4 / 10 ]",
                              style: TextStyle(fontFamily: Constants.OPEN_SANS,color: widget.tabStatus == 1 ? Colors.green : Colors.red,),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 2,
                              color: widget.tabStatus == 1 ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    )
                )
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black45.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("You have submitted request for Visa File SOP, Canada, on Date: December 7th, 2022 12:46 PM.",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: inviterName,
                  decoration: editFormsInputDecoration('Name of Medical Practioner'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7.5,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    decoration: editFormsInputDecoration('Relation to you'),
                    value: faRelation,
                    style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        faRelation = value as String?;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        faRelation = value as String?;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    items: relationTypes?.map((item) {
                      return DropdownMenuItem(
                        value: item['id'].toString(),
                        child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                      );
                    })?.toList() ?? [],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7.5,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    decoration: editFormsInputDecoration('Residency Status of the Inviter'),
                    value: faResidency,
                    style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        faResidency = value as String?;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        faResidency = value as String?;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    items: residencyStatus?.map((item) {
                      return DropdownMenuItem(
                        value: item['id'].toString(),
                        child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                      );
                    })?.toList() ?? [],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7.5,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    decoration: editFormsInputDecoration('Occupation of Spouse'),
                    value: faOccupation,
                    style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        faOccupation = value as String?;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        faOccupation = value as String?;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    items: occupationTypes?.map((item) {
                      return DropdownMenuItem(
                        value: item['id'].toString(),
                        child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                      );
                    })?.toList() ?? [],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: visitDuration,
                  decoration: editFormsInputDecoration('Duration of the intended Family Visit'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: inviterAddress,
                  decoration: editFormsInputDecoration('Address of Inviter'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: visitReason,
                  decoration: editFormsInputDecoration('Reason to Visit'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: fromDate,
                  decoration: editFormsInputDecoration('Date of Departure from home country'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        fromDate.text = formattedDate;
                      });
                    }else{
                      Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: SizedBox(
                //width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 7.5,
                child: TextField(
                  controller: toDate,
                  decoration: editFormsInputDecoration('Date of Arrival to home country'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        toDate.text = formattedDate;
                      });
                    }else{
                      Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                    }
                  },
                ),
              ),
            ),
            //Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        widget.pagecontroller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: PrimaryColorOne,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: Constants.OPEN_SANS),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async{
                        updateFamilyVisit();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: PrimaryColorOne,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          widget.tabStatus == 1 ? "Submit" : "Next",
                          style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: Constants.OPEN_SANS),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  List? relationTypes;
  Future<String?> getRelationType(var accesstoken) async {
    print("States Calling");
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: {
          'user_id': widget.user_id,
          'user_sop_id': widget.user_sop_id
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        relationTypes = data['data']['family_relation'];
      });
      print("resltionList -> $relationTypes");
    });
  }
  List? occupationTypes;
  Future<String?> getOccupationType(var accesstoken) async {
    print("States Calling");
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: {
          'user_id': widget.user_id,
          'user_sop_id': widget.user_sop_id
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        occupationTypes = data['data']['occupation'];
      });
      print("Education List -> $occupationTypes");
    });
  }
  List? residencyStatus;
  Future<String?> getResidencyStatus(var accesstoken) async {
    print("States Calling");
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: {
          'user_id': widget.user_id,
          'user_sop_id': widget.user_sop_id
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        residencyStatus = data['data']['residency_status'];
      });
      print("residency status List -> $occupationTypes");
    });
  }

  Future<void> updateFamilyVisit() async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));
      FormData formData = FormData.fromMap({
        'step': '',
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user_family_visit_detail[inviter_name]': inviterName.text,
        'user_family_visit_detail[inviter_relation]': faRelation.toString(),
        'user_family_visit_detail[inviter_residency_status]': faResidency.toString(),
        'user_family_visit_detail[inviter_occupation]': faOccupation.toString(),
        'user_family_visit_detail[visit_duration]': visitDuration.text,
        'user_family_visit_detail[inviter_address]': inviterAddress.text,
        'user_family_visit_detail[visit_reason]': visitReason.text,
        'user_family_visit_detail[from_date]': fromDate.text,
        'user_family_visit_detail[to_date]': toDate.text,
      });
      print("Form data->${formData.fields}");
      final response = await dio.post(
          ApiConstants.getOVFUpdate,
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      );
      print("response code ->${response.statusCode}");
      print("response Message ->${response.statusMessage}");
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        var status = jsonResponse['status'];
        var message = jsonResponse['message'];

        print("Status -> $status");
        print("Message -> $message");

        if (status == 200) {
          SnackBarMessageShow.successsMSG('$message', context);
          widget.pagecontroller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
        } else {
          SnackBarMessageShow.errorMSG('$message', context);
          Navigator.pop(context);
        }
      } else {
        SnackBarMessageShow.errorMSG('Something went wrong', context);
        Navigator.pop(context);
      }
    } catch (error) {
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
    }
  }
}
