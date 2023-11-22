import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class LanguageEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateLanguage(
      var accessToken, var user_id, var user_sop_id,
      var testStatus, var testId,
      var examDate, var certificateNo,
      var listening, var reading, var writing, var speaking, var overAll
      ) async {
    try {
      print("update try calling");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 3,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user_test_score[0][taken_english_test_status]': testStatus.toString(),
          'user_test_score[0][test_type_id]': testId.toString(),
          'user_test_score[0][exam_at]': examDate.toString(),
          'user_test_score[0][cerificate_no]': certificateNo.toString(),
          'user_test_score[0][listening_score]': listening.toString(),
          'user_test_score[0][reading_score]': reading.toString(),
          'user_test_score[0][writing_score]': writing.toString(),
          'user_test_score[0][speaking_score]': speaking.toString(),
          'user_test_score[0][over_all_score]': overAll.toString(),
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