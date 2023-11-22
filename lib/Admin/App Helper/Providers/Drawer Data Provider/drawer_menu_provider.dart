import 'package:flutter/cupertino.dart';
import 'package:visaboard_final/Admin/App%20Helper/Api%20Repository/Drawer%20Data%20Repository/drawer_menu_repository.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/api_response_type.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/agent_qr_code_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/cancel_transaction_mdel.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/graph_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/marketing_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/template_model.dart';
import 'package:visaboard_final/Admin/App%20Helper/Models/Drawer%20Menus%20Model/transaction_model.dart';

import '../../Models/App Model/service_requested_model.dart';
import '../../Models/Drawer Menus Model/agent_counter_model.dart';
import '../../Models/Drawer Menus Model/agent_counter_sub_model.dart';
import '../../Models/Drawer Menus Model/client_model.dart';
import '../../Models/Drawer Menus Model/credentials_model.dart';
import '../../Models/Drawer Menus Model/order_visa_file_edit_model.dart';
import '../../Models/Drawer Menus Model/order_visa_file_model.dart';
import '../../Models/Drawer Menus Model/order_visafile_edit_model.dart';
import '../../Models/Drawer Menus Model/ovf_chat_model.dart';
import '../../Models/Drawer Menus Model/supplier_model.dart';
import '../../Models/Drawer Menus Model/upload_docs_model.dart';
import '../../Models/Drawer Menus Model/wallet_transaction_model.dart';

class DrawerMenuProvider with ChangeNotifier{
  final drawerRepo = DrawerMenuRepository();

