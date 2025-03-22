import 'dart:convert';

import 'package:flutter_webspark_test/functions/change_result_view.dart';

import 'bfs_path_find.dart';

mixin JsonResponseParse {
  // parses the JSON and returns result
  static List<Map<String, dynamic>> processJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // check for "error" flag
    if (jsonData["error"] == true) {
      throw Exception("Error in data: ${jsonData["message"]}");
    }

    final List<Map<String, dynamic>> paths = [];

    //iterate over each "data" item (each field)
    for (var item in jsonData["data"]) {
      String id = item["id"];
      List<String> field = List<String>.from(item["field"]);

      // extract grid dimensions and block cells
      int gridSize = field.length;
      List<MapEntry<int, int>> blockedCells = _parseBlockedCells(field);

      // get start and end points
      int xStart = item["start"]["x"];
      int yStart = item["start"]["y"];
      int xEnd = item["end"]["x"];
      int yEnd = item["end"]["y"];

      // find the shortest path
      BfsPathFind pathFinder = BfsPathFind(gridSize, blockedCells);
      List<MapEntry<int, int>> path = pathFinder.findShortestPath(
        xStart,
        yStart,
        xEnd,
        yEnd,
      );

      // store the result for this grid with ID and path
      paths.add({
        "id": id,
        "path": path,
        "gridSize": gridSize,
        "blockCells": blockedCells,
        "result": changeResultView(path),
        "xStart" : xStart,
        "yStart" : yStart,
        "xEnd" : xEnd,
        "yEnd" : yEnd,
        "countBlockCells" : blockedCells.length,
      });
    }

    return paths;
  }

  // converts the grid strings into blocked cells
  static List<MapEntry<int, int>> _parseBlockedCells(List<String> field) {
    List<MapEntry<int, int>> blockedCells = [];

    for (int y = 0; y < field.length; y++) {
      for (int x = 0; x < field[y].length; x++) {
        if (field[y][x] == 'X') {
          blockedCells.add(MapEntry(x, y));
        }
      }
    }

    return blockedCells;
  }
}
