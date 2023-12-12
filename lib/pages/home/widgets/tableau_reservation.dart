import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';
import 'package:flutter_dashboard/const.dart';


class TableauReservation extends StatelessWidget {
  TableauReservation({Key? key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reservation Management',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: DataTable(
                  columnSpacing: 10,
                  horizontalMargin: Responsive.isMobile(context) ? 10 : 20,
                  dataRowHeight: 40,
                  columns: [
                    DataColumn(label: _buildTableHeader(context, 'id Reservation')),
                    DataColumn(label: _buildTableHeader(context, 'Date reservation')),
                    DataColumn(label: _buildTableHeader(context, 'Type Payment')),
                    DataColumn(label: _buildTableHeader(context, 'etat')),
                    DataColumn(label: _buildTableHeader(context, 'id user')),
                    DataColumn(label: _buildTableHeader(context, 'id velou')),
                    DataColumn(label: _buildTableHeader(context, 'PromoCode')),
                    DataColumn(label: _buildTableHeader(context, 'Stripe Session Id')),
                    DataColumn(label: _buildTableHeader(context, 'Actions')),
                  ],
                  rows: [
                    _buildDataRow(context, ['198465e98ze65zazr9', '20/10/2021', 'Credit Card', 'Done', 'zef168ze4f1z8ef61e', 'zef168ze4f1z8ef61e','HU65AA', 'Ch-z654efzef68z5efzevz8e5z1ef']),
                    _buildDataRow(context, ['198465e98ze65zazr9', '20/10/2021', 'Credit Card', 'Done', 'zef168ze4f1z8ef61e', 'zef168ze4f1z8ef61e','HU65AA', 'Ch-z654efzef68z5efzevz8e5z1ef']),
                    _buildDataRow(context, ['198465e98ze65zazr9', '20/10/2021', 'Credit Card', 'Done', 'zef168ze4f1z8ef61e', 'zef168ze4f1z8ef61e','HU65AA', 'Ch-z654efzef68z5efzevz8e5z1ef']),
                    _buildDataRow(context, ['198465e98ze65zazr9', '20/10/2021', 'Credit Card', 'Done', 'zef168ze4f1z8ef61e', 'zef168ze4f1z8ef61e','HU65AA', 'Ch-z654efzef68z5efzevz8e5z1ef']),
                    _buildDataRow(context, ['198465e98ze65zazr9', '20/10/2021', 'Credit Card', 'Done', 'zef168ze4f1z8ef61e', 'zef168ze4f1z8ef61e','HU65AA', 'Ch-z654efzef68z5efzevz8e5z1ef']),
                    // Add more rows as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(BuildContext context, List<String> cells) {
    return DataRow(cells: [
      for (var cell in cells) DataCell(_buildTableCell(context, cell)),
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
    Navigator.pushNamed(context, '/show_chart');
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
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green, // Set the text color to green
          ),
        ),
      ),
    );
  }

  
}
