// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/app_routes_name.dart';
import '../App Helper/Routes/App Routes/side_menus_routes_names.dart';
import '../App Helper/Ui Helper/ui_helper.dart';
import '../Authentication Pages/OnBoarding/constants/constants.dart';

class SideMenus extends StatefulWidget {
  SideMenus({Key? key}) : super(key: key);

  @override
  State<SideMenus> createState() => _SideMenusState();
}

class _SideMenusState extends State<SideMenus>{

  final List<SideMenuModel> sidemenus = <SideMenuModel>[
    SideMenuModel('DashBoard', Icons.dashboard , <SideMenuModel>[]),
    SideMenuModel('Agents', Icons.person_pin_circle , <SideMenuModel>[]),
    SideMenuModel('Admin', Icons.personal_injury , <SideMenuModel>[]),
    SideMenuModel('Contact Us', Icons.contact_page , <SideMenuModel>[]),
    SideMenuModel('Request Demo', Icons.webhook , <SideMenuModel>[]),
    //SideMenuModel('Service Type', Icons.token_outlined , <SideMenuModel>[]),
    //SideMenuModel('Letter Type', Icons.linear_scale_rounded , <SideMenuModel>[]),
    //SideMenuModel('Service Type Documents', Icons.document_scanner , <SideMenuModel>[]),
    //SideMenuModel('Country', Icons.flag , <SideMenuModel>[]),
    //SideMenuModel('City', Icons.flag_outlined , <SideMenuModel>[]),
    //SideMenuModel('Blog', Icons.blinds_outlined, <SideMenuModel>[]),
    //SideMenuModel('Career', Icons.school , <SideMenuModel>[]),
    //SideMenuModel('Applied For Career', Icons.next_plan , <SideMenuModel>[]),
    //SideMenuModel('Newsletter', Icons.newspaper , <SideMenuModel>[]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0),),
        gradient: LinearGradient(
            colors: [
              PrimaryColorOne,
              PrimaryColorTwo
            ]
        ),
      ),
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: sidemenus.length,
          itemBuilder: (context, index){
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _SideMenu(sidemenus[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _SideMenu(SideMenuModel root){
    return InkWell(
      onTap: (){
        if(root.title == 'DashBoard'){
          Navigator.pushNamed(context, AppRoutesName.dashboard);
        }
        else if(root.title == 'Agents'){
          Navigator.pushNamed(context, SideMenuName.agent);
        }
        else if(root.title == 'Admin'){
          Navigator.pushNamed(context, SideMenuName.admin);
        }
        else if(root.title == 'Contact Us'){
          Navigator.pushNamed(context, SideMenuName.contactus);
        }
        else if(root.title == 'Request Demo'){
          Navigator.pushNamed(context, SideMenuName.request_demo);
        }
        /*else if(root.title == 'Service Type'){
          Navigator.pushNamed(context, SideMenuName.service_type);
        }
        else if(root.title == 'Letter Type'){
          Navigator.pushNamed(context, SideMenuName.letter_type);
        }
        else if(root.title == 'Service Type Documents'){
          Navigator.pushNamed(context, SideMenuName.service_type_docs);
        }
        else if(root.title == 'Country'){
          Navigator.pushNamed(context, SideMenuName.country);
        }
        else if(root.title == 'City'){
          Navigator.pushNamed(context, SideMenuName.city);
        }
        else if(root.title == 'Blog'){
          Navigator.pushNamed(context, SideMenuName.blog);
        }
        else if(root.title == 'Career'){
          Navigator.pushNamed(context, SideMenuName.career);
        }
        else if(root.title == 'Applied For Career'){
          Navigator.pushNamed(context, SideMenuName.applied_for_career);
        }*/
        else{
          Navigator.pushNamed(context, SideMenuName.newsletter);
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(root.icon,color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(root.title,style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}

class SideMenuModel {
  String title;
  IconData icon;
  List<SideMenuModel> widgets;
  SideMenuModel(this.title, this.icon, this.widgets);
}