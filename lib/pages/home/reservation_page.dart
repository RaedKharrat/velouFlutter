import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/pages/home/widgets/header_widget.dart';
import 'package:flutter_dashboard/pages/home/widgets/activity_details_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/bar_graph_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/line_chart_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/tableau_reservation.dart';
import 'package:flutter_dashboard/widgets/menu.dart';

class ReservationPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ReservationPage({Key? key, required this.scaffoldKey}) : super(key: key);

  SizedBox _height(BuildContext context) => SizedBox(
        height: Responsive.isDesktop(context) ? 30 : 20,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Reservation Page'),
      ),
      endDrawer: Menu(scaffoldKey: scaffoldKey),
      body: Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 15 : 18,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.isMobile(context) ? 5 : 18,
                  ),
                  // Placeholder for the Header widget (you can replace it with your actual Header widget)
                  // Assuming Header widget handles the drawer button, if not, make sure to include the drawer icon
                  Header(scaffoldKey: scaffoldKey),
                  _height(context),
                  const ActivityDetailsCard(),
                  _height(context),
                  TableauReservation(),
                  _height(context),
                  BarGraphCard(),
                  _height(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
