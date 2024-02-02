// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:visaboard_final/Admin/App%20Helper/Routes/App%20Routes/app_routes_name.dart';

import '../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../App Helper/Ui Helper/ui_helper.dart';
import '../Authentication Pages/OnBoarding/constants/constants.dart';

class CustomDrawer extends StatefulWidget {
  final AdvancedDrawerController controller;
  CustomDrawer({Key? key, required this.controller}) : super(key: key);
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final List<Entry> menus = <Entry>[
    Entry('Dashboard', Icons.dashboard , <Entry>[]),
    Entry('Client', Icons.person , <Entry>[]),
    Entry('Order -Visa File', Icons.folder_open ,
        [
          Entry('Order Visa File', Icons.file_present_sharp , []),
          Entry('Process', Icons.incomplete_circle , []),
          Entry('Complete', Icons.cloud_done , []),
          Entry('Hold', Icons.stop , []),
          Entry('Cancel', Icons.cancel_schedule_send , []),
          Entry('Payment Pending', Icons.payment , []),
        ]),
    //Entry('Templates', Icons.backpack , <Entry>[]),
    Entry('Transaction', Icons.transfer_within_a_station , <Entry>[]),
    Entry('Cancel Transaction', Icons.cancel_schedule_send_outlined , <Entry>[]),
    //Entry('Service', Icons.cleaning_services , <Entry>[]),
    Entry('Wallet', Icons.wallet , <Entry>[]),
    Entry('All Graph', Icons.bar_chart , <Entry>[]),
    //Entry('Agent Login', Icons.real_estate_agent , <Entry>[]),
    //Entry('Sop Form', Icons.soap , <Entry>[]),
    //Entry('Manual Sop Form', Icons.fiber_manual_record_outlined , <Entry>[]),
    Entry('Agent Counter', Icons.discount , <Entry>[]),
    /*Entry('Lead Management', Icons.folder_open ,
        [
          Entry('Lead Management', Icons.file_present , []),
          Entry('Pending', Icons.pending , []),
          Entry('Register Client', Icons.app_registration , []),
          Entry('Visa File Submitted', Icons.file_present , []),
          Entry('Successful Client', Icons.join_right_outlined , []),
          Entry('Visa Rejected', Icons.cancel_outlined , []),
          Entry('Non-Active Clients', Icons.comment_bank , []),
          Entry('Followup', Icons.supervisor_account , []),
        ]
    ),*/
    Entry('Marketing', Icons.markunread_mailbox_outlined , <Entry>[]),
    //Entry('Spinner', Icons.password_rounded , <Entry>[]),
    Entry('Internal Chat', Icons.chat , <Entry>[]),
    Entry('Agent QR Code', Icons.qr_code , <Entry>[]),
    Entry('Credential', Icons.backup_table , <Entry>[]),
    Entry('Supplier', Icons.data_exploration , <Entry>[]),
  ];


