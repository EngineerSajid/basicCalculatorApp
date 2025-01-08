import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalculatorButton({
    required this.text,
    required this.fillColor,
    required this.callback,
    required this.textColor,
    required this.textSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(text),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(fillColor),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w500,
                color: Color(textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
