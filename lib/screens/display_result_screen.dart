import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/functions/change_result_view.dart';
import 'package:flutter_webspark_test/functions/check_is_block_cell.dart';
import 'package:flutter_webspark_test/functions/check_is_way_cell.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:provider/provider.dart';

class DisplayResultScreen extends StatelessWidget {
  const DisplayResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProviderState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Result second task'), centerTitle: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              changeResultView(appState.path),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: appState.gridSize * 100,
                  height: appState.gridSize * 100,
                  child: GridView.count(
                    crossAxisCount: appState.gridSize,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      appState.gridSize * appState.gridSize,
                      (index) {
                        int x = index % appState.gridSize;
                        int y = index ~/ appState.gridSize;

                        //select cell background color
                        Color cellColor = Colors.white;
                        Color textColor = Colors.black;
                        //start point color
                        if (x == appState.xStart && y == appState.yStart) {
                          cellColor = Color(0xFF64FFDA);
                        }
                        //end point color
                        else if (x == appState.xEnd && y == appState.yEnd) {
                          cellColor = Color(0xFF009688);
                        }
                        //shortest path cell color
                        else if (checkIsWayCell(x, y, appState.path)) {
                          cellColor = Color(0xFF4CAF50);
                        }
                        //block cell color
                        else if (checkIsBlockCell(
                          x,
                          y,
                          appState.blockCells,
                        )) {
                          cellColor = Colors.black;
                          textColor = Colors.white;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            color: cellColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '($x,$y)',
                            style: TextStyle(color: textColor),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
