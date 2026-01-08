import 'package:calculator/constants/colors.dart';
import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/display_area.dart';
import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  static const String _divideByZeroMessage = 'Cannot divide by zero';

  String result = '0';
  String input = '';
  String operation = '';
  String expression = '';

  double? _firstOperand;

  String get _displayValue => input.isNotEmpty ? input : result;

  String get _expressionText {
    if (expression.isEmpty && operation.isEmpty) return '';

    if (operation.isNotEmpty) {
      final String left = expression.isNotEmpty ? expression : (input.isNotEmpty ? input : result);
      return input.isNotEmpty ? '$left$operation$input' : '$left$operation';
    }

    return expression;
  }

  String _formatNumber(double value) {
    final String asString = value.toString();
    return asString.endsWith('.0') ? asString.substring(0, asString.length - 2) : asString;
  }

  int _digitCount(String value) {
    return RegExp(r'\d').allMatches(value).length;
  }

  bool get _hasError => result == _divideByZeroMessage;

  void onDigitPress(String digit) {
    setState(() {
      if (_hasError) {
        result = '0';
        input = '';
        operation = '';
        expression = '';
        _firstOperand = null;
      }

      if (expression.isNotEmpty && operation.isEmpty && _firstOperand == null) {
        result = '0';
        expression = '';
      }

      if (digit == '.') {
        if (input.isEmpty) {
          input = '0.';
          return;
        }
        if (input.contains('.')) return;
        input += digit;
        return;
      }

      if (_digitCount(input) >= 10) return;

      if (input == '0') {
        input = digit;
      } else {
        input += digit;
      }
    });
  }

  void onOperatorPress(String op) {
    setState(() {
      if (_hasError) return;

      if (expression.isNotEmpty && operation.isEmpty && input.isEmpty && _firstOperand == null) {
        expression = '';
      }

      if (operation.isNotEmpty && input.isNotEmpty && _firstOperand != null) {
        final double? secondOperand = double.tryParse(input);
        if (secondOperand != null) {
          final String base = expression.isEmpty ? _formatNumber(_firstOperand!) : expression;
          expression = '$base$operation$input';

          double? value;
          switch (operation) {
            case '+':
              value = _firstOperand! + secondOperand;
              break;
            case '-':
              value = _firstOperand! - secondOperand;
              break;
            case '×':
              value = _firstOperand! * secondOperand;
              break;
            case '÷':
              if (secondOperand == 0) {
                result = _divideByZeroMessage;
                input = '';
                operation = '';
                expression = '';
                _firstOperand = null;
                return;
              }
              value = _firstOperand! / secondOperand;
              break;
          }

          if (value != null) {
            result = _formatNumber(value);
            _firstOperand = value;
          }
        }
      }

      if (_firstOperand == null) {
        final String first = input.isNotEmpty ? input : result;
        _firstOperand = double.tryParse(first);
        expression = first;
      }

      operation = op;
      input = '';
    });
  }

  void onClearPress() {
    setState(() {
      result = '0';
      input = '';
      operation = '';
      expression = '';
      _firstOperand = null;
    });
  }

  void onCalculatePress() {
    setState(() {
      if (_hasError) return;
      if (_firstOperand == null || operation.isEmpty || input.isEmpty) return;

      final double? secondOperand = double.tryParse(input);
      if (secondOperand == null) return;

      double? value;
      switch (operation) {
        case '+':
          value = _firstOperand! + secondOperand;
          break;
        case '-':
          value = _firstOperand! - secondOperand;
          break;
        case '×':
          value = _firstOperand! * secondOperand;
          break;
        case '÷':
          if (secondOperand == 0) {
            result = _divideByZeroMessage;
            input = '';
            operation = '';
            _firstOperand = null;
            return;
          }
          value = _firstOperand! / secondOperand;
          break;
      }

      if (value == null) return;

      final String base = expression.isEmpty ? _formatNumber(_firstOperand!) : expression;
      expression = '$base$operation$input';
      result = _formatNumber(value);

      input = '';
      operation = '';
      _firstOperand = null;
    });
  }

  void _onPlusMinusPress() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.startsWith('-') ? input.substring(1) : '-$input';
        return;
      }

      if (result != '0' && !_hasError) {
        result = result.startsWith('-') ? result.substring(1) : '-$result';
      }
    });
  }

  void _onPercentPress() {
    setState(() {
      final String source = input.isNotEmpty ? input : result;
      final double? value = double.tryParse(source);
      if (value == null) return;

      final String asString = (value / 100).toString();
      final String percentValue =
          asString.endsWith('.0') ? asString.substring(0, asString.length - 2) : asString;

      if (input.isNotEmpty) {
        input = percentValue;
      } else {
        result = percentValue;
      }
    });
  }

  Widget _button({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
    int flex = 1,
    double aspectRatio = 1,
    bool isWide = false,
  }) {
    return Expanded(
      flex: flex,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CalculatorButton(
            text: text,
            backgroundColor: backgroundColor,
            textColor: textColor,
            onPressed: onPressed,
            isWide: isWide,
          ),
        ),
      ),
    );
  }

  Widget _emptySlot() {
    return const Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: DisplayArea(value: _displayValue, expression: _expressionText),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Row(
                      children: [
                        _button(
                          text: 'AC',
                          backgroundColor: AppColors.buttonFunction,
                          textColor: AppColors.textBlack,
                          onPressed: onClearPress,
                        ),
                        _button(
                          text: '+/-',
                          backgroundColor: AppColors.buttonFunction,
                          textColor: AppColors.textBlack,
                          onPressed: _onPlusMinusPress,
                        ),
                        _button(
                          text: '%',
                          backgroundColor: AppColors.buttonFunction,
                          textColor: AppColors.textBlack,
                          onPressed: _onPercentPress,
                        ),
                        _button(
                          text: '÷',
                          backgroundColor: AppColors.buttonOperation,
                          textColor: AppColors.textWhite,
                          onPressed: () => onOperatorPress('÷'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _button(
                          text: '7',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('7'),
                        ),
                        _button(
                          text: '8',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('8'),
                        ),
                        _button(
                          text: '9',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('9'),
                        ),
                        _button(
                          text: '×',
                          backgroundColor: AppColors.buttonOperation,
                          textColor: AppColors.textWhite,
                          onPressed: () => onOperatorPress('×'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _button(
                          text: '4',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('4'),
                        ),
                        _button(
                          text: '5',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('5'),
                        ),
                        _button(
                          text: '6',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('6'),
                        ),
                        _button(
                          text: '-',
                          backgroundColor: AppColors.buttonOperation,
                          textColor: AppColors.textWhite,
                          onPressed: () => onOperatorPress('-'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _button(
                          text: '1',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('1'),
                        ),
                        _button(
                          text: '2',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('2'),
                        ),
                        _button(
                          text: '3',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('3'),
                        ),
                        _button(
                          text: '+',
                          backgroundColor: AppColors.buttonOperation,
                          textColor: AppColors.textWhite,
                          onPressed: () => onOperatorPress('+'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _emptySlot(),
                        _button(
                          text: '0',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('0'),
                        ),
                        _button(
                          text: '.',
                          backgroundColor: AppColors.buttonNumber,
                          textColor: AppColors.textWhite,
                          onPressed: () => onDigitPress('.'),
                        ),
                        _button(
                          text: '=',
                          backgroundColor: AppColors.buttonOperation,
                          textColor: AppColors.textWhite,
                          onPressed: onCalculatePress,
                        ),
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
