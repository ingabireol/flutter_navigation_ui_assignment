import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as google_fonts;

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentNumber = "";
  String _operation = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentNumber = "";
        _operation = "";
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        if (_currentNumber.isNotEmpty) {
          _num1 = double.parse(_currentNumber);
          _operation = buttonText;
          _currentNumber = "";
        }
      } else if (buttonText == "%") {
        if (_currentNumber.isNotEmpty) {
          double number = double.parse(_currentNumber);
          _currentNumber = (number / 100).toString();
          _output = _currentNumber;
        }
      } else if (buttonText == ".") {
        if (!_currentNumber.contains(".")) {
          _currentNumber += buttonText;
        }
      } else if (buttonText == "=") {
        if (_currentNumber.isNotEmpty && _operation.isNotEmpty) {
          _num2 = double.parse(_currentNumber);
          switch (_operation) {
            case "+":
              _currentNumber = (_num1 + _num2).toString();
              break;
            case "-":
              _currentNumber = (_num1 - _num2).toString();
              break;
            case "×":
              _currentNumber = (_num1 * _num2).toString();
              break;
            case "÷":
              _currentNumber = (_num1 / _num2).toString();
              break;
          }
          _operation = "";
          _num1 = 0;
          _num2 = 0;
        }
      } else {
        _currentNumber += buttonText;
      }

      if (_currentNumber.isEmpty) {
        _output = "0";
      } else {
        _output = _currentNumber;
      }
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: google_fonts.GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: 24.0,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: google_fonts.GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 60.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildButton("C", Colors.grey[700]!, Colors.white),
                      _buildButton("%", Colors.grey[700]!, Colors.white),
                      _buildButton("÷", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("7", Colors.grey[850]!, Colors.white),
                      _buildButton("8", Colors.grey[850]!, Colors.white),
                      _buildButton("9", Colors.grey[850]!, Colors.white),
                      _buildButton("×", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("4", Colors.grey[850]!, Colors.white),
                      _buildButton("5", Colors.grey[850]!, Colors.white),
                      _buildButton("6", Colors.grey[850]!, Colors.white),
                      _buildButton("-", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("1", Colors.grey[850]!, Colors.white),
                      _buildButton("2", Colors.grey[850]!, Colors.white),
                      _buildButton("3", Colors.grey[850]!, Colors.white),
                      _buildButton("+", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("0", Colors.grey[850]!, Colors.white),
                      _buildButton(".", Colors.grey[850]!, Colors.white),
                      _buildButton("=", Colors.orange, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
