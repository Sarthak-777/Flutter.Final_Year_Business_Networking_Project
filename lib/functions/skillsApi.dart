import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> apicall(String searchData) async {
  String stringResponse = "";
  List<dynamic> mapResponse = [];

  List listResponse = [];
  http.Response response;
  response = await http.get(Uri.parse(
      "https://api.apilayer.com/skills?q=$searchData&apikey=HlKKFDPPX1SCJj0isfPgmScIdzk5KDiE"));
  if (response.statusCode == 200) {
    stringResponse = response.body;
    mapResponse = json.decode(stringResponse);
    // listResponse = mapResponse['data'];
    return mapResponse;
  } else {
    return ["No skill category found"];
  }
}
