import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const.dart';
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';
import 'package:flutter_dashboard/pages/home/widgets/show_reservation_card.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/service/api_service.dart';

class TableauReservation extends StatefulWidget {
  TableauReservation({Key? key}) : super(key: key);

  @override
  _TableauReservationState createState() => _TableauReservationState();
}

class _TableauReservationState extends State<TableauReservation> {
  List<TableauReservationClass> reservations = [];
  List<TableauReservationClass> filteredReservations = [];
  int rowsToShow = 10;
  bool hideIdReservation = false;
  bool hideDateReservation = false;
  bool hidePromoCode = false;
  bool hideTypePayment = false;
  bool hideEtat = false;
  bool hideIdUser = false;
  bool hideIdVelo = false;
  bool hideStripeCheckoutSessionId = false;
  TextEditingController passwordController = TextEditingController();
  bool isHidden = false;
  bool sortAscending = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchReservations();
    _sortReservations();
  }

  Future<void> fetchReservations() async {
    try {
      final apiService = ApiService();
      final fetchedReservations = await apiService.fetchReservations();
      setState(() {
        reservations = fetchedReservations;
        filteredReservations = List.from(reservations);
      });
    } catch (error) {
      print('Error fetching reservations: $error');
    }
  }

  void _navigateToShowChart(BuildContext context, TableauReservationClass reservation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowReservationCard(reservation: reservation),
      ),
    );
  }

  DataRow _buildDataRow(TableauReservationClass reservation) {
    return DataRow(cells: [
      if (!hideIdReservation) DataCell(_buildTableCell(reservation.idReservation)),
      if (!hideDateReservation) DataCell(_buildTableCell(reservation.shortDateReservation)),
      if (!hidePromoCode) DataCell(_buildTableCell(reservation.promoCode)),
      if (!hideTypePayment) DataCell(_buildTableCell(reservation.typePayment)),
      if (!hideEtat) DataCell(_buildTableCell(reservation.etat.toString())),
      if (!hideIdUser) DataCell(_buildTableCell(reservation.idUser)),
      if (!hideIdVelo) DataCell(_buildTableCell(reservation.idVelo)),
      if (!hideStripeCheckoutSessionId) DataCell(_buildTableCell(reservation.stripeCheckoutSessionId)),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmationDialog(reservation.idReservation);
            },
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              _sendPromoCode(reservation.promoCode, reservation.idUser);
            },
          ),
          IconButton(
            icon: Icon(Icons.show_chart, color: Colors.yellow),
            onPressed: () {
              _navigateToShowChart(context, reservation);
            },
          ),
        ],
      )),
    ]);
  }

  Future<void> _showDeleteConfirmationDialog(String reservationId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this reservation?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteReservation(reservationId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteReservation(String reservationId) async {
    try {
      final apiService = ApiService();
      await apiService.deleteReservation(reservationId);
      print('Reservation deleted successfully.');
    } catch (error) {
      print('Error deleting reservation: $error');
    }
  }

  void _filterReservations() {
    final String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredReservations = List.from(reservations);
      } else {
        filteredReservations = reservations
            .where((reservation) =>
                reservation.idReservation.toLowerCase().contains(query) ||
                reservation.shortDateReservation.toLowerCase().contains(query) ||
                reservation.promoCode.toLowerCase().contains(query) ||
                reservation.typePayment.toLowerCase().contains(query) ||
                reservation.etat.toString().toLowerCase().contains(query) ||
                reservation.idUser.toLowerCase().contains(query) ||
                reservation.idVelo.toLowerCase().contains(query) ||
                reservation.stripeCheckoutSessionId
                    .toLowerCase()
                    .contains(query))
            .toList();
      }
    });
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
              child: Column(
                children: [
                  // Title
                  Text(
                    'Reservation Management',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Password visibility and sort options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Password visibility
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Enter Password'),
                                content: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      if (passwordController.text == '0000') {
                                        setState(() {
                                          isHidden = !isHidden;
                                          hideIdReservation = isHidden;
                                          hideIdUser = isHidden;
                                          hideIdVelo = isHidden;
                                          hideStripeCheckoutSessionId = isHidden;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Incorrect password.'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // Sort Dropdown
                      DropdownButton<bool>(
                        value: sortAscending,
                        onChanged: (value) {
                          setState(() {
                            sortAscending = value!;
                            _sortReservations();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Ascending'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Descending'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Search Bar
                  SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      _filterReservations();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardBackgroundColor,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 21,
                      ),
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
                  if (!hideIdReservation) DataColumn(label: _buildTableHeader('idReservation')),
                  if (!hideDateReservation) DataColumn(label: _buildTableHeader('dateReservation')),
                  if (!hidePromoCode) DataColumn(label: _buildTableHeader('promoCode')),
                  if (!hideTypePayment) DataColumn(label: _buildTableHeader('typePayment')),
                  if (!hideEtat) DataColumn(label: _buildTableHeader('etat')),
                  if (!hideIdUser) DataColumn(label: _buildTableHeader('idUser')),
                  if (!hideIdVelo) DataColumn(label: _buildTableHeader('idVelo')),
                  if (!hideStripeCheckoutSessionId) DataColumn(label: _buildTableHeader('stripeCheckoutSessionId')),
                  DataColumn(label: _buildTableHeader('Actions')),
                ],
                rows: filteredReservations
                    .take(rowsToShow)
                    .map((reservation) => _buildDataRow(reservation))
                    .toList(),
              ),
            ),
            SizedBox(height: 10),
            if (filteredReservations.length > rowsToShow)
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
        color: Colors.green,
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

  Future<void> _sendPromoCode(String promoCode, String userId) async {
    try {
      final apiService = ApiService();
      await apiService.sendPromoCode(promoCode, userId);
      print('Promo code sent successfully.');
    } catch (error) {
      print('Error sending promo code: $error');
    }
  }

  void _sortReservations() {
    setState(() {
      filteredReservations.sort((a, b) {
        if (sortAscending) {
          return a.dateReservation.compareTo(b.dateReservation);
        } else {
          return b.dateReservation.compareTo(a.dateReservation);
        }
      });
    });
  }
}
