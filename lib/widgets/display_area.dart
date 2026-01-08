import 'package:flutter/material.dart';

class DisplayArea extends StatelessWidget {
  final String value;
  final String? expression;

  const DisplayArea({
    super.key,
    required this.value,
    this.expression,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (expression != null && expression!.isNotEmpty)
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomRight,
              child: Text(
                expression!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 72,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
