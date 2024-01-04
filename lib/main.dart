import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const.dart';
import 'package:flutter_dashboard/dashboard.dart';
import 'package:flutter_dashboard/widgets/menu.dart';
import 'package:flutter_dashboard/pages/home/reservation_page.dart';
import 'package:flutter_dashboard/pages/home/show_reservation.dart';
import 'package:flutter_dashboard/pages/Profile_page.dart';
import 'package:flutter_dashboard/pages/login_screen.dart';
import 'package:flutter_dashboard/pages/ForgetCodePage.dart';
import 'package:flutter_dashboard/pages/register_page.dart';
import 'package:flutter_dashboard/pages/home/home_page.dart';
import 'package:flutter_dashboard/service/api_service.dart';
import 'package:flutter_dashboard/service/api_service3.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var apiService = ApiService();

    return MaterialApp(
      title: 'Velou Dashboard',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: MaterialColor(
          primaryColorCode,
          <int, Color>{
            50: const Color(primaryColorCode).withOpacity(0.1),
            100: const Color(primaryColorCode).withOpacity(0.2),
            200: const Color(primaryColorCode).withOpacity(0.3),
            300: const Color(primaryColorCode).withOpacity(0.4),
            400: const Color(primaryColorCode).withOpacity(0.5),
            500: const Color(primaryColorCode).withOpacity(0.6),
            600: const Color(primaryColorCode).withOpacity(0.7),
            700: const Color(primaryColorCode).withOpacity(0.8),
            800: const Color(primaryColorCode).withOpacity(0.9),
            900: const Color(primaryColorCode).withOpacity(1.0),
          },
        ),
        scaffoldBackgroundColor: const Color(0xFF171821),
        fontFamily: 'IBMPlexSans',
        brightness: Brightness.dark,
      ),
      initialRoute: '/login',
      routes: {
        '/dashboard': (context) => HomePage(scaffoldKey: GlobalKey<ScaffoldState>()),
        '/reservation': (context) => ReservationPage(scaffoldKey: GlobalKey<ScaffoldState>()),
        '/show_chart': (context) => ShowReservationPage(scaffoldKey: GlobalKey<ScaffoldState>()),
        '/users': (context) => UserListPage(),
         '/login': (context) => LoginPage(),
         '/signup': (context) => SignUpView(),
         '/forgetpassword': (context) => ForgetCodePage(),
      },
      home: LoginPage(),
    );
  }
}
