import 'package:flutter/material.dart';

class RtText extends StatelessWidget {
  const RtText({
    Key? key,
    required this.text,
    this.isHeader = false,
    this.isSubHeading = false,
    this.isSubtext = false,
    this.isWhite = false,
  }) : super(key: key);

  final String text;
  final bool isHeader;
  final bool isSubHeading;
  final bool isSubtext;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    if (isHeader) {
      textStyle = TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );
    } else if (isSubHeading) {
      textStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
    } else if (isSubtext) {
      textStyle = TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.normal,
      );
    } else {
      textStyle = TextStyle(
        fontWeight: FontWeight.normal,
      );
    }
    return SelectableText(
      text,
      style: isWhite ? textStyle.copyWith(color: Colors.white) : textStyle,
    );
  }
}
