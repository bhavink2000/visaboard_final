import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class AcademicsEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateAcademics(
      var accessToken, var user_id, var user_sop_id,
      var institutedNm, var courseNm,
      var fDate, var toDate,
      var grade, var language, var educationId, var educationName
      ) async {
    try {
      print("update try calling");
      print("user_id->$user_id");
      print("user_sop_id->$user_sop_id");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 2,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user_education[0][education_type_id]': '4',
          'user_education[0][other_education_type_name]': educationName.toString(),
          'user_education[0][institute_name]': institutedNm.toString(),
          'user_education[0][course_name]': courseNm.toString(),
          'user_education[0][from_date]': fDate.toString(),
          'user_education[0][to_date]': toDate.toString(),
          'user_education[0][grade]': grade.toString(),
          'user_education[0][language]': language.toString(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      ).then((value){
        print("value->$value");
      }).onError((error, stackTrace){
        print("error->$error");
      });
      return response;
    } catch (error) {
      throw error;
    }
  }
}