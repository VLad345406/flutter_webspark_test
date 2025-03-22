//use in display result grid
bool checkIsWayCell(int currentX, int currentY, List<MapEntry<int, int>> path){
  for (var p in path) {
    if (currentX == p.key && currentY == p.value) return true;
  }
  return false;
}