// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dashboard/model/tableau_ReservationClass.dart';
import 'package:flutter_dashboard/pages/home/widgets/line_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';



class ApiService {

   Future<List<Map<String, dynamic>>> fetchReservationsByDay() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/reservationstat'),
        headers: {'Cache-Control': 'no-cache'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
          final List<dynamic> reservationsJson = jsonData['data'];

          final List<Map<String, dynamic>> reservations = reservationsJson.cast<Map<String, dynamic>>();

          return reservations;
        } else {
          throw Exception('Invalid data format: $jsonData');
        }
      } else {
        throw Exception(
            'Failed to fetch reservation data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching reservation data: $error');
      throw Exception('Error fetching reservation data: $error');
    }
  }


  Future<List<TableauReservationClass>> fetchReservations() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/allreservations'),
        headers: {'Cache-Control': 'no-cache'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData.containsKey('allReservations')) {
          final List<dynamic> reservationsJson = jsonData['allReservations'];

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
      throw Exception('Error fetching reservations: $error');
    }
  }

  Future<int> fetchTotalReservations() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/totalreservation'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['totalReservations'];
      } else {
        throw Exception('Failed to load total reservations. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total reservations: $error');
      throw Exception('Error fetching total reservations: $error');
    }
  }

  Future<int> fetchLoadedReservations() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/loadedreservation'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['loadedReservations'];
      } else {
        throw Exception('Failed to load loaded reservations. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching loaded reservations: $error');
      throw Exception('Error fetching loaded reservations: $error');
    }
  }

  Future<int> fetchFinishedReservations() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/finishedreservation'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['finishedReservations'];
      } else {
        throw Exception('Failed to load finished reservations. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching finished reservations: $error');
      throw Exception('Error fetching finished reservations: $error');
    }
  }

  Future<int> fetchTotalTransaction() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:27017/reservation/reservation/totaltransaction'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['totalTransaction'];
      } else {
        throw Exception('Failed to load total transaction. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total transaction: $error');
      throw Exception('Error fetching total transaction: $error');
    }
  }
    Future<void> sendPromoCode(String promoCode, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:27017/reservation/reservation/sendpromocode'),
        body: {'promoCode': promoCode, 'userId': userId},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send promo code. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending promo code: $error');
      throw Exception('Error sending promo code: $error');
    }
  }

  Future<void> deleteReservation(String reservationId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:27017/reservation/reservation/$reservationId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete reservation. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error deleting reservation: $error');
    throw Exception('Error deleting reservation: $error');
  }
}

}
