// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:visaboard_final/Admin/Drawer%20Menus/All%20Graph/all_graph_page.dart';
import '../../../Authentication Pages/Login Screen/login_screen.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Authentication Pages/OnBoarding/screens/landing_page.dart';
import '../../../Authentication Pages/Splash Screen/splash_screen.dart';
import '../../../DashBoard Menus/Profile/profile_page.dart';
import '../../../DashBoard Menus/main_dashboard.dart';
import '../../../Drawer Menus/Agent Counter/agent_counter_page.dart';
import '../../../Drawer Menus/Agent QR Code/agent_qrcode_page.dart';
import '../../../Drawer Menus/Client/client_page.dart';
import '../../../Drawer Menus/Credential/credential_page.dart';
import '../../../Drawer Menus/Internal Chat/internal_chat_page.dart';
import '../../../Drawer Menus/Marketing/marketing_page.dart';
import '../../../Drawer Menus/Order Visa File/cancel_page.dart';
import '../../../Drawer Menus/Order Visa File/completed_page.dart';
import '../../../Drawer Menus/Order Visa File/hold_page.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/payment_pending_page.dart';
import '../../../Drawer Menus/Order Visa File/process_page.dart';
import '../../../Drawer Menus/Service/service_page.dart';
import '../../../Drawer Menus/Supplier/supplier_page.dart';
import '../../../Drawer Menus/Transaction Cancel/cancel_transaction.dart';
import '../../../Drawer Menus/Transaction/transaction_page.dart';
import '../../../Drawer Menus/Wallet/wallet_page.dart';
import '../../../Side Menus/Admin/admin_screen.dart';
import '../../../Side Menus/Agent/agent_screen.dart';
import '../../../Side Menus/Contact us/contactus_screen.dart';
import '../../../Side Menus/Reuest Demo/request_demo_screen.dart';
import '../../Ui Helper/ui_helper.dart';
import 'drawer_menus_routes_names.dart';
import 'app_routes_name.dart';
import 'side_menus_routes_names.dart';

class AppRoutes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splashscreen:return MaterialPageRoute(builder: (BuildContext context) =>  const SplashScreen());
      case AppRoutesName.landingpage:return MaterialPageRoute(builder: (BuildContext context) =>  LandingPage());
      case AppRoutesName.login:return MaterialPageRoute(builder: (BuildContext context) =>  const LoginPage());
      case AppRoutesName.dashboard:return MaterialPageRoute(builder: (BuildContext context) =>  Dashboard());

      case AppRoutesName.profile:return MaterialPageRoute(builder: (context) => const ProfilePage());
      //case AppRoutesName.homemenu:return MaterialPageRoute(builder: (context) => HomePage());
      //case AppRoutesName.notifactionmenu:return MaterialPageRoute(builder: (context) => NotificationPage());
      //case AppRoutesName.walletmenu:return MaterialPageRoute(builder: (context) => WalletMenuPage());
      //case AppRoutesName.settingmenu:return MaterialPageRoute(builder: (context) => SettingPage());

      case DrawerMenusName.client:return MaterialPageRoute(builder: (BuildContext context) =>  ClientPage());
      case DrawerMenusName.transaction:return MaterialPageRoute(builder: (BuildContext context) =>  TransactionPage());
      case DrawerMenusName.cancel_transaction:return MaterialPageRoute(builder: (BuildContext context) =>  CancelTransactionPage());
      case DrawerMenusName.order_visa_file:return MaterialPageRoute(builder: (BuildContext context) =>  OrderVisaFile());
      case DrawerMenusName.process:return MaterialPageRoute(builder: (BuildContext context) =>  ProcessPage());
      case DrawerMenusName.complete:return MaterialPageRoute(builder: (BuildContext context) =>  CompletedPage());
      case DrawerMenusName.hold:return MaterialPageRoute(builder: (BuildContext context) =>  HoldPage());
      case DrawerMenusName.cancel:return MaterialPageRoute(builder: (BuildContext context) =>  CancelPage());
      case DrawerMenusName.payment_pending:return MaterialPageRoute(builder: (BuildContext context) =>  PaymentPendingPage());
      case DrawerMenusName.service:return MaterialPageRoute(builder: (BuildContext context) =>  ServicePage());
      case DrawerMenusName.wallet_page_d:return MaterialPageRoute(builder: (BuildContext context) =>  WalletPageD());
      case DrawerMenusName.all_graph:return MaterialPageRoute(builder: (BuildContext context) =>  GraphPage());
      case DrawerMenusName.agent_counter:return MaterialPageRoute(builder: (BuildContext context) =>  AgentCounterPage());
      case DrawerMenusName.marketing:return MaterialPageRoute(builder: (BuildContext context) =>  MarketingPage());
      case DrawerMenusName.internal_chats:return MaterialPageRoute(builder: (BuildContext context) =>  ChatScreenPage());
      case DrawerMenusName.agent_qrcode:return MaterialPageRoute(builder: (BuildContext context) =>  AgentQRCodePage());
      case DrawerMenusName.credential:return MaterialPageRoute(builder: (BuildContext context) =>  CredentialPage());
      case DrawerMenusName.supplier:return MaterialPageRoute(builder: (BuildContext context) =>  SupplierPage());

      case SideMenuName.agent:return MaterialPageRoute(builder: (BuildContext context) =>  AgentScreen());
      case SideMenuName.admin:return MaterialPageRoute(builder: (BuildContext context) =>  AdminScreen());
      case SideMenuName.contactus:return MaterialPageRoute(builder: (BuildContext context) =>  ContactUsScreen());
      case SideMenuName.request_demo:return MaterialPageRoute(builder: (BuildContext context) =>  RequestedDemoScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,color: PrimaryColorOne,size: 25),
                    const SizedBox(height: 10,),
                    Text("No Route Found",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS),),
                  ],
                ),
              ),
            )
        );
    }
  }
}
