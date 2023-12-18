import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/responsive.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';
import 'package:flutter_dashboard/service/api_service.dart';

class LineChartCard extends StatefulWidget {
  LineChartCard({Key? key}) : super(key: key);

  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  late Future<List<FlSpot>> futureSpots;

  @override
  void initState() {
    super.initState();
    futureSpots = fetchReservationsByDay();
  }

  Future<List<FlSpot>> fetchReservationsByDay() async {
    final List<Map<String, dynamic>> reservations = await ApiService().fetchReservationsByDay();

    // Convert the reservation data to a list of FlSpot
    final List<FlSpot> spots = reservations
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value['count'].toDouble()))
        .toList();

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total of reservation per day",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          AspectRatio(
            aspectRatio: Responsive.isMobile(context) ? 9 / 4 : 16 / 6,
            child: FutureBuilder<List<FlSpot>>(
              future: futureSpots,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: snapshot.data!,
                        ),
                      ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
