//brings the result to the form (0,1)->(0,2)...
String changeResultView(List<MapEntry<int, int>> path) {
  String result = "";
  for (int i = 0; i < path.length; i++) {
    result += '(${path[i].key},${path[i].value})';
    if (i < path.length - 1) result += '->';
  }
  if (result.isEmpty) result = 'Impossible destination';
  return result;
}