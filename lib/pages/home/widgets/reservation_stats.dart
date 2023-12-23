import 'package:flutter/material.dart';
import 'package:flutter_dashboard/service/api_service.dart';
import 'package:fl_chart/fl_chart.dart';

class ReservationStats extends StatefulWidget {
  const ReservationStats({Key? key}) : super(key: key);

  @override
  _ReservationStatsState createState() => _ReservationStatsState();
}

class _ReservationStatsState extends State<ReservationStats> {
  late Future<Map<String, dynamic>> _paymentPercentage;

  @override
  void initState() {
    super.initState();
    _paymentPercentage = ApiService().getPaymentPercentage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _paymentPercentage,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.purple,
                    value: snapshot.data!['paymentStats'][0]['percentage'],
                    title: 'Pay Later',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.cyan,
                    value: snapshot.data!['paymentStats'][1]['percentage'],
                    title: 'Credit Card',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                startDegreeOffset: -90,
              ),
            ),
          );
        }
      },
    );
  }
}
