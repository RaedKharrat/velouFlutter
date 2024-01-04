import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/ChangePassword.dart';
import 'package:flutter_dashboard/service/api_service3.dart';

void main() {
  runApp(MaterialApp(
    home: UserValidationCode(),
  ));
}

class UserValidationCode extends StatefulWidget {
  @override
  _UserValidationCodeState createState() => _UserValidationCodeState();
}

class _UserValidationCodeState extends State<UserValidationCode> {
  final TextEditingController _codeController = TextEditingController();
  AuthService apiservice = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle back button press
                    },
                    color: Colors.black, // Back button color
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Verification Code',
                          style: TextStyle(
                            color: Colors.green, // Title text color
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please enter the verification code sent to your email',
                          style: TextStyle(
                            color: Colors.black, // Subtitle text color
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            hintText: 'verification code',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _handleValidationCode(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Button background color
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black, // Button text color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleValidationCode(BuildContext context) async {
    final enteredCode = _codeController.text;

    try {
      final isCodeValid = await apiservice.verifyResetCode(enteredCode);

      if (isCodeValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePassword(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid verification code'),
              actions: [
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
    } catch (error) {
      print('Error verifying reset code: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to verify reset code'),
            actions: [
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
}
