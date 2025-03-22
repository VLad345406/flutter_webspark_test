import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String textButton;
  final Function()? function;

  const TaskButton({
    super.key,
    required this.textButton,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width - 30,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: TextButton(
        onPressed: function,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          textButton,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
