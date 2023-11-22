import 'package:visaboard_final/Admin/App%20Helper/Api%20Repository/api_urls.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_post_get.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Service/api_service_type_post_get.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/agent_qr_code_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/credentials_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/transaction_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/wallet_transaction_model.dart';

import '../../Models/App Model/service_requested_model.dart';
import '../../Models/Drawer Menus Model/agent_counter_model.dart';
import '../../Models/Drawer Menus Model/agent_counter_sub_model.dart';
import '../../Models/Drawer Menus Model/cancel_transaction_mdel.dart';
import '../../Models/Drawer Menus Model/client_model.dart';
import '../../Models/Drawer Menus Model/graph_model.dart';
import '../../Models/Drawer Menus Model/marketing_model.dart';
import '../../Models/Drawer Menus Model/order_visa_file_model.dart';
import '../../Models/Drawer Menus Model/order_visafile_edit_model.dart';
import '../../Models/Drawer Menus Model/ovf_chat_model.dart';
import '../../Models/Drawer Menus Model/supplier_model.dart';
import '../../Models/Drawer Menus Model/template_model.dart';
import '../../Models/Drawer Menus Model/upload_docs_model.dart';

class DrawerMenuRepository{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<TemplateModel> template(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getTemplateList}?page=$index", access_token, '');
    try{return response = TemplateModel.fromJson(response);}catch(e){throw e;}
  }

  Future<TransactionModel> transaction(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getTransactionList}?page=$index", access_token, '');
    try{return response = TransactionModel.fromJson(response);}catch(e){throw e;}
  }

  Future<CancelTransactionModel> cancelTransaction(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getCancelTransaction}?page=$index", access_token, '');
    try{return response = CancelTransactionModel.fromJson(response);}catch(e){throw e;}
  }

  Future<GraphModel> graphData(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getGraph}", access_token, '');
    try{return response = GraphModel.fromJson(response);}catch(e){throw e;}
  }

  Future<WalletTransactionModel> walletTransaction(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getWalletTransaction}?page=$index", access_token, '');
    try{return response = WalletTransactionModel.fromJson(response);}catch(e){throw e;}
  }

  Future<AgentCounterModel> agentCounter(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentCounterList}?page=$index", access_token, data);
    try{return response = AgentCounterModel.fromJson(response);}catch(e){throw e;}
  }

  Future<AgentCounterSubModel> agentCounterS(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentCounterSList}?page=$index", access_token, data);
    try{return response = AgentCounterSubModel.fromJson(response);}catch(e){throw e;}
  }

  Future<MarketingModel> marketing(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getMarketingList}?page=$index", access_token, '');
    try{return response = MarketingModel.fromJson(response);}catch(e){throw e;}
  }

  Future<SupplierModel> supplier(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getSupplierList}?page=$index", access_token, '');
    try{return response = SupplierModel.fromJson(response);}catch(e){throw e;}
  }

  Future<CredentialsModel> credentails(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getCredentialList}?page=$index", access_token, '');
    try{return response = CredentialsModel.fromJson(response);}catch(e){throw e;}
  }

  Future<ClientModel> clients(var index,var access_token, var data)async{
    print("calling clinet $data");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getClientList}?page=$index", access_token, data);
    print("Response ->$response");
    try{return response = ClientModel.fromJson(response);}catch(e){throw e;}
  }

  Future<AgentQRCodeModel> agentQR(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getAgentQRCodeList}?page=$index", access_token, data);
    try{return response = AgentQRCodeModel.fromJson(response);}catch(e){throw e;}
  }

  Future<OrderVisaFileModel> orderVisaFile(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getOrderVisaFileList}?page=$index", access_token, data);
    try{return response = OrderVisaFileModel.fromJson(response);}catch(e){throw e;}
  }

  Future<OrderVisaFileEditM> oVFEdit(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse(ApiConstants.getOVFEdit, access_token, data);
    try{return response = OrderVisaFileEditM.fromJson(response);}catch(e){throw e;}
  }

  Future<OVFChatModel> oVFChat(var index,var access_token, var uSId)async{
    var url = "${ApiConstants.getOVFChat}$uSId/inbox";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = OVFChatModel.fromJson(response);}catch(e){throw e;}
  }

  Future<UploadDocsModel> uploadDocs(var uSopId,var access_token)async{
   // var url = "https://demo.visaboard.in/api/vbx/user/$uSopId/upload-document";
    var url = "https://visaboard.in/api/vbx/user/$uSopId/upload-document";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = UploadDocsModel.fromJson(response);}catch(e){throw e;}
  }
  Future<ServiceRequestedModel> serviceRequested(var id,var access_token)async{
    var url = "${ApiConstants.getServiceRequested}$id/apply-sop";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = ServiceRequestedModel.fromJson(response);}catch(e){throw e;}
  }
}