import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/classes/bfs_path_find.dart';
import 'package:flutter_webspark_test/elements/snack_bar.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:flutter_webspark_test/screens/display_result_screen.dart';
import 'package:flutter_webspark_test/screens/second_task/input_coordinate_block_cells_screen.dart';
import 'package:provider/provider.dart';

void checkData(
  BuildContext context,
  String gridSizeText,
  String xStartText,
  String yStartText,
  String xEndText,
  String yEndText,
  String countBlockCellsText,
  ProviderState appState,
) {
  if (gridSizeText.isEmpty ||
      xStartText.isEmpty ||
      yStartText.isEmpty ||
      xEndText.isEmpty ||
      yEndText.isEmpty ||
      countBlockCellsText.isEmpty) {
    snackBar(context, 'Not enough data!');
  } else {
    int gridSize = int.parse(gridSizeText);
    int xStart = int.parse(xStartText);
    int yStart = int.parse(yStartText);
    int xEnd = int.parse(xEndText);
    int yEnd = int.parse(yEndText);
    int countBlockCells = int.parse(countBlockCellsText);
    if (gridSize <= 1 || gridSize >= 100) {
      snackBar(
        context,
        'Wrong grid size!\n'
        'Grid must be > 1 & < 100',
      );
    } else if (xStart > gridSize - 1) {
      snackBar(context, 'Wrong X Start coordinate');
    } else if (yStart > gridSize - 1) {
      snackBar(context, 'Wrong Y Start coordinate');
    } else if (xEnd > gridSize - 1) {
      snackBar(context, 'Wrong X End coordinate');
    } else if (yEnd > gridSize - 1) {
      snackBar(context, 'Wrong Y End coordinate');
    } else if (countBlockCells > gridSize * gridSize) {
      snackBar(
        context,
        'Count block cells can`t be more than the number of cells!',
      );
    } else if (xStart == xEnd && yStart == yEnd) {
      snackBar(context, 'The starting and ending points are equal!');
    } else {
      Provider.of<ProviderState>(context, listen: false).setData(
        grid: gridSize,
        xSt: xStart,
        ySt: yStart,
        x: xEnd,
        y: yEnd,
        cBS: countBlockCells,
      );

      if (countBlockCells == 0) {
        BfsPathFind bfsPathFind = BfsPathFind(appState.gridSize, []);
        List<MapEntry<int, int>> path = bfsPathFind.findShortestPath(
          appState.xStart,
          appState.yStart,
          appState.xEnd,
          appState.yEnd,
        );
        Provider.of<ProviderState>(context, listen: false).setPath(pth: path);
        //delete previous result
        Provider.of<ProviderState>(
          context,
          listen: false,
        ).setBlockCoordinates(blockCoord: []);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayResultScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => InputCoordinateBlockCellsScreen(
                  countBlockCells: countBlockCells,
                  gridSize: gridSize,
                ),
          ),
        );
      }
    }
  }
}
