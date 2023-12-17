import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';

class ShowReservationCard extends StatefulWidget {
  final TableauReservationClass reservation;

  ShowReservationCard({required this.reservation});

  @override
  _ShowReservationCardState createState() => _ShowReservationCardState();
}

class _ShowReservationCardState extends State<ShowReservationCard> {
  DateTime? _selectedDate;
  String? _selectedPaymentMethod;
  String? _selectedStatus;

  final List<String> paymentMethods = ['Credit Card', 'Pay Later'];
  final List<String> statusOptions = ['Loading', 'Done'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Reservation ID:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Reservation ID',
              ),
              initialValue: widget.reservation.idReservation,
            ),
            SizedBox(height: 10),
            Text(
              'Reservation date :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Reservation date',
                ),
                child: _selectedDate != null
                    ? Text(
                        "${_selectedDate!.toLocal()}".split(' ')[0],
                      )
                    : Text('Select Date'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Payment Method :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue;
                });
              },
              items: paymentMethods.map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Payment Method',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Status :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
              items: statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Status',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Promo Code :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Reservation Promo Code',
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit button press
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    primary: Colors.green,
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
