// activity_details_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/model/health_model.dart';
import 'package:flutter_dashboard/widgets/custom_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dashboard/service/api_service.dart';

class ActivityDetailsCard extends StatefulWidget {
  const ActivityDetailsCard({Key? key}) : super(key: key);

  @override
  _ActivityDetailsCardState createState() => _ActivityDetailsCardState();
}

class _ActivityDetailsCardState extends State<ActivityDetailsCard> {
  late Future<int> _totalReservations;
  late Future<int> _loadedReservations;
  late Future<int> _finishedReservations;
  late Future<int> _totalTransaction;

  @override
  void initState() {
    super.initState();
    _totalReservations = ApiService().fetchTotalReservations();
    _loadedReservations = ApiService().fetchLoadedReservations();
    _finishedReservations = ApiService().fetchFinishedReservations();
    _totalTransaction = ApiService().fetchTotalTransaction();
  }

  Future<void> _refreshData() async {
    setState(() {
      _totalReservations = ApiService().fetchTotalReservations();
      _loadedReservations = ApiService().fetchLoadedReservations();
      _finishedReservations = ApiService().fetchFinishedReservations();
      _totalTransaction = ApiService().fetchTotalTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _totalReservations,
      builder: (context, totalSnapshot) {
        if (totalSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (totalSnapshot.hasError) {
          return Text('Error: ${totalSnapshot.error}');
        } else if (!totalSnapshot.hasData) {
          return Text('No data available');
        } else {
          return FutureBuilder<int>(
            future: _loadedReservations,
            builder: (context, loadedSnapshot) {
              if (loadedSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (loadedSnapshot.hasError) {
                return Text('Error: ${loadedSnapshot.error}');
              } else if (!loadedSnapshot.hasData) {
                return Text('No data available');
              } else {
                return FutureBuilder<int>(
                  future: _finishedReservations,
                  builder: (context, finishedSnapshot) {
                    if (finishedSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (finishedSnapshot.hasError) {
                      return Text('Error: ${finishedSnapshot.error}');
                    } else if (!finishedSnapshot.hasData) {
                      return Text('No data available');
                    } else {
                      return FutureBuilder<int>(
                        future: _totalTransaction,
                        builder: (context, transactionSnapshot) {
                          if (transactionSnapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (transactionSnapshot.hasError) {
                            return Text('Error: ${transactionSnapshot.error}');
                          } else if (!transactionSnapshot.hasData) {
                            return Text('No data available');
                          } else {
                            final List<HealthModel> healthDetails = [
                              HealthModel(
                                icon: 'assets/svg/burn.svg',
                                value: totalSnapshot.data.toString(),
                                title: "Total Reservations",
                              ),
                              HealthModel(
                                icon: 'assets/svg/burn.svg',
                                value: loadedSnapshot.data.toString(),
                                title: "Loaded Reservations",
                              ),
                              HealthModel(
                                icon: 'assets/svg/burn.svg',
                                value: finishedSnapshot.data.toString(),
                                title: "Finished Reservations",
                              ),
                              HealthModel(
                                icon: 'assets/svg/burn.svg',
                                value: transactionSnapshot.data.toString(),
                                title: "Total Transaction",
                              ),
                            ];

                            return GridView.builder(
                              itemCount: healthDetails.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                                crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
                                mainAxisSpacing: 12.0,
                              ),
                              itemBuilder: (context, i) {
                                return CustomCard(
                                  child: GestureDetector(
                                    onTap: _refreshData,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(healthDetails[i].icon),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15, bottom: 4),
                                          child: Text(
                                            healthDetails[i].value,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          healthDetails[i].title,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
