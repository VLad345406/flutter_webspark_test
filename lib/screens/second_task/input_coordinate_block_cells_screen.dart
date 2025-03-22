import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/classes/bfs_path_find.dart';
import 'package:flutter_webspark_test/elements/button.dart';
import 'package:flutter_webspark_test/elements/number_text_field.dart';
import 'package:flutter_webspark_test/elements/snack_bar.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:flutter_webspark_test/screens/display_result_screen.dart';
import 'package:provider/provider.dart';

class InputCoordinateBlockCellsScreen extends StatefulWidget {
  final int countBlockCells;
  final int gridSize;

  const InputCoordinateBlockCellsScreen({
    super.key,
    required this.countBlockCells,
    required this.gridSize,
  });

  @override
  State<InputCoordinateBlockCellsScreen> createState() =>
      _InputCoordinateBlockCellsScreenState();
}

class _InputCoordinateBlockCellsScreenState
    extends State<InputCoordinateBlockCellsScreen> {
  List<MapEntry<TextEditingController, TextEditingController>> controllers = [];
  List<MapEntry<int, int>> coordinates = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.countBlockCells,
      (index) => MapEntry(TextEditingController(), TextEditingController()),
    );
  }

  void checkCalculateData(ProviderState appState) {
    Set<String> uniqueCoordinates = {};
    coordinates = [];

    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].key.text.isEmpty ||
          controllers[i].value.text.isEmpty) {
        snackBar(context, 'Not enough data!');
        return;
      }

      int currentX = int.parse(controllers[i].key.text);
      int currentY = int.parse(controllers[i].value.text);

      if (currentX > widget.gridSize - 1 || currentY > widget.gridSize - 1) {
        snackBar(context, 'Wrong coordinate №${i + 1}!');
        return;
      }

      String coordinateKey = '$currentX,$currentY';
      if (!uniqueCoordinates.add(coordinateKey)) {
        snackBar(context, 'Duplicate coordinate at №${i + 1}!');
        return;
      }
      coordinates.add(MapEntry(currentX, currentY));
    }

    BfsPathFind bfsPathFind = BfsPathFind(widget.gridSize, coordinates);
    List<MapEntry<int, int>> path = bfsPathFind.findShortestPath(
      appState.xStart,
      appState.yStart,
      appState.xEnd,
      appState.yEnd,
    );

    //save blockCoordinates to provider
    Provider.of<ProviderState>(
      context,
      listen: false,
    ).setBlockCoordinates(blockCoord: coordinates);
    //save path to provider
    Provider.of<ProviderState>(context, listen: false).setPath(pth: path);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProviderState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Second task'), centerTitle: false),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.countBlockCells,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((index + 1).toString()),
                        SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 45,
                          child: NumberTextField(
                            controller: controllers[index].key,
                            labelText: 'X',
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 45,
                          child: NumberTextField(
                            controller: controllers[index].value,
                            labelText: 'Y',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            TaskButton(
              textButton: 'Calculate',
              function: () => checkCalculateData(appState),
            ),
          ],
        ),
      ),
    );
  }
}