  ApiResponseType<TransactionModel> transactionDataList = ApiResponseType.loading();
  setTransactionResponse(ApiResponseType<TransactionModel> transactionresponse){
    transactionDataList = transactionresponse;
    notifyListeners();
  }
  Future<void> fetchTransaction(var index,var access_token)async{
    setTransactionResponse(ApiResponseType.loading());
    drawerRepo.transaction(index,access_token).then((value){
      setTransactionResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setTransactionResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<CancelTransactionModel> cancelTDataList = ApiResponseType.loading();
  setCancelTResponse(ApiResponseType<CancelTransactionModel> cancelTResponse){
    cancelTDataList = cancelTResponse;
    notifyListeners();
  }
  Future<void> fetchCancelTransaction(var index,var access_token)async{
    setCancelTResponse(ApiResponseType.loading());
    drawerRepo.cancelTransaction(index,access_token).then((value){
      setCancelTResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setCancelTResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<WalletTransactionModel> walletTDataList = ApiResponseType.loading();
  setWalletTResponse(ApiResponseType<WalletTransactionModel> walletTResponse){
    walletTDataList = walletTResponse;
    notifyListeners();
  }
  Future<void> fetchWalletTransaction(var index,var access_token)async{
    setWalletTResponse(ApiResponseType.loading());
    drawerRepo.walletTransaction(index,access_token).then((value){
      setWalletTResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setWalletTResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<AgentCounterModel> agentCounterDataList = ApiResponseType.loading();
  setAgentCResponse(ApiResponseType<AgentCounterModel> agentCounterResponse){
    agentCounterDataList = agentCounterResponse;
    notifyListeners();
  }
  Future<void> fetchAgentCounter(var index,var access_token, var data)async{
    setAgentCResponse(ApiResponseType.loading());
    drawerRepo.agentCounter(index,access_token,data).then((value){
      setAgentCResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentCResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<AgentCounterSubModel> agentCounterSData = ApiResponseType.loading();
  setAgentCSResponse(ApiResponseType<AgentCounterSubModel> agentCounterResponse){
    agentCounterSData = agentCounterResponse;
    notifyListeners();
  }
  Future<void> fetchAgentCounterS(var index,var access_token, var data)async{
    setAgentCSResponse(ApiResponseType.loading());
    drawerRepo.agentCounterS(index,access_token,data).then((value){
      setAgentCSResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentCSResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<MarketingModel> marketingDataList = ApiResponseType.loading();
  setMarketingResponse(ApiResponseType<MarketingModel> marketingresponse){
    marketingDataList = marketingresponse;
    notifyListeners();
  }
  Future<void> fetchMarketing(var index,var access_token)async{
    setMarketingResponse(ApiResponseType.loading());
    drawerRepo.marketing(index,access_token).then((value){
      setMarketingResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setMarketingResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<SupplierModel> supplierDataList = ApiResponseType.loading();
  setSupplierResponse(ApiResponseType<SupplierModel> supplierResponse){
    supplierDataList = supplierResponse;
    notifyListeners();
  }
  Future<void> fetchSupplier(var index,var access_token)async{
    setSupplierResponse(ApiResponseType.loading());
    drawerRepo.supplier(index,access_token).then((value){
      setSupplierResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setSupplierResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<CredentialsModel> credentialDataList = ApiResponseType.loading();
  setCredentialResponse(ApiResponseType<CredentialsModel> credentialResponse){
    credentialDataList = credentialResponse;
    notifyListeners();
  }
  Future<void> fetchCredential(var index,var access_token)async{
    setCredentialResponse(ApiResponseType.loading());
    drawerRepo.credentails(index,access_token).then((value){
      setCredentialResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setCredentialResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<ClientModel> clientDataList = ApiResponseType.loading();
  setClientResponse(ApiResponseType<ClientModel> clientResponse){
    clientDataList = clientResponse;
    notifyListeners();
  }
  Future<void> fetchClient(var index,var access_token, var data)async{
    print("calling $data");
    setClientResponse(ApiResponseType.loading());
    drawerRepo.clients(index,access_token, data).then((value){
      setClientResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setClientResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<AgentQRCodeModel> agentQRCodeDataList = ApiResponseType.loading();
  setAQRCodeResponse(ApiResponseType<AgentQRCodeModel> qrResponse){
    agentQRCodeDataList = qrResponse;
    notifyListeners();
  }
  Future<void> fetchAgentQRCode(var index,var access_token, var data)async{
    setAQRCodeResponse(ApiResponseType.loading());
    drawerRepo.agentQR(index,access_token, data).then((value){
      setAQRCodeResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAQRCodeResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<OrderVisaFileModel> orderVisaFileDataList = ApiResponseType.loading();
  setOrderVisaFileResponse(ApiResponseType<OrderVisaFileModel> orderVisaFileResponse){
    orderVisaFileDataList = orderVisaFileResponse;
    notifyListeners();
  }
  Future<void> fetchOrderVisaFile(var index,var access_token, var data)async{
    setOrderVisaFileResponse(ApiResponseType.loading());
    drawerRepo.orderVisaFile(index,access_token, data).then((value){
      setOrderVisaFileResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOrderVisaFileResponse(ApiResponseType.error(error.toString()));
      print("E -> ${error.toString()}");
    });
  }

  ApiResponseType<OrderVisaFileEditM> oVFEditData = ApiResponseType.loading();
  setOVFEditResponse(ApiResponseType<OrderVisaFileEditM> oVFEditResponse){
    oVFEditData = oVFEditResponse;
    notifyListeners();
  }
  Future<void> fetchOVFEdit(var index,var access_token, var data)async{
    setOVFEditResponse(ApiResponseType.loading());
    drawerRepo.oVFEdit(index,access_token, data).then((value){
      setOVFEditResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOVFEditResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<OVFChatModel> oVFChatData = ApiResponseType.loading();
  setOVFChatResponse(ApiResponseType<OVFChatModel> oVFChatResponse){
    oVFChatData = oVFChatResponse;
    notifyListeners();
  }
  Future<void> fetchOVFChat(var index,var access_token, var uSOPId)async{
    setOVFChatResponse(ApiResponseType.loading());
    drawerRepo.oVFChat(index,access_token,uSOPId).then((value){
      setOVFChatResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOVFChatResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<GraphModel> graphData = ApiResponseType.loading();
  setGraphResponse(ApiResponseType<GraphModel> graphResponse){
    graphData = graphResponse;
    notifyListeners();
  }
  Future<void> fetchGraph(var index,var access_token)async{
    print("fetch OVF Calling");
    setGraphResponse(ApiResponseType.loading());
    drawerRepo.graphData(index,access_token).then((value){
      setGraphResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setGraphResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
    print("fetch out");
  }

  ApiResponseType<UploadDocsModel> uploadDOcsData = ApiResponseType.loading();
  setUDocsResponse(ApiResponseType<UploadDocsModel> uDocsResponse){
    uploadDOcsData = uDocsResponse;
    notifyListeners();
  }
  Future<void> fetchUploadDocs(var user_s_id,var access_token)async{
    setUDocsResponse(ApiResponseType.loading());
    drawerRepo.uploadDocs(user_s_id,access_token).then((value){
      setUDocsResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setUDocsResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<ServiceRequestedModel> serviceRData = ApiResponseType.loading();
  setServiceRResponse(ApiResponseType<ServiceRequestedModel> serviceRResponse){
    serviceRData = serviceRResponse;
    notifyListeners();
  }
  Future<void> fetchServiceR(var user_s_id,var access_token)async{
    setServiceRResponse(ApiResponseType.loading());
    drawerRepo.serviceRequested(user_s_id,access_token).then((value){
      setServiceRResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setServiceRResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }
}