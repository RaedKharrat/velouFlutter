// cercle_stat.dart
import 'package:flutter/material.dart';

class CircularStatisticChart extends StatelessWidget {
  final double total;
  final double loaded;
  final double finished;
  final double totalTransaction;

  CircularStatisticChart({
    required this.total,
    required this.loaded,
    required this.finished,
    required this.totalTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0, // Adjust the size as needed
      height: 200.0,
      child: CircularProgressIndicator(
        value: total / 100, // Adjust the values based on your data
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Adjust the color
        strokeWidth: 10.0, // Adjust the thickness of the circle
        backgroundColor: Colors.grey[300], // Adjust the background color
      ),
    );
  }
}
