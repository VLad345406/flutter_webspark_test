import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const NumberTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        //select keyboard type
        keyboardType: TextInputType.number,
        // input format only numbers
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}
