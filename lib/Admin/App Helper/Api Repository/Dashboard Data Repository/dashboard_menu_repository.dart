import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_post_get.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_type_post_get.dart';

import '../../Models/DashBoard Model/dashboard_counter_model.dart';
import '../../Models/DashBoard Model/notification_model.dart';
import '../api_urls.dart';

class DashboardDataRepository{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<DashBoardCounterModel> dashBoardCounter(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getDashBoardCounter}", access_token, '');
    try{return response = DashBoardCounterModel.fromJson(response);}catch(e){throw e;}
  }

  Future<NotificationModel> notificationData(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getNotification}?page=$index", access_token, '');
    print("respomse -> $response");
    try{return response = NotificationModel.fromJson(response);}catch(e){throw e;}
  }

}