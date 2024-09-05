import 'package:flutter/material.dart';

class SwipeActionCircle extends StatelessWidget {
  const SwipeActionCircle({required this.color, required this.icon, super.key});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
