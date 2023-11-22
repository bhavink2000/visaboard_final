import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';


class PersonalInfoEdit{

  static final Dio dio = Dio();

  static Future<Response<dynamic>> updatePersonalInfo(
      var accessToken, var user_id, var user_sop_id, var u_fnm, var u_mnm, var u_lnm,
      var other_nm, var otherName, var change_nm, var changeFile, var birthdate, var passport_no,
      var passwort_ex_date, var fLanguage, var citizen_c_id, var gender, var martial_s, var medical_s, var medical_note,
      var email, var mobile, var parent_e, var parent_m, var pa_address, var pa_c_id, var pa_s_id, var pa_city_id, var pa_postcode,
      var cBox, var ca_address, var ca_c_id, var ca_s_id, var ca_city_id, var ca_postcode
      ) async {
    try {
      print("update try calling");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 1,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user[first_name]': u_fnm.toString(),
          'user[middle_name]': u_mnm.toString(),
          'user[last_name]': u_lnm.toString(),
          'user[other_name_status]': other_nm.toString(),
          'user[other_name]': otherName.toString(),
          'user[changed_name_status]': change_nm.toString(),
          'user[changed_name]': changeFile.toString(),       //---------------------File
          'user[dob]': birthdate.toString(),
          'user[passport_no]': passport_no.toString(),
          'user[passport_exp_date]': passwort_ex_date.toString(),
          'user[first_language]': fLanguage.toString(),
          'user[citizen_country_id]': citizen_c_id.toString(),
          'user[gender]': gender.toString(),
          'user[marital_status]': martial_s.toString(),
          'user[medical_condition_status]': medical_s.toString(),
          'user[medical_condition_note]': medical_note.toString(),
          'user[email_id]': email.toString(),
          'user[mobile_no]': mobile.toString(),
          'user[parent_email_id]': parent_e.toString(),
          'user[phone_no]': parent_m.toString(),
          'user[current_address]': pa_address.toString(),
          'user[current_country_id]': pa_c_id.toString(),
          'user[current_state_id]': pa_s_id.toString(),
          'user[current_city_id]': pa_city_id.toString(),
          'user[current_zip_code]': pa_postcode.toString(),
          'user[same_as_current_address]': cBox.toString(),
          'user[communication_address]': ca_address.toString(),
          'user[communication_country_id]': ca_c_id.toString(),
          'user[communication_state_id]':ca_s_id.toString(),
          'user[communication_city_id]': ca_city_id.toString(),
          'user[communication_zip_code]': ca_postcode.toString(),
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