import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/elements/button.dart';
import 'package:flutter_webspark_test/screens/first_task/first_task_input_screen.dart';
import 'package:flutter_webspark_test/screens/second_task/second_task_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home screen'), centerTitle: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TaskButton(
            textButton: 'First task',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstTaskInputScreen()),
              );
            },
          ),
          TaskButton(
            textButton: 'Second task',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondTaskInputScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
