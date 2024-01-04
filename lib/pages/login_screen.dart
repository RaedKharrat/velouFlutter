
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/pages/ForgetCodePage.dart';
import 'package:flutter_dashboard/pages/register_page.dart';
import 'package:flutter_dashboard/pages/home/home_page.dart';
import 'package:flutter_dashboard/service/api_service3.dart';
import 'package:flutter_dashboard/widgets/widget.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final AuthService authService;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    // Initialize the authService here
    authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'images/_.png.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo.png',
                    width: 100,
                    height: 200,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    hintText: 'Phone, email or username',
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  MyPasswordField(
                    isPasswordVisible: isPasswordVisible,
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add additional password validation if needed
                      return null;
                    },
                    controller: passwordController,
                  ),
                  MyTextButton(
                    buttonName: 'Sign In',
                    bgColor: Colors.green, // Provide a background color
                    textColor: Colors.white, // Provide a text color
                    onTap: () {
                      authService
                          .loginUser(emailController.text, passwordController.text)
                          .then((result) {
                        print(emailController.toString());
                        print(passwordController.toString());

                        final Map<String, dynamic> user = result['user'];

                        // Example: Navigate to a new page after successful login
                        print("Logged in successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(scaffoldKey: GlobalKey<ScaffoldState>()),
                          ),
                        );
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetCodePage(),
                            ),
                          ),
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                              color: Color.fromRGBO(40, 97, 11, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).paddingOnly(right: 20),
                      ),
                      Text(
                        "Don't have an account? ",
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignUpView(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            // Add your text style here
                          ),
                        ),
                      ),
                    ],
                  ).paddingAll(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}