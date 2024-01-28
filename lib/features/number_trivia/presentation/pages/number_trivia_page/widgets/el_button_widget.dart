import 'package:flutter/material.dart';

class ElButtonWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onTap;

  const ElButtonWidget({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor ?? Colors.grey.shade300),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        "Get random trivia",
        style: TextStyle(color: textColor ?? Colors.black),
      ),
    );
  }
}
