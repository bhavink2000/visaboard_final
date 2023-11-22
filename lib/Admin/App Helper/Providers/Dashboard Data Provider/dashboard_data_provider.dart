
import 'package:flutter/widgets.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/DashBoard%20Model/dashboard_counter_model.dart';
import '../../Api Repository/Dashboard Data Repository/dashboard_menu_repository.dart';
import '../../Enums/api_response_type.dart';
import '../../Models/DashBoard Model/notification_model.dart';

class DashboardDataProvider with ChangeNotifier{
  final dashboardRepo = DashboardDataRepository();

  ApiResponseType<DashBoardCounterModel> dashBoardCounterData = ApiResponseType.loading();
  setDashBoardCResponse(ApiResponseType<DashBoardCounterModel> dashBoardCounterResponse){
    dashBoardCounterData = dashBoardCounterResponse;
    notifyListeners();
  }
  Future<void> fetchDashBoardCounter(var index,var access_token)async{
    setDashBoardCResponse(ApiResponseType.loading());
    dashboardRepo.dashBoardCounter(index,access_token).then((value){
      setDashBoardCResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setDashBoardCResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<NotificationModel> notificationData = ApiResponseType.loading();
  setNotificationResponse(ApiResponseType<NotificationModel> notiResponse){
    notificationData = notiResponse;
    notifyListeners();
  }
  Future<void> fetchNotification(var index,var access_token)async{
    setNotificationResponse(ApiResponseType.loading());
    dashboardRepo.notificationData(index,access_token).then((value){
      setNotificationResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setNotificationResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }
}