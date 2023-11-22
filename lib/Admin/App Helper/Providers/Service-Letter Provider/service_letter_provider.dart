import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../Api Repository/api_urls.dart';

class ServiceLetterProvider extends ChangeNotifier{
  List<Map<String, dynamic>> _serviceList = [];
  List<Map<String, dynamic>> get serviceList => _serviceList;

  Future<void> fetchServiceList(String accessToken) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getServiceType),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _serviceList = List<Map<String, dynamic>>.from(data['data']);
      notifyListeners();
    } else {
      throw Exception('Failed to load service list');
    }
  }

  String? _selectedLetter;
  List<Map<String, dynamic>> _letterList = [];
  List<Map<String, dynamic>> get letterList => _letterList;
  String? get selectedLetter => _selectedLetter;

  Future<void> fetchLetterList(String accessToken, String selectedService, String selectedCountry) async {
    final response = await http.post(
      Uri.parse(ApiConstants.getLetterType),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'service_id': selectedService, 'country_id': selectedCountry}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _letterList = List<Map<String, dynamic>>.from(data['data']);
      notifyListeners();
    } else {
      throw Exception('Failed to load letter list');
    }
  }

  void setSelectedLetter(String letter) {
    _selectedLetter = letter;
    notifyListeners();
  }
}