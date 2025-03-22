//use in display result grid
bool checkIsBlockCell(
  int currentX,
  int currentY,
  List<MapEntry<int, int>> blockCoordinates,
) {
  for (var bc in blockCoordinates) {
    if (currentX == bc.key && currentY == bc.value) return true;
  }
  return false;
}
