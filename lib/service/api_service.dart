import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';

class ApiService {
  Future<List<TableauReservationClass>> fetchReservations() async {
    try {
      // Update the URL to match your backend endpoint
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/allreservations'),
        headers: {'Cache-Control': 'no-cache'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData.containsKey('allReservations')) {
          final List<dynamic> reservationsJson = jsonData['allReservations'];

          // Use .cast<Map<String, dynamic>>() to ensure type safety
          return reservationsJson
              .map((json) => TableauReservationClass.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid data format: $jsonData');
        }
      } else {
        throw Exception('Failed to fetch reservations. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching reservations: $error');
      // Handle error, for example, show an error message to the user
      throw Exception('Error fetching reservations: $error');
    }
  }
}
