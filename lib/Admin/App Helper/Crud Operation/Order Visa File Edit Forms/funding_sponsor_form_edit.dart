import 'package:dio/dio.dart';
import '../../Api Repository/api_urls.dart';

class FundingSponsorEdit{
  static final Dio dio = Dio();

  static Future<Response<dynamic>> updateFundingSponsor(
      var accessToken, var user_id, var user_sop_id,
      var fsSRelation, var fsSNm, var fsSOccupation, var fsSOrganization,var fsSAnnualI, var fsSBalanceA,
      var fsSLoanStatus, var fsBNm, var fsLoanAmount, var fsGuarantor, var fsSFundsT, var fsAmount, var fsSAS,
      ) async {
    try {
      print("update try calling");
      print("user_id->$user_id");
      print("user_sop_id->$user_sop_id");
      print("token->$accessToken");
      final response = await dio.post(
        ApiConstants.getOVFUpdate,
        data: {
          'step': 7,
          'user_id': user_id,
          'user_sop_id': user_sop_id,
          'user[sponsor_relation]': fsSRelation.toString(),
          'user[sponsor_full_name]': fsSNm.toString(),
          'user[sponsor_occupation]': fsSOccupation.toString(),
          'user[sponsor_organization_name]': fsSOrganization.toString(),
          'user[sponsor_annual_income]': fsSAnnualI.toString(),
          'user[sponsor_available_bal]': fsSBalanceA.toString(),
          'user[study_loan_status]': fsSLoanStatus.toString(),
          'user[loan_bank_name]': fsBNm.toString(),
          'user[loan_amount]': fsLoanAmount.toString(),
          'user[loan_guarantor]': fsGuarantor.toString(),
          'user_sof[0][sponsor_source_of_found]': fsSFundsT.toString(),
          'user_sof[0][sponsor_source_of_found_amount]': fsAmount.toString(),
          'user[sponsor_affidavit_status]': fsSAS.toString(),
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