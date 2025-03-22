import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/elements/button.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:flutter_webspark_test/screens/first_task/loading_screen.dart';
import 'package:flutter_webspark_test/screens/home_screen.dart';
import 'package:provider/provider.dart';

class FirstTaskInputScreen extends StatefulWidget {
  const FirstTaskInputScreen({super.key});

  @override
  State<FirstTaskInputScreen> createState() => _FirstTaskInputScreenState();
}

class _FirstTaskInputScreenState extends State<FirstTaskInputScreen> {
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //reset provider before task
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerState = Provider.of<ProviderState>(context, listen: false);
      providerState.setData(grid: 0, xSt: 0, ySt: 0, x: 0, y: 0, cBS: 0);
      providerState.setPath(pth: []);
      providerState.setBlockCoordinates(blockCoord: []);
      providerState.setPaths(pths: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final appState = Provider.of<ProviderState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('First task'), centerTitle: false,
        leading: IconButton(onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
                (Route<dynamic> route) => false,
          );
        }, icon: Icon(
            Platform.isIOS ?
            Icons.arrow_back_ios : Icons.arrow_back),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25, top: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Set valid API base URL in order to continue',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.compare_arrows),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(hintText: 'Input URL'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          TaskButton(
            textButton: 'Start counting process',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => LoadingScreen(url: inputController.text),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
