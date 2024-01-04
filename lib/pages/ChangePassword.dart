import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/home/home_page.dart';
import 'package:flutter_dashboard/service/api_service3.dart';

void main() {
  runApp(MaterialApp(
    home: ChangePassword(),
  ));
}

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'images/_.png.jpg', // Replace with your image path
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ChangePasswordForm(),
        ],
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  AuthService apiservice = AuthService();

  Future<void> _changePassword() async {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword == confirmPassword) {
      bool success = await apiservice.changePassword(newPassword);
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(scaffoldKey: GlobalKey<ScaffoldState>())),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Password change failed. Please try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Passwords do not match'),
            content: Text('Please make sure the passwords match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: newPasswordController,
            decoration: InputDecoration(
              hintText: 'Enter new password',
              labelText: 'New Password', // Added placeholder
              fillColor: Colors.white,
              filled: true,
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              hintText: 'Confirm new password',
              labelText: 'Confirm Password', // Added placeholder
              fillColor: Colors.white,
              filled: true,
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _changePassword();
            },
            child: Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
