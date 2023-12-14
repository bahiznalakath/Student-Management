import 'package:flutter/material.dart';

class NewElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool dark;
  final Color color;

  const NewElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.dark,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
      ),
    );
  }
}
