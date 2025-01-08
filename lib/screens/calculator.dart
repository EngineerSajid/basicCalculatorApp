import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widgets/custom_button.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String textToDisplay = '';
  String history = '';

  void btnOnClick(String btnValue) {
    setState(() {
      if (btnValue == 'C') {
        textToDisplay = '';
      } else if (btnValue == 'AC') {
        textToDisplay = '';
        history = '';
      } else if (btnValue == '=') {
        try {
          // Evaluate the input string
          double result = _evaluateExpression(textToDisplay);

          // Update history with the current operation and result
          history += '$textToDisplay = ${_formatResult(result)}\n';
          List<String> historyLines = history.split('\n');
          if (historyLines.length > 5) {
            historyLines.removeAt(0); // Keep only the last 5 operations
          }
          history = historyLines.join('\n');

          // Update display with result
          textToDisplay = _formatResult(result);
        } catch (e) {
          textToDisplay = 'Error'; // Handle invalid input
        }
      } else if (btnValue == '<') {
        // Remove the last character from the input text
        if (textToDisplay.isNotEmpty) {
          textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
        }
      } else {
        // Append input to the display
        textToDisplay += btnValue;
      }
    });
  }

  double _evaluateExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression.replaceAll('x', '*'));
    ContextModel contextModel = ContextModel();
    return exp.evaluate(EvaluationType.REAL, contextModel);
  }

  String _formatResult(double result) {
    if (result % 1 == 0) {
      return result.toInt().toString(); // Show as integer if no fractional part
    }
    return result.toStringAsFixed(2); // Show up to 2 decimal places
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Basic Calculator App',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: Color(0xFFf4d160),
        ),
        backgroundColor: Color(0xFF28527a),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // History display
            Container(
              alignment: Alignment(1.0, 1.0),
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  history,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Current input display
            Container(
              alignment: Alignment(1.0, 1.0),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  textToDisplay,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  _buildButtonRow(['AC', 'C', '<', '/']),
                  _buildButtonRow(['7', '8', '9', 'x']),
                  _buildButtonRow(['4', '5', '6', '-']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['0', '00', '.', '=']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildButtonRow(List<String> buttonValues) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttonValues.map((btnValue) {
        return CalculatorButton(
          text: btnValue,
          textColor: 0xFF000000,
          fillColor: btnValue == '=' ||
                  btnValue == '/' ||
                  btnValue == 'x' ||
                  btnValue == '-' ||
                  btnValue == '+'
              ? 0xFFf4d160
              : 0xFF8ac4d0,
          textSize: btnValue == '=' ? 30 : 25,
          callback: btnOnClick,
        );
      }).toList(),
    );
  }
}
