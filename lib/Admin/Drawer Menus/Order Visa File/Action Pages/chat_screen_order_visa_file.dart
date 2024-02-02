// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable, missing_return

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class ChatScreenOrderVisaFile extends StatefulWidget {
  var client_id, c_id,client_fnm, client_lnm,service_nm, letter_nm, country_nm, order_p, u_sop_id;
  ChatScreenOrderVisaFile({Key? key,this.client_id,this.c_id,this.client_fnm,this.client_lnm,this.service_nm,this.letter_nm,this.country_nm,this.order_p,this.u_sop_id}) : super(key: key);

  @override
  State<ChatScreenOrderVisaFile> createState() => _ChatScreenOrderVisaFile();
}

class _ChatScreenOrderVisaFile extends State<ChatScreenOrderVisaFile> {

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchOVFChat(1, getAccessToken.access_token ,widget.u_sop_id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var clientName = "${widget.client_fnm} ${widget.client_lnm}";
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 5),
                  child: Text("Inbox & Messages",style: TextStyle(fontFamily: Constants.OPEN_SANS)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: ExpansionTile(
                title: Text("Client Details",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                children: [
                  showData('Client Id', widget.c_id),
                  showData('Client Name', clientName),
                  showData('Service Name', widget.service_nm),
                  showData('Letter Name', widget.letter_nm),
                  showData('Country', widget.country_nm),
                  showData('Order Price', widget.order_p),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      downloadDocs(widget.u_sop_id);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                      child: Row(
                        children: [
                          const Icon(Icons.download_rounded,color: Colors.white),
                          const SizedBox(width: 5,),
                          Text("Download Docs",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      openSendNewMessage(widget.u_sop_id);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_rounded,color: Colors.white),
                          const SizedBox(width: 5,),
                          Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.oVFChatData.status!){
                        case Status.loading:
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return value.oVFChatData.data!.chatData!.userInboxes!.isNotEmpty
                              ? ListView.builder(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                            itemCount: value.oVFChatData.data!.chatData!.userInboxes!.length,
                            itemBuilder: (context, index){
                              var chatData = value.oVFChatData.data!.chatData!.userInboxes;
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1)
                                ),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        chatData![index].sendByAdmin == 0 ? Column(
                                          children: [
                                            CircleAvatar(child: Icon(Icons.person,color: Colors.white70,),backgroundColor: Colors.black54,radius: 20,),
                                            Text("Client",style: TextStyle(fontFamily: Constants.OPEN_SANS),textAlign: TextAlign.center)
                                          ],
                                        ) : Container(),
                                        SizedBox(width: 5),
                                        Column(
                                          children: [
                                            Container(
                                              width: chatData[index].sendByAdmin == 1
                                                  ? MediaQuery.of(context).size.width / 1.45 : MediaQuery.of(context).size.width / 1.35,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: chatData[index].sendByAdmin == 1 ? Color(0xff0a6fb8) : Colors.green
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${chatData[index].firstName} ${chatData[index].lastName}",
                                                          style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                                    child: Text(chatData[index].createAt!,style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white70,fontSize: 10),),
                                                  ),
                                                  /*InkWell(
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
                                                                      deleteChat_Docs('Chat',chatData[index].encChatId,'');
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
                                                    child: Icon(Icons.delete_forever_rounded,color: Colors.white,size: 18)
                                                  ),*/
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: chatData[index].sendByAdmin == 1
                                                  ? MediaQuery.of(context).size.width / 1.45 : MediaQuery.of(context).size.width / 1.35,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    chatData[index].subject != null ? Text(
                                                        chatData[index].subject.toString(),
                                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)
                                                    ) : Container(),
                                                    chatData[index].subject != null ? const SizedBox(height: 10) : Container(),
                                                    HtmlWidget(
                                                      chatData[index].message ?? "",
                                                      textStyle: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 12),
                                                      onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                                                      onLoadingBuilder: (context, element, loadingProgress) => const Center(child: CircularProgressIndicator(color: Colors.red,)),
                                                    ),
                                                    chatData[index].files!.isNotEmpty ? Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height / 25,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: chatData[index].files!.length,
                                                        itemBuilder: (context, fINdex){
                                                          var files = chatData[index].files;
                                                          return Container(
                                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                                            width: MediaQuery.of(context).size.width / 1.45,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                    onTap: (){
                                                                      launch(files![fINdex].nfile!);
                                                                    },
                                                                    child: Text(
                                                                        files![fINdex].file!,
                                                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne
                                                                        )
                                                                    )
                                                                ),
                                                                InkWell(
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
                                                                                      deleteChat_Docs('Chat',chatData[index].encChatId,'');
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
                                                                    child: Icon(Icons.delete_forever_rounded,color: Colors.black,size: 20)
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ) : Container(),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 5),
                                        chatData[index].sendByAdmin == 1 ? Column(
                                          children: const [
                                            Image(image: AssetImage("assets/image/icon.png"),width: 20,),
                                            Text("Visaboard \nTems",textAlign: TextAlign.center,)
                                          ],
                                        ) : Container()
                                      ],
                                    ),
                                    /*Container(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                            child: Row(
                                              children: [
                                                chatData[index].sendByAdmin == 1
                                                 ? const Image(image: AssetImage("assets/image/icon.png"),width: 20)
                                                 : Container(
                                                    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.green),
                                                    child: Text("C",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,color: Colors.white),)
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "${chatData[index].firstName} ${chatData[index].lastName}",
                                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  chatData[index].createAt,
                                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne,fontSize: 10,fontWeight: FontWeight.bold)
                                                ),
                                                SizedBox(width: 5),
                                                InkWell(
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
                                                                    deleteChat_Docs('Chat',chatData[index].encChatId,'');
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
                                                  child: Icon(Icons.delete_forever_rounded,color: PrimaryColorOne,size: 20)
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),*/
                                    /*Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          chatData[index].subject != null ? Text(
                                              chatData[index].subject.toString(),
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontWeight: FontWeight.bold)
                                          ) : Container(),
                                          chatData[index].subject != null ? const SizedBox(height: 10) : Container(),
                                          HtmlWidget(
                                            chatData[index].message ?? "",
                                            textStyle: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,),
                                            onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                                            onLoadingBuilder: (context, element, loadingProgress) => const Center(child: CircularProgressIndicator(color: Colors.red,)),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                    //const Divider(color: Colors.white70),
                                  ],
                                ),
                              );
                            },
                          )
                              : Center(child: Text(
                              "No Chat",
                              style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white)
                          ));
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showData(var label, var data){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 110,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$label:",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,fontWeight: FontWeight.bold),),
              ),
            ),
            //Spacer(),
            SizedBox(
              width: 180,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$data",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),textAlign: TextAlign.right,),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  File? file;
  String? _selectedValueemail;
  List<String> listOfValueemail = ['Complete Email', 'Query Email'];
  openSendNewMessage(var userid) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            backgroundColor: Colors.white,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: subject,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Subject',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: message,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select Email Type',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedValueemail,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValueemail = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValueemail = value;
                                });
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfValueemail.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Card(
                        elevation: 10,
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
                              sendMessage(widget.u_sop_id);
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
                );
              },
            ),
          );
        }
    ).then((value){
    });
  }

  Future sendMessage(var userid)async{
    var emailType = _selectedValueemail == 'Complete Email' ? 1 : 2;
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop_id': userid,
      'user_inbox[subject]' : subject.text,
      'user_inbox[message]': message.text,
      'email_send_type': emailType,
      'user_inbox_file[file][]': await MultipartFile.fromFile(file!.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    });

    var response = await dio.post(
        ApiConstants.SendMessage,
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

  Future<void> deleteChat_Docs(var type,var cId, var dId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      var chatUrl = "${ApiConstants.getOVFChatDelete}$cId/delete";
      var docsUrl = "${ApiConstants.getOVFChatDelete}$cId/$dId/delete";

      final response = await http.get(
          Uri.parse(
            type == 'Chat' ? "$chatUrl" : "$docsUrl"
          ),
          headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

  Future<Uint8List?> downloadDocs(uSId) async {
    //var url = "https://demo.visaboard.in/api/vbx/user/download-inbox-document/$uSId";
    var url = "https://visaboard.in/api/vbx/user/download-inbox-document/$uSId";
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getAccessToken.access_token}',
        }
    );
    var data = json.decode(response.body);
    var dStatus = data['status'];
    var dmsg = data['message'];
    if (response.statusCode == 200) {
      if(dStatus == 400){
        SnackBarMessageShow.warningMSG('$dmsg', context);
        Navigator.pop(context);
      }
      else{
        final bytes = response.bodyBytes;
        final file = File('/storage/emulated/0/Download/visafile_docs.zip');
        await file.writeAsBytes(bytes);
        Fluttertoast.showToast(msg: "$file");
        setState(() {});
      }
    } else {
      throw Exception('Failed to download image');
    }
  }
}
