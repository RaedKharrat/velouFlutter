import 'package:flutter/material.dart';
import 'package:flutter_dashboard/controller/common/custom_form_button.dart';
import 'package:flutter_dashboard/controller/common/page_heading.dart';
import 'package:flutter_dashboard/pages/UserValidationCode.dart';
import 'package:flutter_dashboard/pages/login_screen.dart';
import 'package:flutter_dashboard/service/api_service3.dart';


class ForgetCodePage extends StatefulWidget {
  const ForgetCodePage({Key? key}) : super(key: key);

  @override
  State<ForgetCodePage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetCodePage> {
  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
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
            Column(
              children: [
                Expanded(
                  child: Container(
              
                    child: SingleChildScrollView(
                      child: Form(
                        key: _forgetPasswordFormKey,
                        child: Column(
                          children: [
                            const PageHeading(
                              title: 'Forgot password',
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_rounded),
                                hintText: 'gmail',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter gmail';
                                } else if (!value.endsWith('@gmail.com')) {
                                  return 'please enter valid gmail';
                                }
                                return null;
                              },
                            ),
                            CustomFormButton(
                              innerText: 'Submit',
                              onPressed: _handleForgetPassword,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  ),
                                },
                                  child: Text(
                                      'Back to login',
                                          style: TextStyle(
                                           fontSize: 13,
                                            color: Colors.purple,
                                           fontWeight: FontWeight.bold,
                                                ),
                                             ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleForgetPassword() async {
    if (_forgetPasswordFormKey.currentState!.validate()) {
      try {
        await authService.sendResetCode(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset code sent successfully')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserValidationCode(),
          ),
        );
      } catch (error) {
        print('Error sending reset code: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send reset code. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
