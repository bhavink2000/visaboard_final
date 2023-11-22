import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Authentication%20Provider/authentication_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Country-State-City%20Provider/country_state_city_provider.dart';
import 'package:visaboard_final/Admin/App%20Helper/Providers/Service-Letter%20Provider/service_letter_provider.dart';
import 'Admin/App Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import 'Admin/App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import 'Admin/App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import 'Admin/App Helper/Providers/Side Data Provider/side_menu_provider.dart';
import 'Admin/App Helper/Routes/App Routes/app_routes.dart';
import 'Admin/App Helper/Routes/App Routes/app_routes_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> UserDataSession()),
        ChangeNotifierProvider(create: (_)=> DashboardDataProvider()),
        ChangeNotifierProvider(create: (_)=> ServiceLetterProvider()),
        ChangeNotifierProvider(create: (_)=> CountryStateCityProvider()),
        ChangeNotifierProvider(create: (_)=> DrawerMenuProvider()),
        ChangeNotifierProvider(create: (_)=> SideMenuProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutesName.splashscreen,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
