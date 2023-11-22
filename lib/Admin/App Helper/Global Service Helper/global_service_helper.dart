// ignore_for_file: missing_return

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Api Repository/api_urls.dart';


class GlobalService{
  List agentList = [];
  Future<void> getAgentList(var accessToken) async {
    final response = await http.post(
      Uri.parse(ApiConstants.getAgentList),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    final data = json.decode(response.body);
    agentList = data['data']['data'];
    print("Agent List -> $agentList");
  }
}