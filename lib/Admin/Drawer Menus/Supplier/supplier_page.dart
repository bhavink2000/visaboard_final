// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Search Data/Drawer Menus Search Data/search_supplier_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import 'supplier_create_edit.dart';

class SupplierPage extends StatefulWidget{
  const SupplierPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SupplierPage();
  }
}

class _SupplierPage extends State<SupplierPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  TextEditingController universityNM = TextEditingController();
  TextEditingController universityEmail = TextEditingController();
  TextEditingController agencyNM = TextEditingController();
  TextEditingController agencyEmail = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController contactNumber = TextEditingController();


  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchSupplier(1, getAccessToken.access_token);
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
        backgroundColor: const Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("SUPPLIER",style: AllHeader)),
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
                                      delegate: SupplierSearch(access_token: getAccessToken.access_token,context: context)
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierCreateEdit(type: 'Create')));
                      //openNewSupplierDetailsBox();
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),color: Colors.white,
                ),
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.supplierDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.supplierDataList.data!.supplierData!.data!.length,
                              itemBuilder: (context, index){
                                var supplier = value.supplierDataList.data!.supplierData!.data;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
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
                                                                  supplier![index].id,
                                                                  supplier[index].contactPersonName
                                                                ),
                                                                expanded: buildExpanded1(
                                                                    supplier[index].universityName,
                                                                    supplier[index].universityEmailId
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                    supplier[index].agencyName,
                                                                    supplier[index].contactNumber,
                                                                    supplier[index].agencyEmailId,
                                                                    supplier[index].id,
                                                                    supplier[index].universityName,
                                                                    supplier[index].universityEmailId,
                                                                    supplier[index].agencyName,
                                                                    supplier[index].contactPersonName,
                                                                    supplier[index].contactNumber,
                                                                  supplier[index].countryName
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  supplier[index].adminFirstName,
                                                                  supplier[index].adminLastName,
                                                                  supplier[index].countryName,
                                                                  supplier[index].agencyEmailId,
                                                                  supplier[index].createAt,
                                                                  supplier[index].id,
                                                                  supplier[index].universityName,
                                                                  supplier[index].universityEmailId,
                                                                  supplier[index].agencyName,
                                                                  supplier[index].contactPersonName,
                                                                  supplier[index].contactNumber
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

                                        if (supplier!.length == 10 || index + 1 != supplier!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == supplier.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: drawerMenuProvider.supplierDataList.data!.supplierData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            drawerMenuProvider.fetchSupplier(curentindex + 1, getAccessToken.access_token);
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  buildCollapsed1(var id, var name) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("$id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text(name == null ? "" : "$name",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
        ],
      ),
    );
  }
  buildCollapsed3(var agencyNM, var mobile,var agencyEId,var id,var uNm, var uEmail, var aNM,var cNm,var cNo,var country) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Agency Name",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(agencyNM == null ? '' : "$agencyNM",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Text("Contact Number",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: (){
                    launch("tel://$mobile");
                  },
                  child: Container(
                      padding: PaddingField,
                      child: Text("$mobile" ?? "",style: FottorR)
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.3,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierCreateEdit(
                          type: 'Edit',
                          countryId: country,
                          uniNM: uNm == null ? '' : '$uNm',
                          unEm: uEmail == null ? '' : '$uEmail',
                          agencynm: aNM == null ? '' : '$aNM',
                          agencyemail: agencyEId == null ? '' : '$agencyEId',
                          contactp: cNm == null ? '' : '$cNm',
                          contactno: cNo == null ? '' : '$cNo',
                          id: id,
                        )));
                      },
                      child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
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
                                        deleteSupplier(id);
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
                      child: Icon(Icons.delete,color: PrimaryColorOne,size: 20,),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  buildExpanded1(var universityNM, var universityEmail) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("University Name",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(universityNM == null ? "" : "$universityNM",style: BackHeaderTopR)
                ),
              ),
              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
              SizedBox(width: 5,),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.1,
                  child: Text("University Email ID",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text(universityEmail == null ? "" : "$universityEmail",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var subAdminFNM, var subAdminLNM, var country, var agencyEmail, var createOn, var id,var uNm, var uEmail, var aNM,var cNm,var cNo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Sub Admin Name",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$subAdminFNM $subAdminLNM" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$country" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Agency Email ID",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text(agencyEmail == null ? "" : "$agencyEmail"?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$createOn" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.1,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierCreateEdit(
                          type: 'Edit',
                          countryId: country,
                          uniNM: uNm == null ? '' : '$uNm',
                          unEm: uEmail == null ? '' : '$uEmail',
                          agencynm: aNM == null ? '' : '$aNM',
                          agencyemail: agencyEmail == null ? '' : '$agencyEmail',
                          contactp: cNm == null ? '' : '$cNm',
                          contactno: cNo == null ? '' : '$cNo',
                        id: id,
                      )));
                    },
                    child: Icon(Icons.edit,color: PrimaryColorOne,size: 20,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: (){
                      deleteSupplier(id);
                    },
                    child: Icon(Icons.delete,color: PrimaryColorOne,size: 20,),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Future<void> deleteSupplier(var id) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.get(Uri.parse("${ApiConstants.getSupplierDelete}$id/delete"), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.supplier);
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

}