import 'package:visaboard_final/Admin/App%20Helper/Api%20Repository/api_urls.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_post_get.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_type_post_get.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Side%20Menu%20Model/requested_demo_model.dart';

import '../../Models/Side Menu Model/admin_model.dart';
import '../../Models/Side Menu Model/agent_log_history_model.dart';
import '../../Models/Side Menu Model/agent_model.dart';
import '../../Models/Side Menu Model/agent_wallet_model.dart';
import '../../Models/Side Menu Model/contact_us_model.dart';

class SideMenuRepository{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<AgentsModel> agents(var index, var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentList}?page=$index", access_token, '');
    try{return response  = AgentsModel.fromJson(response);} catch(e){throw e;}
  }

  Future<AgentWalletModel> agentWallet(var index, var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentWalletTransaction}?page=$index", access_token, data);
    try{return response = AgentWalletModel.fromJson(response);} catch(e){print("e $e");throw e;}
  }

  Future<AgentLogHistoryModel> agentLogHistory(var index, var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentLogHistory}?page=$index", access_token, data);
    try{return response = AgentLogHistoryModel.fromJson(response);} catch(e){print("e $e");throw e;}
  }

  Future<AdminModel> admins(var index, var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAdminList}?page=$index", access_token, '');
    try{return response  = AdminModel.fromJson(response);} catch(e){throw e;}
  }

  Future<ContactUsModel> contactUs(var index, var access_token)async{
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiConstants.getContactUs}?page=$index", access_token);
    try{return response  = ContactUsModel.fromJson(response);} catch(e){throw e;}
  }

  Future<RequestedDemoModel> requesedDemo(var index, var access_token)async{
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse("${ApiConstants.getRequestedDemo}?page=$index", access_token);
    try{return response  = RequestedDemoModel.fromJson(response);} catch(e){throw e;}
  }
}