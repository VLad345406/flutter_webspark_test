import 'dart:collection';

class BfsPathFind {
  final int gridSize;

  // array storing cell availability
  final List<List<bool>> _cellAccess; // cellAccess
  // array tracking visited cells
  final List<List<bool>> _visitedCell; // visitedCell
  // array to store the path
  final List<List<MapEntry<int, int>?>> _storePath;

  // possible directions of movement
  static const List<List<int>> _directions = [
    [-1, -1], [-1, 0], [-1, 1], // up left, up, up right
    [0, -1], [0, 1], // left, right
    [1, -1], [1, 0], [1, 1], // down left, down, down right
  ];

  // the constructor accepts the grid size and the list of blocked cells
  BfsPathFind(this.gridSize, List<MapEntry<int, int>> blockedCells)
      : _cellAccess = List.generate(gridSize, (_) => List.filled(gridSize, true)),
  // By default all cells are passable
        _visitedCell = List.generate(gridSize, (_) => List.filled(gridSize, false)),
  // all cells are initially unvisited
        _storePath = List.generate(gridSize, (_) => List.filled(gridSize, null)) {
    // mark locked cells
    for (var cell in blockedCells) {
      _cellAccess[cell.key][cell.value] = false;
    }
  }

  // finding the shortest path using BFS
  List<MapEntry<int, int>> findShortestPath(
      int xStart,
      int yStart,
      int xEnd,
      int yEnd,
      ) {
    // check that the start and end points are not blocked
    if (!_cellAccess[xStart][yStart] || !_cellAccess[xEnd][yEnd]) return [];

    // queue for BFS
    Queue<List<int>> queue = Queue();
    queue.add([xStart, yStart]); // add start position
    _visitedCell[xStart][yStart] = true; // mark it as visited

    // BFS main loop
    while (queue.isNotEmpty) {
      var current = queue.removeFirst(); // first queue element
      int x = current[0], y = current[1];

      // if we have reached the end point, build the path
      if (x == xEnd && y == yEnd) {
        return _reconstructPath(xEnd, yEnd);
      }

      // check all possible directions of motion
      for (var dir in _directions) {
        int newX = x + dir[0];
        int newY = y + dir[1];

        // if the move is possible, add the cell to the queue
        if (_isValidMove(newX, newY)) {
          queue.add([newX, newY]); // add to queue for further processing
          _visitedCell[newX][newY] = true; // mark as visited
          _storePath[newX][newY] = MapEntry(x, y); // save previous step
        }
      }
    }

    // if the path is not found
    return [];
  }

  // check valid move
  bool _isValidMove(int x, int y) {
    return x >= 0 &&
        y >= 0 &&
        x < gridSize &&
        y < gridSize &&
        _cellAccess[x][y] &&
        !_visitedCell[x][y];
  }

  // reconstruct path from the end point to the start point
  List<MapEntry<int, int>> _reconstructPath(int x, int y) {
    List<MapEntry<int, int>> path = [];

    // move along the parents until we reach the starting position
    while (_storePath[x][y] != null) {
      path.add(MapEntry(x, y)); // add the current coordinate
      var parent = _storePath[x][y]!; // take the parent coordinate
      x = parent.key;
      y = parent.value;
    }

    // add start point
    path.add(MapEntry(x, y));

    // return path
    return path.reversed.toList();
  }
}
