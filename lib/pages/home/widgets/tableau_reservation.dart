import 'package:flutter/material.dart';

class TableauReservation extends StatelessWidget {
TableauReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Column 1')),
        DataColumn(label: Text('Column 2')),
        DataColumn(label: Text('Column 3')),
        DataColumn(label: Text('Column 4')),
        DataColumn(label: Text('Column 5')),
        DataColumn(label: Text('Column 6')),
        DataColumn(label: Text('Column 7')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Row 1, Cell 1')),
          DataCell(Text('Row 1, Cell 2')),
          DataCell(Text('Row 1, Cell 3')),
          DataCell(Text('Row 1, Cell 4')),
          DataCell(Text('Row 1, Cell 5')),
          DataCell(Text('Row 1, Cell 6')),
          DataCell(Text('Row 1, Cell 7')),
        ]),
        DataRow(cells: [
          DataCell(Text('Row 2, Cell 1')),
          DataCell(Text('Row 2, Cell 2')),
          DataCell(Text('Row 2, Cell 3')),
          DataCell(Text('Row 2, Cell 4')),
          DataCell(Text('Row 2, Cell 5')),
          DataCell(Text('Row 2, Cell 6')),
          DataCell(Text('Row 2, Cell 7')),
        ]),
      ],
    );
  }
}
