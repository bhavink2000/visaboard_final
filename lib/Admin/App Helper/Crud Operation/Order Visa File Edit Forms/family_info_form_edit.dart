import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class FamilyInfoEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateFamilyInfo(
      var accessToken, var user_id, var user_sop_id,
      var fiNm, var fiRelation,var fiDOB, var fiDOBPlace,
      var fiCountryId, var fiOccupation,
      var fiMartialS, var fiRemark,
      ) async {
    try {
      print("update try calling");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 9,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user_family_detail[0][full_name]': fiNm.toString(),
          'user_family_detail[0][relation_id]': fiRelation.toString(),
          'user_family_detail[0][dob]': fiDOB.toString(),
          'user_family_detail[0][birth_place]': fiDOBPlace.toString(),
          'user_family_detail[0][country_id]': fiCountryId.toString(),
          'user_family_detail[0][occupation]': fiOccupation.toString(),
          'user_family_detail[0][marital_status]': fiMartialS.toString(),
          'user_family_detail[0][remark]': fiRemark.toString(),
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