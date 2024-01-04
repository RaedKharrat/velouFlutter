import 'package:flutter/material.dart';
//import '../constants.dart';

class MyPasswordField extends StatelessWidget {
  const MyPasswordField({
    Key? key,
    required this.isPasswordVisible,
    required this.onTap,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final bool isPasswordVisible;
  final VoidCallback onTap;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (validator != null) {
            validator!(value);
          }
        },
        //style: kBodyText.copyWith(color: Color.fromRGBO(40, 97, 11, 1)),
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_open),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(20),
          hintText: 'Password',
         // hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(40, 97, 11, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}