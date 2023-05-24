List createSubString(String data) {
  String input = data;
  List<String> result = [];

  for (int i = 1; i <= input.length; i++) {
    result.add(input.substring(0, i));
  }

  return result;
}
