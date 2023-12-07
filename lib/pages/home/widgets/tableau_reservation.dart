import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';

class TableauReservation extends StatelessWidget {
  TableauReservation({Key? key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the title
          children: [
            SizedBox(height: 10), // Add spacing above the title
            Text(
              'Reservation Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10), // Add spacing below the title
            DataTable(
              columnSpacing: 10,
              horizontalMargin: Responsive.isMobile(context) ? 10 : 20,
              dataRowHeight: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              columns: [
                DataColumn(label: _buildTableHeader(context, 'id Reservation')),
                DataColumn(label: _buildTableHeader(context, 'Date reservation')),
                DataColumn(label: _buildTableHeader(context, 'Type Payment')),
                DataColumn(label: _buildTableHeader(context, 'etat')),
                DataColumn(label: _buildTableHeader(context, 'id user')),
                DataColumn(label: _buildTableHeader(context, 'id velou')),
                DataColumn(label: _buildTableHeader(context, 'PromoCode')),
                DataColumn(label: _buildTableHeader(context, 'Stripe Session Id')),
              ],
              rows: [
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                _buildDataRow(context, ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3', 'Row 1, Cell 4', 'Row 1, Cell 5', 'Row 1, Cell 6', 'Row 1, Cell 7', 'Row 1, Cell 8']),
                // Add more rows as needed
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(BuildContext context, List<String> cells) {
    return DataRow(cells: [
      for (var cell in cells) DataCell(_buildTableCell(context, cell)),
    ]);
  }

  Widget _buildTableCell(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
