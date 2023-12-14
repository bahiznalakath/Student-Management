import 'package:flutter/material.dart';
import '../constants/validators.dart';

class NewTextFormFieldPasswordWidget extends StatelessWidget {
  final bool obscure;
  final TextEditingController controller;

  final IconButton iconButton;

  const NewTextFormFieldPasswordWidget({
    super.key,
    required this.obscure,
    required this.controller,
    required this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        validator: MyValidator.validatePassword,
        obscureText: obscure,
        obscuringCharacter: "*",
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: iconButton,
            filled: true,
            fillColor: Colors.white,
            labelText: 'Password',
            prefixIcon:  const Icon(Icons.password,)));
  }
}
class NewTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData iconData;
  final dynamic validator;
  final TextInputType keyBoardType;
  final bool dark;

  const NewTextFieldWidget({
    super.key,
    required this.controller,
    required this.iconData,
    required this.labelText,
    required this.validator,
    required this.keyBoardType,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyBoardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            labelText: labelText,
            prefixIcon: Icon(
              iconData,
            )));
  }
}
