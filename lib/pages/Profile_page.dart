import 'package:flutter/material.dart';
import 'package:flutter_dashboard/service/api_service3.dart';
import 'package:flutter_dashboard/pages/userprofilpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      AuthService authService = AuthService();
      List<Map<String, dynamic>> users = await authService.getAllUsers();
      setState(() {
        userList = users;
      });
      print('Fetched ${userList.length} users: $userList');
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  Widget buildUserListTile(Map<String, dynamic> user) {
    final username = user['username'] ?? '';
    final email = user['email'] ?? '';
    final id = user['_id'] ?? '';

    if (username.isEmpty || email.isEmpty) {
      print('Skipped rendering user: $user');
      return SizedBox.shrink();
    }

    print('Rendering user: $user');

    return ListTile(
      title: Text(
        username,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(email),
      leading: CircleAvatar(
        child: Text(
          username.isNotEmpty ? username[0].toUpperCase() : '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 170, 183, 183),
      ),
      onTap: () {
        navigateToUserProfile(user);
      },
    );
  }

  Future<void> navigateToUserProfile(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = user['_id'].toString() ?? '';
    await prefs.setString('userId', userId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          username: user['username'] ?? '',
          fullName: user['fullName'] ?? '',
          email: user['email'] ?? '',
          id: userId,
          isBlocked: user['isBlocked'] ?? false,
        ),
      ),
    );
  }

  void sortUsers(bool byDate) {
    setState(() {
      if (byDate) {
        userList.sort((a, b) =>
            DateTime.parse(a['createdAt']).compareTo(DateTime.parse(b['createdAt'])));
      } else {
        userList.sort((a, b) => a['username'].compareTo(b['username']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () => sortUsers(false),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => sortUsers(true),
          ),
        ],
      ),
      body: Stack(
        children: [
          
          ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                elevation: 2,
                child: buildUserListTile(userList[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
