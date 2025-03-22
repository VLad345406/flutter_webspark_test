import 'package:flutter/material.dart';

class ProviderState extends ChangeNotifier {
  int gridSize = 0;
  int xStart = 0;
  int yStart = 0;
  int xEnd = 0;
  int yEnd = 0;
  int countBlockCells = 0;
  List<MapEntry<int, int>> path = [];
  List<MapEntry<int, int>> blockCells = [];

  List<Map<String, dynamic>> paths = [];

  void setData({
    required int grid,
    required int xSt,
    required int ySt,
    required int x,
    required int y,
    required int cBS,
  }) {
    gridSize = grid;
    xStart = xSt;
    yStart = ySt;
    xEnd = x;
    yEnd = y;
    countBlockCells = cBS;
    notifyListeners();
  }

  void setPath({required List<MapEntry<int, int>> pth}) {
    path = pth;
  }
  void setPaths({required List<Map<String, dynamic>> pths}) {
    paths = pths;
  }
  void setBlockCoordinates({required List<MapEntry<int, int>> blockCoord}) {
    blockCells = blockCoord;
  }
}
