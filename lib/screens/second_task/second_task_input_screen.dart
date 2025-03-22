import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/elements/button.dart';
import 'package:flutter_webspark_test/elements/number_text_field.dart';
import 'package:flutter_webspark_test/functions/check_data.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:provider/provider.dart';

class SecondTaskInputScreen extends StatefulWidget {
  const SecondTaskInputScreen({super.key});

  @override
  State<SecondTaskInputScreen> createState() => _SecondTaskInputScreenState();
}

class _SecondTaskInputScreenState extends State<SecondTaskInputScreen> {
  final gridSizeController = TextEditingController();
  final xStartController = TextEditingController();
  final yStartController = TextEditingController();
  final xEndController = TextEditingController();
  final yEndController = TextEditingController();
  final countBlockCellsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //reset provider before task
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerState = Provider.of<ProviderState>(context, listen: false);
      providerState.setData(
        grid: 0,
        xSt: 0,
        ySt: 0,
        x: 0,
        y: 0,
        cBS: 0,
      );
      providerState.setPath(pth: []);
      providerState.setBlockCoordinates(blockCoord: []);
      providerState.setPaths(pths: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProviderState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Second task'), centerTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberTextField(
                controller: gridSizeController,
                labelText: 'Input grid size',
              ),
              NumberTextField(
                controller: xStartController,
                labelText: 'X Start coordinate:',
              ),
              NumberTextField(
                controller: yStartController,
                labelText: 'Y Start coordinate:',
              ),
              NumberTextField(
                controller: xEndController,
                labelText: 'X End coordinate:',
              ),
              NumberTextField(
                controller: yEndController,
                labelText: 'Y End coordinate:',
              ),
              NumberTextField(
                controller: countBlockCellsController,
                labelText: 'Count block cells',
              ),
              TaskButton(
                textButton: 'Next',
                function:
                    () => checkData(
                      context,
                      gridSizeController.text,
                      xStartController.text,
                      yStartController.text,
                      xEndController.text,
                      yEndController.text,
                      countBlockCellsController.text,
                      appState,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
