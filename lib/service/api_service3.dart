import 'dart:convert';
import 'package:flutter_dashboard/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class AuthService {
  final String baseUrl="http://192.168.1.23:27017";

 
  AuthService();


    Future<Map<String, dynamic>> loginUser(String email, String password) async {
       Map<String, dynamic> responseData = {};
    try {
      await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).then((response)async {
      print('Response code: ${response.statusCode}');

      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);

        if (responseData.containsKey('user') &&
            responseData.containsKey('token')) {
          final user = responseData['user'];
          final token = responseData['token'];

          // Sauvegarder le token localement
          await saveSession('token', token);

          return responseData;
        } else {
          print('Invalid responseData format');
          throw Exception('Invalid responseData format');
        }
      } else if (response.statusCode == 401) {
        // Handle invalid credentials
        print('Invalid credentials');
        throw Exception('Invalid credentials');
      } else {
        // Handle other errors
        print('Failed to login. Status code: ${response.statusCode}');
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
      });


    } catch (error) {
      print('Error during login: $error');
      throw Exception('Error during login: $error');
    }

    return responseData;
  }

 Future<Map<String, dynamic>>registerUser(
  String email, String fullname, String username, String phone,String password) async {
 
    final response = await http.post(
      Uri.parse('$baseUrl/user/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'email': email, 'password': password, 'username': username,'phone': phone,'fullname': fullname,}),
    );

    if (response.statusCode == 200) {
      // Registration successful, parse the response
      return jsonDecode(response.body);
    } else {
      // Registration failed, handle the error
      throw Exception('Failed to register');
    }
  }


   Future<Map<String, dynamic>> logoutUser(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print ("bla bla bla");
        // Clear the user session/token after successful logout
        await clearSession('token');
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to logout');
      }
    } catch (error) {
      print('Error during logout: $error');
      throw Exception('Error during logout: $error');
    }
  }



Future<List<Map<String, dynamic>>> getAllUsers() async {
  try {
    // Retrieve the authentication token from SharedPreferences
    String? authToken = await getSession('token');

    if (authToken == null) {
      // Token not found, handle the error
      throw Exception('Authentication token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user/getAlluser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // Include the authentication token
      },
    );

    if (response.statusCode == 200) {
      // Fetch successful, parse the response
      List<dynamic> userList = jsonDecode(response.body);

      // Convert the list to a list of maps
      List<Map<String, dynamic>> users = userList
          .map((user) => Map<String, dynamic>.from(user))
          .toList();

      return users;
    } else {
      // Fetch failed, handle the error
      throw Exception('Failed to fetch users');
    }
  } catch (error) {
    throw Exception('Error fetching users: $error');
  }
}

  Future<void> saveSession(String token, String value) async { //
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);//
  }
    Future<void> clearSession(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<String?> getSession(String token) async { //
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token); //
  }

  Future<User?> getLoggedInUser() async {
    try {
      // Récupérer le token d'authentification depuis SharedPreferences
      String? authToken = await getSession('token');

      if (authToken == null) {
        // Token non trouvé, gérer l'erreur
        print('Token d\'authentification non trouvé');
        return null;
      }

      final response = await http.get(
        Uri.parse('http://192.168.1.12:9090/user/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userJson = jsonDecode(response.body);
        print(response.body);
        // Créer un objet User
        User user = User.fromJson(userJson);

        // Afficher les champs individuels de l'objet User
        print('User Connected:');
        print('ID: ${user.id}');
        print('Email: ${user.email}');
        print('fullname: ${user.fullname}');
        print('username: ${user.username}');
         print('phone: ${user.phone}');
        // Ajouter d'autres champs si nécessaire

        return user;
      } else {
        // Gérer la réponse d'erreur
        print(
            'Échec de la récupération des données de l\'utilisateur. Code d\'état : ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Gérer les erreurs réseau ou autres
      print(
          'Erreur lors de la récupération des données de l\'utilisateur : $error');
      return null;
    }
  }

 

// Function to save email in SharedPreferences
Future<void> saveEmailInPreferences(String email) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}

// Function to retrieve the saved email from SharedPreferences
Future<String?> getSavedEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<Map<String, dynamic>> sendResetCode(String email) async {
  print(email);
  try {
    // Save the email in SharedPreferences
    await saveEmailInPreferences(email);

    final response = await http.post(
      Uri.parse('$baseUrl/user/forgetPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      // Successful reset code sent, parse the response
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Handle failure, maybe throw an exception or return an error message
      throw Exception('Failed to send reset code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print('Error sending reset code: $error');
    throw Exception('Failed to send reset code');
  }
}

Future<bool> verifyResetCode(String enteredCode) async {
  try {
    // Retrieve the saved email from SharedPreferences
    final String? email = await getSavedEmail();

    if (email == null) {
      // Handle the case where the email is not found in SharedPreferences
      throw Exception('Email not found in SharedPreferences');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/user/VerifyOTP'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': enteredCode}),
    );

    if (response.statusCode == 200) {
      // Server returned success, reset code is valid
      return true;
    } else {
      // Reset code is not valid
      return false;
    }
  } catch (error) {
    // Handle network errors or other exceptions
    print('Error verifying reset code: $error');
    throw Exception('Failed to verify reset code');
  }
}
 Future<bool> changePassword(String newPassword) async {
  try {
       Map<String, dynamic> requestBody = {'new_password': newPassword};

    final response = await http.post(
      Uri.parse('$baseUrl/user/resetPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), 
     
    );

    if (response.statusCode == 200) {
      // Assuming the response is JSON and contains a 'success' field
     return true;
    } else {
      // Request was not successful, return false
      return false;
    }
  } catch (e) {
    // Error occurred during the API call, print error and return false
    print('Error: $e');
    return false;
  }
}
 Future<void> banUser(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString('userId');

      if (id == null) {
        throw Exception('User ID not found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/admin/$id/ban'),
        // Add any necessary headers or body for the request
      );

      if (response.statusCode == 200) {
        print('User banned successfully');
      } else {
        print('Error banning user: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during banUser: $error');
    }
  }

Future<void> unbanUser(String id) async {
  final response = await http.put(
    Uri.parse('$baseUrl/admin/$id/unban'),
  );

  if (response.statusCode == 200) {
    print('Utilisateur débanni avec succès');
  } else {
    print('Erreur lors du débannissement : ${response.statusCode}');
  }
}

Future<void> banUserWithDuration(String id, int durationInMinutes) async {
  final response = await http.put(
    Uri.parse('$baseUrl/admin/$id/banWithDuration'),
    body: {'durationInMinutes': durationInMinutes.toString()},
  );

  if (response.statusCode == 200) {
    print('Utilisateur banni avec succès pour une durée définie');
  } else {
    print('Erreur lors du bannissement avec durée : ${response.statusCode}');
  }
}


}
