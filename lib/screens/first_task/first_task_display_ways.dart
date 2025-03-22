import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:flutter_webspark_test/screens/display_result_screen.dart';
import 'package:flutter_webspark_test/screens/first_task/first_task_input_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class FirstTaskDisplayWays extends StatefulWidget {
  const FirstTaskDisplayWays({super.key});

  @override
  State<FirstTaskDisplayWays> createState() => _FirstTaskDisplayWaysState();
}

class _FirstTaskDisplayWaysState extends State<FirstTaskDisplayWays> {
  void selectResult(ProviderState appState, int index) {
    //set selected result
    Provider.of<ProviderState>(context, listen: false).setData(
      grid: appState.paths[index]['gridSize'],
      xSt: appState.paths[index]['xStart'],
      ySt: appState.paths[index]['yStart'],
      x: appState.paths[index]['xEnd'],
      y: appState.paths[index]['yEnd'],
      cBS: appState.paths[index]['countBlockCells'],
    );
    Provider.of<ProviderState>(
      context,
      listen: false,
    ).setPath(pth: appState.paths[index]['path']);
    Provider.of<ProviderState>(
      context,
      listen: false,
    ).setBlockCoordinates(blockCoord: appState.paths[index]['blockCells']);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProviderState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Result list screen'),
        centerTitle: false,
        leading: IconButton(onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirstTaskInputScreen(),
            ),
                (Route<dynamic> route) => false,
          );
        }, icon: Icon(
            Platform.isIOS ?
            Icons.arrow_back_ios : Icons.arrow_back),),
      ),
      body:
          appState.paths.isEmpty
              ? Center(child: Text('No results'))
              : ListView.builder(
                itemCount: appState.paths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () => selectResult(appState, index),
                      child: Text(appState.paths[index]['result']),
                    ),
                  );
                },
              ),
    );
  }
}
