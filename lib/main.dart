import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  String _operator = '';
  double _firstOperand = 0;
  bool _shouldResetDisplay = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _display = '0';
        _operator = '';
        _firstOperand = 0;
        _shouldResetDisplay = false;
      } else if (value == '+/-') {
        if (_display != '0') {
          if (_display.startsWith('-')) {
            _display = _display.substring(1);
          } else {
            _display = '-$_display';
          }
        }
      } else if (value == '%') {
        double number = double.parse(_display);
        _display = (number / 100).toString();
        _removeTrailingZeros();
      } else if (value == '÷' || value == '×' || value == '-' || value == '+') {
        _firstOperand = double.parse(_display);
        _operator = value;
        _shouldResetDisplay = true;
      } else if (value == '=') {
        if (_operator.isNotEmpty) {
          double secondOperand = double.parse(_display);
          double result = 0;

          // Easter egg: 7 + = shows "Abhijeet"
          if (_firstOperand == 8 && _operator == '+' && secondOperand == 8) {
            _display = 'Abhijeet';
            _operator = '';
            _shouldResetDisplay = true; 
            return;
          }

          switch (_operator) {
            case '÷':
              result = _firstOperand / secondOperand;
              break;
            case '×':
              result = _firstOperand * secondOperand;
              break;
            case '-':
              result = _firstOperand - secondOperand;
              break;
            case '+':
              result = _firstOperand + secondOperand;
              break;
          }

          _display = result.toString();
          _removeTrailingZeros();
          _operator = '';
          _shouldResetDisplay = true;
        }
      } else if (value == '.') {
        if (_shouldResetDisplay) {
          _display = '0';
          _shouldResetDisplay = false;
        }
        if (!_display.contains('.')) {
          _display += '.';
        }
      } else {
        // Number button pressed
        if (_shouldResetDisplay || _display == '0') {
          _display = value;
          _shouldResetDisplay = false;
        } else {
          _display += value;
        }
      }
    });
  }

  void _removeTrailingZeros() {
    if (_display.contains('.')) {
      _display = _display.replaceAll(RegExp(r'\.?0*$'), '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Buttons
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildButtonRow(['AC', '+/-', '%', '÷']),
                    _buildButtonRow(['7', '8', '9', '×']),
                    _buildButtonRow(['4', '5', '6', '-']),
                    _buildButtonRow(['1', '2', '3', '+']),
                    _buildButtonRow(['0', '.', '=']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) {
          return _buildButton(button);
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String text) {
    Color backgroundColor;
    Color textColor = Colors.white;
    bool isWide = text == '0';

    // Apple calculator colors
    if (text == 'AC' || text == '+/-' || text == '%') {
      backgroundColor = const Color(0xFFA5A5A5); // Light gray
      textColor = Colors.black;
    } else if (text == '÷' || text == '×' || text == '-' || text == '+' || text == '=') {
      backgroundColor = const Color(0xFFFF9500); // Orange
    } else {
      backgroundColor = const Color(0xFF333333); // Dark gray
    }

    return Expanded(
      flex: isWide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isWide ? 50 : 100),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            padding: isWide ? const EdgeInsets.only(left: 32) : EdgeInsets.zero,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
