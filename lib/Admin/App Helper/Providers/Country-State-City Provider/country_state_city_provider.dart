import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../Api Repository/api_urls.dart';

class CountryStateCityProvider extends ChangeNotifier{
  String? _selectedCountry;
  List<Map<String, dynamic>> _countryList = [];

  String? get selectedCountry => _selectedCountry;
  List<Map<String, dynamic>> get countryList => _countryList;

  Future<void> fetchCountryList(String accessToken) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getCountry),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _countryList = List<Map<String, dynamic>>.from(data['data']);
      notifyListeners();
    } else {
      throw Exception('Failed to load country list');
    }
  }

  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void reset() {
    _selectedCountry = null;
    _countryList = [];
    notifyListeners();
  }
}