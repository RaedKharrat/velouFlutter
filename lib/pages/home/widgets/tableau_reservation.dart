import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';
import 'package:flutter_dashboard/service/api_service.dart';

class TableauReservation extends StatefulWidget {
  TableauReservation({Key? key}) : super(key: key);

  @override
  _TableauReservationState createState() => _TableauReservationState();
}

class _TableauReservationState extends State<TableauReservation> {
  List<TableauReservationClass> reservations = [];
  int rowsToShow = 10;
  bool hideIdReservation = false;
  bool hideDateReservation = false;
  bool hidePromoCode = false;
  bool hideTypePayment = false;
  bool hideEtat = false;
  bool hideIdUser = false;
  bool hideIdVelo = false;
  bool hideStripeCheckoutSessionId = false;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    try {
      final apiService = ApiService();
      final fetchedReservations = await apiService.fetchReservations();
      setState(() {
        reservations = fetchedReservations;
      });
    } catch (error) {
      print('Error fetching reservations: $error');
      // Handle error, for example, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reservation Management',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Set the text color to blue
                    ),
                    textAlign: TextAlign.center, // Center align the text
                  ),
                  IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hideIdReservation = !hideIdReservation;
                        hideIdUser = !hideIdUser;
                        hideIdVelo = !hideIdVelo;
                        hideStripeCheckoutSessionId =
                            !hideStripeCheckoutSessionId;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10,
                horizontalMargin: 20,
                dataRowHeight: 40,
                columns: [
                  if (!hideIdReservation)
                    DataColumn(label: _buildTableHeader('idReservation')),
                  if (!hideDateReservation)
                    DataColumn(label: _buildTableHeader('dateReservation')),
                  if (!hidePromoCode)
                    DataColumn(label: _buildTableHeader('promoCode')),
                  if (!hideTypePayment)
                    DataColumn(label: _buildTableHeader('typePayment')),
                  if (!hideEtat)
                    DataColumn(label: _buildTableHeader('etat')),
                  if (!hideIdUser)
                    DataColumn(label: _buildTableHeader('idUser')),
                  if (!hideIdVelo)
                    DataColumn(label: _buildTableHeader('idVelo')),
                  if (!hideStripeCheckoutSessionId)
                    DataColumn(
                        label: _buildTableHeader('stripeCheckoutSessionId')),
                  DataColumn(label: _buildTableHeader('Actions')),
                ],
                rows: reservations
                    .take(rowsToShow)
                    .map((reservation) => _buildDataRow(reservation))
                    .toList(),
              ),
            ),
            SizedBox(height: 10),
            if (reservations.length > rowsToShow)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    rowsToShow += 10;
                  });
                },
                child: Text('Show More'),
              ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(TableauReservationClass reservation) {
    return DataRow(cells: [
      if (!hideIdReservation)
        DataCell(_buildTableCell(reservation.idReservation)),
      if (!hideDateReservation)
        DataCell(_buildTableCell(reservation.dateReservation)),
      if (!hidePromoCode)
        DataCell(_buildTableCell(reservation.promoCode)),
      if (!hideTypePayment)
        DataCell(_buildTableCell(reservation.typePayment)),
      if (!hideEtat) DataCell(_buildTableCell(reservation.etat.toString())),
      if (!hideIdUser) DataCell(_buildTableCell(reservation.idUser)),
      if (!hideIdVelo) DataCell(_buildTableCell(reservation.idVelo)),
      if (!hideStripeCheckoutSessionId)
        DataCell(_buildTableCell(reservation.stripeCheckoutSessionId)),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState((){
                reservations.remove(reservation);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              // Handle send promo code action
            },
          ),
          IconButton(
            icon: Icon(Icons.show_chart, color: Colors.yellow),
            onPressed: () {
              // Handle show action
              _navigateToShowChart(context);
            },
          ),
        ],
      )),
    ]);
  }

  void _navigateToShowChart(BuildContext context) {
    // Navigate to the chart screen
    Navigator.pushNamed(context, '/show_chart');
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green, // Set background color as needed
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}