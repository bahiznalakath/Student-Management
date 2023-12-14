import 'package:flutter/material.dart';


class NewIconColumnTextWidget extends StatelessWidget {
  final IconData iconData;
  final String type;
  final VoidCallback onTap;

  const NewIconColumnTextWidget({
    super.key,
    required this.ht,
    required this.iconData,
    required this.wt,
    required this.type,
    required this.onTap,
  });

  final double ht;
  final double wt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            size: ht * .05,
            color: Colors.greenAccent,
          ),
          Text(
            type,
          )
        ],
      ),
    );
  }
}