import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class BusinessVisitPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus, tabName;
  BusinessVisitPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<BusinessVisitPage> createState() => _BusinessVisitPageState();
}

class _BusinessVisitPageState extends State<BusinessVisitPage> {
  final inviterName = TextEditingController();
  final conferenceName = TextEditingController();
  final conferenceAddress = TextEditingController();
  final conferenceDate = TextEditingController();
  final visitDuration = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final attendeeCode = TextEditingController();
  String? conferenceRStatus;

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        Text("[ 5 / 10 ]",
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
        const SizedBox(height: 5),
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
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 7.5,
            child: TextField(
              controller: inviterName,
              decoration: editFormsInputDecoration('Name of Inviter/Co-ordinator *'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 7.5,
            child: TextField(
              controller: conferenceName,
              decoration: editFormsInputDecoration('Name of the Conference *'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 7.5,
            child: TextField(
              controller: conferenceAddress,
              decoration: editFormsInputDecoration('Venue of the Conference *'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 7.5,
            child: TextField(
              controller: conferenceDate,
              readOnly: true,
              decoration: editFormsInputDecoration('Date of the Conference *'),
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
                    conferenceDate.text = formattedDate;
                  });
                }else{
                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            //width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 7.5,
            child: TextField(
              controller: visitDuration,
              decoration: editFormsInputDecoration('Duration of the Conference *'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Have you registered for the Conference?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
              ),
              Row(
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                      value: "Yes",
                      groupValue: conferenceRStatus,
                      onChanged: (value){
                        setState(() {
                          conferenceRStatus = value.toString();
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                      value: "No",
                      groupValue: conferenceRStatus,
                      onChanged: (value){
                        setState(() {
                          conferenceRStatus = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: conferenceRStatus == 'Yes' ? true : false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SizedBox(
                    //width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 7.5,
                    child: TextField(
                      controller: attendeeCode,
                      decoration: editFormsInputDecoration('Attendee Reference Code'),
                      onTap: () async {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Spacer(),
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
                    updateBusinessVisit();
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
    );
  }

  Future<void> updateBusinessVisit() async {
    var cStatus = conferenceRStatus == 'Yes' ? 1 : 0;
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
        'user_business_visit_detail[inviter_name]': inviterName.text,
        'user_business_visit_detail[conference_name]': conferenceName.text,
        'user_business_visit_detail[conference_address]': conferenceAddress.text,
        'user_business_visit_detail[conference_date]': conferenceDate.text,
        'user_business_visit_detail[visit_duration]': visitDuration.text,
        'user_business_visit_detail[from_date]': fromDate.text,
        'user_business_visit_detail[to_date]': toDate.text,
        'user_business_visit_detail[conference_registered_status]': cStatus,
        'user_business_visit_detail[attendee_ref_code]': attendeeCode.text,
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
