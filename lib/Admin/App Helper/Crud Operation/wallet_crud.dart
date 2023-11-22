import 'package:dio/dio.dart';

import '../Api Repository/api_urls.dart';

class WalletCrud{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> addWallet(String agentId, String amount, var accessToken) async {
    try {
      final response = await dio.post(
        ApiConstants.getWalletAdd,
        data: {
          'agent_id': agentId,
          'amount': amount,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );
      return response;
    } catch (error) {
      throw error;
    }
  }

  static Future<Response<dynamic>> updateWallet(String id, var status, var accessToken) async {
    try {
      final response = await dio.post(
        ApiConstants.getWalletUpdate,
        data: {
          'id' : id,
          'withdraw_status' : status,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );
      return response;
    } catch (error) {
      throw error;
    }
  }
}