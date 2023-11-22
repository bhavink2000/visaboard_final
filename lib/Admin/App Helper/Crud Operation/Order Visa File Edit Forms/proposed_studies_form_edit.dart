import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class ProposedStudiesEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateProposedStudies(
      var accessToken, var user_id, var user_sop_id,
      var psINm, var psCNm, var psCampus, var psCIntend, var psOStatus, var psEDate, var psEFees,
      ) async {
    try {
      print("update try calling");
      print("user_id->$user_id");
      print("user_sop_id->$user_sop_id");
      print("token->$accessToken");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 6,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user_foreign_institute_detail[0][institute_name]': psINm.toString(),
          'user_foreign_institute_detail[0][education_course]': psCNm.toString(),
          'user_foreign_institute_detail[0][campus]': psCampus.toString(),
          'user_foreign_institute_detail[0][course_intend]': psCIntend.toString(),
          'user_foreign_institute_detail[0][hold_offer_letter_status]': psOStatus.toString(),
          'user_foreign_institute_detail[0][education_from_date]': psEDate.toString(),
          'user_foreign_institute_detail[0][total_tuition_fees]': psEFees.toString(),
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