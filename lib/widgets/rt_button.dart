import 'package:flutter/material.dart';

class RtButton extends StatelessWidget {
  const RtButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isMaxWidth = true,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;
  final isMaxWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: isMaxWidth
          ? ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            )
          : ElevatedButton.styleFrom(
              minimumSize: Size(100, 50),
            ),
    );
  }
}
