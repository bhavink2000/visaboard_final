import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class SpouseEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateSpouse(
      var accessToken, var user_id, var user_sop_id,
      var sFNm, var sFamilyNm, var sPassportNo, var sDOB, var sMDate, var sMPlace, var sEDate, var sMRNo, var sDRNo,
      var sEducation, var sOccupation, var sDesignation, var sOAddress, var sFromDate, sToDate,
      var sAnnualI, var sChildS, var sCNm, var sCDOB, var sCBPlace,var sCPassportNo, var sCInstitutedNm, var sCStudy
      ) async {
    try {
      print("update try calling");
      print("user_id->$user_id");
      print("user_sop_id->$user_sop_id");
      print("token->$accessToken");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 5,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user[spouse_full_name]': sFNm.toString(),
          'user[spouse_family_name]': sFamilyNm.toString(),
          'user[spouse_passport_no]': sPassportNo.toString(),
          'user[spouse_dob]': sDOB.toString(),
          'user[date_of_marriage]': sMDate.toString(),
          'user[place_of_marriage]': sMPlace.toString(),
          'user[date_of_betrothal]': sEDate.toString(),
          'user[marriage_reg_no]': sMRNo.toString(),
          'user[divorce_reg_no]': sDRNo.toString(),
          'user[spouse_education]': sEducation.toString(),
          'user_spouse_experience[0][occupation]': sOccupation.toString(),
          'user_spouse_experience[0][designation]': sDesignation.toString(),
          'user_spouse_experience[0][organization_address]': sOAddress.toString(),
          'user_spouse_experience[0][from_date]': sFromDate.toString(),
          'user_spouse_experience[0][to_date]': sToDate.toString(),
          'user_spouse_experience[0][annual_income]': sAnnualI.toString(),
          'user[have_child_status]': sChildS.toString(),
          'user_child_detail[0][full_name]': sCNm.toString(),
          'user_child_detail[0][dob]': sCDOB.toString(),
          'user_child_detail[0][birth_place]': sCBPlace.toString(),
          'user_child_detail[0][passport_no]': sCPassportNo.toString(),
          'user_child_detail[0][institute_name]': sCInstitutedNm.toString(),
          'user_child_detail[0][study_standard]': sCStudy.toString(),
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