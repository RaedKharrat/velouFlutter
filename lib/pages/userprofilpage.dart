import 'package:flutter/material.dart';
import 'package:flutter_dashboard/service/api_service3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  final String username;
  final String fullName;
  final String email;
  final String id;
  final bool isBlocked;
  final AuthService authService = AuthService();

  UserProfilePage({
    this.username = "",
    this.fullName = "",
    this.email = "",
    this.isBlocked = false,
    required this.id,
  });

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late bool _isBlocked; // State variable to track profile block status

  @override
  void initState() {
    super.initState();
    _isBlocked = widget.isBlocked; // Initialize isBlocked from the widget property
    if (_isBlocked) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showBlockedSnackbar(context); // Show the snackbar if the profile is blocked
      });
    }
  }

  Future<String> getSelectedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? ''; // Retrieve the saved user ID
  }

  void showBlockedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This profile is blocked'),
        duration: Duration(seconds: 2), // Duration for which the snackbar is visible
      ),
    );
  }

  void showUnblockedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This profile is unblocked'),
        duration: Duration(seconds: 2), // Duration for which the snackbar is visible
      ),
    );
  }

  Widget buildBlockButton() {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString('userId') ?? '';
        await blockProfile(userId);
        showBlockedSnackbar(context); // Show snackbar after blocking the profile
      },
      child: Text('Block Profile'),
    );
  }

  Widget buildUnblockButton() {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString('userId') ?? '';
        await unblockProfile(userId);
        showUnblockedSnackbar(context); // Show snackbar after unblocking the profile
      },
      child: Text('Unblock Profile'),
    );
  }

  Future<void> blockProfile(String userId) async {
    try {
      await widget.authService.banUser(userId);
      print('Profile Blocked');
      setState(() {
        _isBlocked = true; // Update the state variable
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> unblockProfile(String id) async {
    try {
      await widget.authService.unbanUser(id);
      print('Profile Unblocked');
      setState(() {
        _isBlocked = false; // Update the state variable
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Stack(
        children: [
         
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Username: ${widget.username}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${widget.email}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.fullName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  _isBlocked
                      ? Builder(
                          builder: (context) {
                            return buildUnblockButton(); // Show unblock button if the profile is blocked
                          },
                        )
                      : buildBlockButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
