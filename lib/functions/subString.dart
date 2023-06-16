List createSubString(String data) {
  String input = data;
  List<String> result = [];

  for (int i = 1; i <= input.length; i++) {
    String substring = input.substring(0, i);
    result.add(substring.toLowerCase());
    result.add(substring.toUpperCase());
  }

  return result;
}
