import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/pages/home/widgets/header_widget.dart';
import 'package:flutter_dashboard/pages/home/widgets/activity_details_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/bar_graph_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/line_chart_card.dart';
import 'package:flutter_dashboard/pages/home/widgets/tableau_reservation.dart';
import 'package:flutter_dashboard/pages/home/widgets/show_reservation_card.dart';
import 'package:flutter_dashboard/widgets/menu.dart';
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';

class ShowReservationPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ShowReservationPage({Key? key, required this.scaffoldKey}) : super(key: key);

  SizedBox _height(BuildContext context) => SizedBox(
        height: Responsive.isDesktop(context) ? 30 : 20,
      );

  @override
  Widget build(BuildContext context) {
    // Assuming you have a list of reservations
    List<TableauReservationClass> reservations = []; // Replace this with your actual list

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Show Reservation Page'),
      ),
      endDrawer: Menu(scaffoldKey: scaffoldKey),
      body: Material(
        child: Row(
          children: [
            // Menu on the left side
            Menu(scaffoldKey: scaffoldKey), // Ensure the Menu widget is properly included only once
            // Main content on the right side
            Expanded(
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
                        // Include the Header widget

                        // Map through the list of reservations and create ShowReservationCard for each
                        ...reservations.map((reservation) => ShowReservationCard(reservation: reservation)).toList(),

                        _height(context),
                        const ActivityDetailsCard(),
                        _height(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
