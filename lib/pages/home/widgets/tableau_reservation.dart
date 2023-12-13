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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      
                    ),
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
                  DataColumn(label: _buildTableHeader('idReservation')),
                  DataColumn(label: _buildTableHeader('dateReservation')),
                  DataColumn(label: _buildTableHeader('promoCode')),
                  DataColumn(label: _buildTableHeader('typePayment')),
                  DataColumn(label: _buildTableHeader('etat')),
                  DataColumn(label: _buildTableHeader('idUser')),
                  DataColumn(label: _buildTableHeader('idVelo')),
                  DataColumn(label: _buildTableHeader('stripeCheckoutSessionId')),
                  DataColumn(label: _buildTableHeader('Actions')),
                ],
                rows: reservations.map((reservation) {
                  return _buildDataRow(reservation);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(TableauReservationClass reservation) {
    return DataRow(cells: [
      DataCell(_buildTableCell(reservation.idReservation)),
      DataCell(_buildTableCell(reservation.dateReservation)),
      DataCell(_buildTableCell(reservation.promoCode)),
      DataCell(_buildTableCell(reservation.typePayment)),
      DataCell(_buildTableCell(reservation.etat.toString())),
      DataCell(_buildTableCell(reservation.idUser)),
      DataCell(_buildTableCell(reservation.idVelo)),
      DataCell(_buildTableCell(reservation.stripeCheckoutSessionId)),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Handle delete action
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
