// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/api_response_type.dart';
import '../../Api Repository/Side Data Repository/side_menu_repository.dart';
import '../../Models/Side Menu Model/admin_model.dart';
import '../../Models/Side Menu Model/agent_log_history_model.dart';
import '../../Models/Side Menu Model/agent_model.dart';
import '../../Models/Side Menu Model/agent_wallet_model.dart';
import '../../Models/Side Menu Model/contact_us_model.dart';
import '../../Models/Side Menu Model/requested_demo_model.dart';

class SideMenuProvider with ChangeNotifier{
  final sideRepo = SideMenuRepository();

  ApiResponseType<AgentsModel> agentDataList = ApiResponseType.loading();
  ApiResponseType<AgentWalletModel> agentWalletDataList = ApiResponseType.loading();
  ApiResponseType<AgentLogHistoryModel> agentLogDataList = ApiResponseType.loading();

  ApiResponseType<AdminModel> adminDataList = ApiResponseType.loading();

  ApiResponseType<ContactUsModel> contactUsDataList = ApiResponseType.loading();
  ApiResponseType<RequestedDemoModel> requestedDDataList = ApiResponseType.loading();

  setAgentResponse(ApiResponseType<AgentsModel> agentResponse){
    agentDataList = agentResponse;
    notifyListeners();
  }
  setAgentWalletResponse(ApiResponseType<AgentWalletModel> agentWalletResponse){
    agentWalletDataList = agentWalletResponse;
    notifyListeners();
  }
  setAgentLogResponse(ApiResponseType<AgentLogHistoryModel> agentLogResponse){
    agentLogDataList = agentLogResponse;
    notifyListeners();
  }

  setAdminResponse(ApiResponseType<AdminModel> adminResponse){
    adminDataList = adminResponse;
    notifyListeners();
  }

  setContactUsResponse(ApiResponseType<ContactUsModel> contactUSResponse){
    contactUsDataList = contactUSResponse;
    notifyListeners();
  }

  setRequestedDemoResponse(ApiResponseType<RequestedDemoModel> requestDResponse){
    requestedDDataList = requestDResponse;
    notifyListeners();
  }

  Future<void> fetchAgent(var index, var accessToken)async{
    setAgentResponse(ApiResponseType.loading());
    sideRepo.agents(index, accessToken).then((value){
      setAgentResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentResponse(ApiResponseType.error(error.toString()));
    });
  }

  Future<void> fetchAgentWallet(var index, var accessToken, var data)async{
    setAgentWalletResponse(ApiResponseType.loading());
    sideRepo.agentWallet(index, accessToken,data).then((value){
      setAgentWalletResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentWalletResponse(ApiResponseType.error(error.toString()));
    });
  }
  Future<void> fetchAgentLog(var index, var accessToken, var data)async{
    setAgentLogResponse(ApiResponseType.loading());
    sideRepo.agentLogHistory(index, accessToken,data).then((value){
      setAgentLogResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentLogResponse(ApiResponseType.error(error.toString()));
    });
  }

  Future<void> fetchAdmin(var index, var accessToken)async{
    setAdminResponse(ApiResponseType.loading());
    sideRepo.admins(index, accessToken).then((value){
      setAdminResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAdminResponse(ApiResponseType.error(error.toString()));
    });
  }

  Future<void> fetchContactUs(var index, var accessToken)async{
    setContactUsResponse(ApiResponseType.loading());
    sideRepo.contactUs(index, accessToken).then((value){
      setContactUsResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setContactUsResponse(ApiResponseType.error(error.toString()));
    });
  }

  Future<void> fetchRequestedDemo(var index, var accessToken)async{
    setRequestedDemoResponse(ApiResponseType.loading());
    sideRepo.requesedDemo(index, accessToken).then((value){
      setRequestedDemoResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setRequestedDemoResponse(ApiResponseType.error(error.toString()));
    });
  }
}