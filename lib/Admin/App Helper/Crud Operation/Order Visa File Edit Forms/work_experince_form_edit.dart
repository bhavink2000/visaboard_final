import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class WorkExperienceEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateWorkExperience(
      var accessToken, var user_id, var user_sop_id,
      var occupationTypeId, var designation,
      var organizationName, var fromDate,
      var toDate, var earning, var jobPhone, var jobEmail
      ) async {
    try {
      print("update try calling");
      print("user_id->$user_id");
      print("user_sop_id->$user_sop_id");
      print("token->$accessToken");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 4,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user_experience[0][occupation_type_id]': occupationTypeId.toString(),
          'user_experience[0][designation]': designation.toString(),
          'user_experience[0][organization_name]': organizationName.toString(),
          'user_experience[0][from_date]': fromDate.toString(),
          'user_experience[0][to_date]': toDate.toString(),
          'user_experience[0][earning_amount]': earning.toString(),
          'user[job_phone_no]': jobPhone.toString(),
          'user[job_email_id]': jobEmail.toString(),
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