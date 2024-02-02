// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  //static String WebUrl = 'https://visaboard.in/vbx';        // Live Web

  //static String URL = "https://demo.visaboard.in/api/vbx/";   // Demo
  static String URL = "https://visaboard.in/api/vbx/"; // Live

  static String Login = "${URL}login";
  static String ForgotPassword = "${URL}post-forgot-password";
  static String ChangePassword = "${URL}post-change-password";

  static String getProfile = "${URL}get-me";

  static String UpdateProfile = "${URL}update-profile";

  static String getDashBoardCounter = "${URL}dashboard/counter";
  static String getNotification = "${URL}user/sop/list/unread";

  static String getAgentList = "${URL}get-agents-list";
  static String getAgentLogHistory = "${URL}get-agent-logs-history";
  static String getAgentWalletTransaction =
      "${URL}get-agent-wallet-transaction";
  static String getAgentUpdate = "${URL}post-update-agent";
  static String getAgentNewCreate = "${URL}post-agent";

  static String getAdminList = "${URL}get-admins-list";
  static String getAdminUpdate = "${URL}post-update-admin";
  static String getAdminNewCreate = "${URL}post-admin";

  static String getTemplateList = "${URL}get-templates-list";
  static String getAddNewTemplate = "${URL}post-templates";
  static String getDeleteTemplate = "${URL}post-template-delete";
  static String getFileDeleteTemplate = "${URL}post-template-file-delete";
  static String getEditTemplate = "${URL}post-update-template";

  static String getServiceType = "${URL}get-service-type";
  static String getLetterType = "${URL}get-letter-type";

  static String getModulesType = "${URL}get-modules";

  static String getCountry = "${URL}get-country";
  static String getState = "${URL}get-state-by-country";
  static String getCity = "${URL}get-city-state-and-country";

  static String getContactUs = "${URL}contact-us";

  static String getRequestedDemo = "${URL}requested-demo/list";

  static String getTransactionList = "${URL}transaction-list";
  static String getTransactionExport = "${URL}user/transaction/export";
  static String getTransactionDownlaod = "${URL}user/transaction/download";
  static String getCancelTransactionRecord = "${URL}agent/refund-to-wallet";
  static String getCancelTransaction = "${URL}user/transaction-cancel/list";

  static String getWalletTransaction = "${URL}user/wallet/list";
  static String getWalletAdd = "${URL}user/wallet/add";
  static String getWalletUpdate = "${URL}user/wallet/status/change";

  static String getGraph = "${URL}graph";

  static String getAgentCounterList = "${URL}agent/sop/list";
  static String getAgentCounterSList = "${URL}agent/sops/get-by-agent";
  static String getAgentCounterAdd = "${URL}post-agent";

  static String getMarketingList = "${URL}marketing/list";
  static String getMarketingAdd = "${URL}marketing/add";
  static String getMarketingDelete = "${URL}marketing/";
  static String getMarketingUpdate = "${URL}marketing/update";

  static String getSupplierList = "${URL}supplier/list";
  static String getSupplierAdd = "${URL}supplier/add";
  static String getSupplierDelete = "${URL}supplier/";
  static String getSupplierUpdate = "${URL}supplier/update";

  static String getCredentialList = "${URL}credentials/list";
  static String getCredentialAdd = "${URL}credentials/add";
  static String getCredentialDelete = "${URL}credentials/";
  static String getCredentialUpdate = "${URL}credentials/update";

  static String getClientList = "${URL}user/list";
  static String getClientAdd = "${URL}user/add";
  static String SendMessage = "${URL}send/message";

  static String getAgentQRCodeList = "${URL}agent-qr-codes";

  static String getOrderVisaFileList = "${URL}user/sop/list";
  static String getOVFEdit = "${URL}user/edit";
  static String getOVFUpdate = "${URL}user/update";
  static String getOVFChanges = "${URL}user/sop/status/change";
  static String getUploadDocs = "${URL}user/upload-document";
  static String getAddSubDomain = "https://demo.visaboard.in/api/vbx/user/";
  static String getOVFChat = "${URL}user/sop/";
  static String getOVFChatDelete = "${URL}user/sop/";
  static String getChatDocsDownload = "${URL}user/download-inbox-document/";
  //static String getUploadDocsDownload = "https://demo.visaboard.in/api/vbx/user/download-document";
  static String getUploadDocsDownload =
      "https://visaboard.in/api/vbx/user/download-document";

  static String getServiceRequestedAdd = "${URL}/user/apply-sop";
  static String getServiceRequested = "${URL}user/";
}

/*
Live
U :- info@visaboard.in
P :- 123@Abcd%

Demo
U :- info@visaboard.in
P :- Mission@1
*/