  final List<Entry> Amenus = <Entry>[
    Entry('Dashboard', Icons.dashboard , <Entry>[]),
    Entry('Client', Icons.person , <Entry>[]),
    Entry('Order -Visa File', Icons.folder_open ,
        [
          Entry('Order Visa File', Icons.file_present_sharp , []),
          Entry('Process', Icons.incomplete_circle , []),
          Entry('Complete', Icons.cloud_done , []),
          Entry('Hold', Icons.stop , []),
          Entry('Cancel', Icons.cancel_schedule_send , []),
          Entry('Payment Pending', Icons.payment , []),
        ]),
    //Entry('Templates', Icons.backpack , <Entry>[]),
    Entry('Transaction', Icons.transfer_within_a_station , <Entry>[]),
    //Entry('Cancel Transaction', Icons.cancel_schedule_send_outlined , <Entry>[]),
    //Entry('Service', Icons.cleaning_services , <Entry>[]),
    Entry('Wallet', Icons.wallet , <Entry>[]),
    //Entry('All Graph', Icons.bar_chart , <Entry>[]),
    //Entry('Agent Login', Icons.real_estate_agent , <Entry>[]),
    //Entry('Sop Form', Icons.soap , <Entry>[]),
    //Entry('Manual Sop Form', Icons.fiber_manual_record_outlined , <Entry>[]),
    //Entry('Agent Counter', Icons.discount , <Entry>[]),
    /*Entry('Lead Management', Icons.folder_open ,
        [
          Entry('Lead Management', Icons.file_present , []),
          Entry('Pending', Icons.pending , []),
          Entry('Register Client', Icons.app_registration , []),
          Entry('Visa File Submitted', Icons.file_present , []),
          Entry('Successful Client', Icons.join_right_outlined , []),
          Entry('Visa Rejected', Icons.cancel_outlined , []),
          Entry('Non-Active Clients', Icons.comment_bank , []),
          Entry('Followup', Icons.supervisor_account , []),
        ]
    ),*/
    Entry('Marketing', Icons.markunread_mailbox_outlined , <Entry>[]),
    //Entry('Spinner', Icons.password_rounded , <Entry>[]),
    //Entry('Internal Chat', Icons.chat , <Entry>[]),
    Entry('Agent QR Code', Icons.qr_code , <Entry>[]),
    //Entry('Credential', Icons.backup_table , <Entry>[]),
    Entry('Supplier', Icons.data_exploration , <Entry>[]),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset("assets/image/icon.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text("VisaBoard",style: TextStyle(
                  fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(color: Colors.white70,thickness: 0.5),
                itemCount: menus.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: _buildTiles(menus[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTiles(Entry root) {
    if (root.widgets.isEmpty) {
      return ListTile(
        onTap: () async {
          if(root.title == "Dashboard") {
            Navigator.pushNamed(context, AppRoutesName.dashboard);
          }
          else if(root.title == "Client"){
            Navigator.pushNamed(context, DrawerMenusName.client);
          }
          else if(root.title == "Order Visa File"){
            Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
          }
          else if(root.title == "Process"){
            Navigator.pushNamed(context, DrawerMenusName.process);
          }
          else if(root.title == "Complete"){
            Navigator.pushNamed(context, DrawerMenusName.complete);
          }
          else if(root.title == "Hold"){
            Navigator.pushNamed(context, DrawerMenusName.hold);
          }
          else if(root.title == "Cancel"){
            Navigator.pushNamed(context, DrawerMenusName.cancel);
          }
          else if(root.title == "Payment Pending"){
            Navigator.pushNamed(context, DrawerMenusName.payment_pending);
          }
          /*else if(root.title == "Templates"){
            Navigator.pushNamed(context, DrawerMenusName.template);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>TemplatesPage()));
          }*/
          else if(root.title == "Transaction"){
            Navigator.pushNamed(context, DrawerMenusName.transaction);
          }
          else if(root.title == "Cancel Transaction"){
            Navigator.pushNamed(context, DrawerMenusName.cancel_transaction);
          }
          /*else if(root.title == "Service"){
            Navigator.pushNamed(context, DrawerMenusName.service);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceScreen()));
          }*/
          else if(root.title == "Wallet"){
            Navigator.pushNamed(context, DrawerMenusName.wallet_page_d);
          }
          else if(root.title == "All Graph"){
            Navigator.pushNamed(context, DrawerMenusName.all_graph);
          }
          /*else if(root.title == "Agent Login"){
            Navigator.pushNamed(context, DrawerMenusName.agent_login);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentLoginPage()));
          }
          else if(root.title == "Sop Form"){
            Navigator.pushNamed(context, DrawerMenusName.sop_form);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SopFormPage()));
          }
          else if(root.title == "Manual Sop Form"){
            Navigator.pushNamed(context, DrawerMenusName.manual_sop_form);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ManualSopFormPage()));
          }*/
          else if(root.title == "Agent Counter"){
            Navigator.pushNamed(context, DrawerMenusName.agent_counter);
          }
          /*else if(root.title == "Lead Management"){
            Navigator.pushNamed(context, DrawerMenusName.lead_management);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadManagementPage()));
          }
          else if(root.title == "Pending"){
            Navigator.pushNamed(context, DrawerMenusName.pending);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingLead()));
          }
          else if(root.title == "Register Client"){
            Navigator.pushNamed(context, DrawerMenusName.register_client);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterClientLead()));
          }
          else if(root.title == "Visa File Submitted"){
            Navigator.pushNamed(context, DrawerMenusName.visa_file_submitted);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>VisaFileSubmittedLead()));
          }
          else if(root.title == "Successful Client"){
            Navigator.pushNamed(context, DrawerMenusName.successful_client);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessfulClientLead()));
          }
          else if(root.title == "Visa Rejected"){
            Navigator.pushNamed(context, DrawerMenusName.visa_rejected);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>VisaRejectedLead()));
          }
          else if(root.title == "Non-Active Clients"){
            Navigator.pushNamed(context, DrawerMenusName.nonactive_client);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>NonActiveClientLead()));
          }
          else if(root.title == "Followup"){
            Navigator.pushNamed(context, DrawerMenusName.followup);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowUpLead()));
          }*/
          else if(root.title == "Marketing"){
            Navigator.pushNamed(context, DrawerMenusName.marketing);
          }
          /*else if(root.title == "Spinner"){
            Navigator.pushNamed(context, DrawerMenusName.spinner);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SpinnerPage()));
          }*/
          else if(root.title == "Internal Chat"){
            Navigator.pushNamed(context, DrawerMenusName.internal_chats);
          }
          else if(root.title == "Agent QR Code"){
            Navigator.pushNamed(context, DrawerMenusName.agent_qrcode);
          }
          else if(root.title == "Credential"){
            Navigator.pushNamed(context, DrawerMenusName.credential);
          }
          else if(root.title == "Supplier"){
            Navigator.pushNamed(context, DrawerMenusName.supplier);
          }
        },
        contentPadding: const EdgeInsets.symmetric(vertical: -5),
        title: Row(
          children: [
            Icon(root.icon,color: Colors.white,size: 20,),
            const SizedBox(width: 10),
            Text(root.title, style: DrawerMenuStyle),
          ],
        ),
      );
    }
    return ExpansionTile(
      trailing: const Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      childrenPadding: EdgeInsets.zero,
      tilePadding: const EdgeInsets.symmetric(vertical: -5),
      key: PageStorageKey<Entry>(root),
      title: Row(
        children: [
          Icon(root.icon,color: Colors.white,size: 20,),
          const SizedBox(width: 10),
          Text(root.title, style: DrawerMenuStyle),
        ],
      ),
      children: root.widgets.map(_buildTiles).toList(),
    );
  }
}

class Entry {
  String title;
  IconData icon;
  List<Entry> widgets;
  Entry(this.title, this.icon, this.widgets);
}