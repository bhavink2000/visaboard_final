import 'dart:convert';

OrderVisaFileEditModel orderVisaFileEditModelFromJson(String str) => OrderVisaFileEditModel.fromJson(json.decode(str));

String orderVisaFileEditModelToJson(OrderVisaFileEditModel data) => json.encode(data.toJson());

class OrderVisaFileEditModel {
  OrderVisaFileEditModel({
    required this.status,
    required this.data,
    required this.tabs,
  });

  int status;
  OVFEditData data;
  List<Tab> tabs;

  factory OrderVisaFileEditModel.fromJson(Map<String, dynamic> json) => OrderVisaFileEditModel(
    status: json["status"],
    data: OVFEditData.fromJson(json["data"]),
    tabs: List<Tab>.from(json["tabs"].map((x) => Tab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "tabs": List<dynamic>.from(tabs.map((x) => x.toJson())),
  };
}

class OVFEditData {
  OVFEditData({
    required this.id,
    required this.userSopId,
    required this.user,
    required this.userForeignInstituteDetails,
    required this.userChildDetails,
    required this.userSofs,
    required this.userRefusedVisas,
    required this.userTravelledHistories,
    required this.userFamilyDetails,
    required this.countries,
    required this.educationTypes,
    required this.testTypes,
    required this.currentStates,
    required this.currentCities,
    required this.communicationStates,
    required this.communicationCities,
    required this.userExperiences,
    required this.userEducations,
    required this.userTestScores,
    required this.userSpouseExperiences,
    required this.userSpousePreviousEducations,
    required this.userSops,
    required this.encUserId,
    required this.encUserSopId,
  });

  int id;
  int userSopId;
  User user;
  List<dynamic> userForeignInstituteDetails;
  List<dynamic> userChildDetails;
  List<dynamic> userSofs;
  List<dynamic> userRefusedVisas;
  List<dynamic> userTravelledHistories;
  List<dynamic> userFamilyDetails;
  List<Country> countries;
  List<Type> educationTypes;
  List<Type> testTypes;
  List<dynamic> currentStates;
  List<dynamic> currentCities;
  List<dynamic> communicationStates;
  List<dynamic> communicationCities;
  List<dynamic> userExperiences;
  List<dynamic> userEducations;
  List<dynamic> userTestScores;
  List<dynamic> userSpouseExperiences;
  List<dynamic> userSpousePreviousEducations;
  UserSops userSops;
  String encUserId;
  String encUserSopId;

  factory OVFEditData.fromJson(Map<String, dynamic> json) => OVFEditData(
    id: json["id"],
    userSopId: json["user_sop_id"],
    user: User.fromJson(json["user"]),
    userForeignInstituteDetails: List<dynamic>.from(json["user_foreign_institute_details"].map((x) => x)),
    userChildDetails: List<dynamic>.from(json["user_child_details"].map((x) => x)),
    userSofs: List<dynamic>.from(json["user_sofs"].map((x) => x)),
    userRefusedVisas: List<dynamic>.from(json["user_refused_visas"].map((x) => x)),
    userTravelledHistories: List<dynamic>.from(json["user_travelled_histories"].map((x) => x)),
    userFamilyDetails: List<dynamic>.from(json["user_family_details"].map((x) => x)),
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    educationTypes: List<Type>.from(json["education_types"].map((x) => Type.fromJson(x))),
    testTypes: List<Type>.from(json["test_types"].map((x) => Type.fromJson(x))),
    currentStates: List<dynamic>.from(json["current_states"].map((x) => x)),
    currentCities: List<dynamic>.from(json["current_cities"].map((x) => x)),
    communicationStates: List<dynamic>.from(json["communication_states"].map((x) => x)),
    communicationCities: List<dynamic>.from(json["communication_cities"].map((x) => x)),
    userExperiences: List<dynamic>.from(json["user_experiences"].map((x) => x)),
    userEducations: List<dynamic>.from(json["user_educations"].map((x) => x)),
    userTestScores: List<dynamic>.from(json["user_test_scores"].map((x) => x)),
    userSpouseExperiences: List<dynamic>.from(json["user_spouse_experiences"].map((x) => x)),
    userSpousePreviousEducations: List<dynamic>.from(json["user_spouse_previous_educations"].map((x) => x)),
    userSops: UserSops.fromJson(json["user_sops"]),
    encUserId: json["enc_user_id"],
    encUserSopId: json["enc_user_sop_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_sop_id": userSopId,
    "user": user.toJson(),
    "user_foreign_institute_details": List<dynamic>.from(userForeignInstituteDetails.map((x) => x)),
    "user_child_details": List<dynamic>.from(userChildDetails.map((x) => x)),
    "user_sofs": List<dynamic>.from(userSofs.map((x) => x)),
    "user_refused_visas": List<dynamic>.from(userRefusedVisas.map((x) => x)),
    "user_travelled_histories": List<dynamic>.from(userTravelledHistories.map((x) => x)),
    "user_family_details": List<dynamic>.from(userFamilyDetails.map((x) => x)),
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "education_types": List<dynamic>.from(educationTypes.map((x) => x.toJson())),
    "test_types": List<dynamic>.from(testTypes.map((x) => x.toJson())),
    "current_states": List<dynamic>.from(currentStates.map((x) => x)),
    "current_cities": List<dynamic>.from(currentCities.map((x) => x)),
    "communication_states": List<dynamic>.from(communicationStates.map((x) => x)),
    "communication_cities": List<dynamic>.from(communicationCities.map((x) => x)),
    "user_experiences": List<dynamic>.from(userExperiences.map((x) => x)),
    "user_educations": List<dynamic>.from(userEducations.map((x) => x)),
    "user_test_scores": List<dynamic>.from(userTestScores.map((x) => x)),
    "user_spouse_experiences": List<dynamic>.from(userSpouseExperiences.map((x) => x)),
    "user_spouse_previous_educations": List<dynamic>.from(userSpousePreviousEducations.map((x) => x)),
    "user_sops": userSops.toJson(),
    "enc_user_id": encUserId,
    "enc_user_sop_id": encUserSopId,
  };
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.dialCode,
  });

  int id;
  String name;
  int dialCode;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    dialCode: json["dial_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dial_code": dialCode,
  };
}

class Type {
  Type({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class User {
  User({
    required this.id,
    required this.agentId,
    required this.adminId,
    required this.firstName,
    required this.lastName,
    required this.otherNameStatus,
    this.otherName,
    required this.changedNameStatus,
    this.changedName,
    this.dob,
    this.passportNo,
    this.passportExpDate,
    this.firstLanguage,
    required this.citizenCountryId,
    required this.gender,
    required this.emailId,
    required this.mobileNo,
    this.phoneNo,
    this.parentEmailId,
    this.currentAddress,
    required this.currentCountryId,
    required this.currentStateId,
    required this.currentCityId,
    this.currentZipCode,
    required this.sameAsCurrentAddress,
    this.communicationAddress,
    required this.communicationCountryId,
    required this.communicationStateId,
    required this.communicationCityId,
    this.communicationZipCode,
    this.sponsorFullName,
    this.sponsorRelation,
    required this.sponsorAnnualIncome,
    this.sponsorAvailableBal,
    this.sponsorOccupation,
    this.sponsorOrganizationName,
    required this.sponsorAffidavitStatus,
    required this.maritalStatus,
    this.spouseFullName,
    this.dateOfMarriage,
    this.placeOfMarriage,
    this.dateOfBetrothal,
    this.spouseFamilyName,
    this.spouseDob,
    this.spouseEducation,
    this.marriageRegNo,
    this.divorceRegNo,
    required this.haveChildStatus,
    this.jewelleryValuation,
    this.homeValuation,
    this.cAReport,
    this.jobPhoneNo,
    this.jobEmailId,
    required this.agentReadStatus,
    required this.adminReadStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.studyLoanStatus,
    this.loanBankName,
    required this.loanAmount,
    this.loanGuarantor,
    required this.countryVisaAppliedStatus,
    required this.visaAppliedCountryId,
    required this.visaAppliedApplication,
    required this.deniedCountryEntryStatus,
    this.deniedCountryEntryNote,
    required this.appliedVisaCancelledStatus,
    this.appliedVisaCancelledNote,
    required this.policeVerifyCertificateStatus,
    required this.pendingCriminalStatus,
    required this.convictedCriminalStatus,
    this.criminalRecordText,
    required this.medicalConditionStatus,
    this.medicalConditionNote,
    required this.travelledHistoryStatus,
    required this.countryVisaRefusedStatus,
    this.spouseLivingAddress,
    this.spouseVisaGrantNo,
    this.spouseVisaValidityDate,
    this.spouseInstitute,
    this.spouseCourse,
    required this.spouseChangedCourseStatus,
    this.spouseDepartForeignStudy,
    required this.spouseWorkStatus,
    this.spouseWorkPlace,
    this.spouseWorkPlaceAddress,
    this.spouseDesignation,
    this.spouseFromDate,
    this.spouseToDate,
    required this.spouseIncome,
    this.spousePassportNo,
    required this.spouseOccupation,
    this.spouseOrganizationAddress,
    required this.haveOtherDependentsStatus,
    this.spouseStartDate,
    this.spouseEndDate,
    required this.spouseAnnualIncome,
    this.stayDuration,
    this.inviterRelated,
    required this.inviterResidentStatus,
    this.inviterFamilySizeUnit,
    this.inviterOccupation,
    required this.invitationLetterStatus,
    required this.immigrationHistoryFlag,
    this.propertyValuation,
    this.propertyAddress,
    this.maxGrossAmount,
    this.apostilleCountryId,
    this.translationCountryId,
    required this.telegraphicTransferAmount,
    required this.telegraphicTransferCurrencyId,
    required this.middleName,
    this.soprfDesignation,
    this.soprfNoCandidate,
    this.soprfSalary,
    this.soprfPlaceInterview,
    this.soprfInterviewTime,
    this.soprfDutiesResponsibilities,
    this.soprfNote,
  });

  int id;
  int agentId;
  int adminId;
  String firstName;
  String lastName;
  int otherNameStatus;
  dynamic otherName;
  int changedNameStatus;
  dynamic changedName;
  dynamic dob;
  dynamic passportNo;
  dynamic passportExpDate;
  dynamic firstLanguage;
  int citizenCountryId;
  int gender;
  String emailId;
  String mobileNo;
  dynamic phoneNo;
  dynamic parentEmailId;
  dynamic currentAddress;
  int currentCountryId;
  int currentStateId;
  int currentCityId;
  dynamic currentZipCode;
  int sameAsCurrentAddress;
  dynamic communicationAddress;
  int communicationCountryId;
  int communicationStateId;
  int communicationCityId;
  dynamic communicationZipCode;
  dynamic sponsorFullName;
  dynamic sponsorRelation;
  int sponsorAnnualIncome;
  dynamic sponsorAvailableBal;
  dynamic sponsorOccupation;
  dynamic sponsorOrganizationName;
  int sponsorAffidavitStatus;
  int maritalStatus;
  dynamic spouseFullName;
  dynamic dateOfMarriage;
  dynamic placeOfMarriage;
  dynamic dateOfBetrothal;
  dynamic spouseFamilyName;
  dynamic spouseDob;
  dynamic spouseEducation;
  dynamic marriageRegNo;
  dynamic divorceRegNo;
  int haveChildStatus;
  dynamic jewelleryValuation;
  dynamic homeValuation;
  dynamic cAReport;
  dynamic jobPhoneNo;
  dynamic jobEmailId;
  int agentReadStatus;
  int adminReadStatus;
  int status;
  String createdAt;
  String updatedAt;
  int studyLoanStatus;
  dynamic loanBankName;
  String loanAmount;
  dynamic loanGuarantor;
  int countryVisaAppliedStatus;
  int visaAppliedCountryId;
  int visaAppliedApplication;
  int deniedCountryEntryStatus;
  dynamic deniedCountryEntryNote;
  int appliedVisaCancelledStatus;
  dynamic appliedVisaCancelledNote;
  int policeVerifyCertificateStatus;
  int pendingCriminalStatus;
  int convictedCriminalStatus;
  dynamic criminalRecordText;
  int medicalConditionStatus;
  dynamic medicalConditionNote;
  int travelledHistoryStatus;
  int countryVisaRefusedStatus;
  dynamic spouseLivingAddress;
  dynamic spouseVisaGrantNo;
  dynamic spouseVisaValidityDate;
  dynamic spouseInstitute;
  dynamic spouseCourse;
  int spouseChangedCourseStatus;
  dynamic spouseDepartForeignStudy;
  int spouseWorkStatus;
  dynamic spouseWorkPlace;
  dynamic spouseWorkPlaceAddress;
  dynamic spouseDesignation;
  dynamic spouseFromDate;
  dynamic spouseToDate;
  String spouseIncome;
  dynamic spousePassportNo;
  int spouseOccupation;
  dynamic spouseOrganizationAddress;
  int haveOtherDependentsStatus;
  dynamic spouseStartDate;
  dynamic spouseEndDate;
  String spouseAnnualIncome;
  dynamic stayDuration;
  dynamic inviterRelated;
  int inviterResidentStatus;
  dynamic inviterFamilySizeUnit;
  dynamic inviterOccupation;
  int invitationLetterStatus;
  int immigrationHistoryFlag;
  dynamic propertyValuation;
  dynamic propertyAddress;
  dynamic maxGrossAmount;
  dynamic apostilleCountryId;
  dynamic translationCountryId;
  String telegraphicTransferAmount;
  int telegraphicTransferCurrencyId;
  String middleName;
  dynamic soprfDesignation;
  dynamic soprfNoCandidate;
  dynamic soprfSalary;
  dynamic soprfPlaceInterview;
  dynamic soprfInterviewTime;
  dynamic soprfDutiesResponsibilities;
  dynamic soprfNote;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    agentId: json["agent_id"],
    adminId: json["admin_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    otherNameStatus: json["other_name_status"],
    otherName: json["other_name"],
    changedNameStatus: json["changed_name_status"],
    changedName: json["changed_name"],
    dob: json["dob"],
    passportNo: json["passport_no"],
    passportExpDate: json["passport_exp_date"],
    firstLanguage: json["first_language"],
    citizenCountryId: json["citizen_country_id"],
    gender: json["gender"],
    emailId: json["email_id"],
    mobileNo: json["mobile_no"],
    phoneNo: json["phone_no"],
    parentEmailId: json["parent_email_id"],
    currentAddress: json["current_address"],
    currentCountryId: json["current_country_id"],
    currentStateId: json["current_state_id"],
    currentCityId: json["current_city_id"],
    currentZipCode: json["current_zip_code"],
    sameAsCurrentAddress: json["same_as_current_address"],
    communicationAddress: json["communication_address"],
    communicationCountryId: json["communication_country_id"],
    communicationStateId: json["communication_state_id"],
    communicationCityId: json["communication_city_id"],
    communicationZipCode: json["communication_zip_code"],
    sponsorFullName: json["sponsor_full_name"],
    sponsorRelation: json["sponsor_relation"],
    sponsorAnnualIncome: json["sponsor_annual_income"],
    sponsorAvailableBal: json["sponsor_available_bal"],
    sponsorOccupation: json["sponsor_occupation"],
    sponsorOrganizationName: json["sponsor_organization_name"],
    sponsorAffidavitStatus: json["sponsor_affidavit_status"],
    maritalStatus: json["marital_status"],
    spouseFullName: json["spouse_full_name"],
    dateOfMarriage: json["date_of_marriage"],
    placeOfMarriage: json["place_of_marriage"],
    dateOfBetrothal: json["date_of_betrothal"],
    spouseFamilyName: json["spouse_family_name"],
    spouseDob: json["spouse_dob"],
    spouseEducation: json["spouse_education"],
    marriageRegNo: json["marriage_reg_no"],
    divorceRegNo: json["divorce_reg_no"],
    haveChildStatus: json["have_child_status"],
    jewelleryValuation: json["jewellery_valuation"],
    homeValuation: json["home_valuation"],
    cAReport: json["c_a_report"],
    jobPhoneNo: json["job_phone_no"],
    jobEmailId: json["job_email_id"],
    agentReadStatus: json["agent_read_status"],
    adminReadStatus: json["admin_read_status"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    studyLoanStatus: json["study_loan_status"],
    loanBankName: json["loan_bank_name"],
    loanAmount: json["loan_amount"],
    loanGuarantor: json["loan_guarantor"],
    countryVisaAppliedStatus: json["country_visa_applied_status"],
    visaAppliedCountryId: json["visa_applied_country_id"],
    visaAppliedApplication: json["visa_applied_application"],
    deniedCountryEntryStatus: json["denied_country_entry_status"],
    deniedCountryEntryNote: json["denied_country_entry_note"],
    appliedVisaCancelledStatus: json["applied_visa_cancelled_status"],
    appliedVisaCancelledNote: json["applied_visa_cancelled_note"],
    policeVerifyCertificateStatus: json["police_verify_certificate_status"],
    pendingCriminalStatus: json["pending_criminal_status"],
    convictedCriminalStatus: json["convicted_criminal_status"],
    criminalRecordText: json["criminal_record_text"],
    medicalConditionStatus: json["medical_condition_status"],
    medicalConditionNote: json["medical_condition_note"],
    travelledHistoryStatus: json["travelled_history_status"],
    countryVisaRefusedStatus: json["country_visa_refused_status"],
    spouseLivingAddress: json["spouse_living_address"],
    spouseVisaGrantNo: json["spouse_visa_grant_no"],
    spouseVisaValidityDate: json["spouse_visa_validity_date"],
    spouseInstitute: json["spouse_institute"],
    spouseCourse: json["spouse_course"],
    spouseChangedCourseStatus: json["spouse_changed_course_status"],
    spouseDepartForeignStudy: json["spouse_depart_foreign_study"],
    spouseWorkStatus: json["spouse_work_status"],
    spouseWorkPlace: json["spouse_work_place"],
    spouseWorkPlaceAddress: json["spouse_work_place_address"],
    spouseDesignation: json["spouse_designation"],
    spouseFromDate: json["spouse_from_date"],
    spouseToDate: json["spouse_to_date"],
    spouseIncome: json["spouse_income"],
    spousePassportNo: json["spouse_passport_no"],
    spouseOccupation: json["spouse_occupation"],
    spouseOrganizationAddress: json["spouse_organization_address"],
    haveOtherDependentsStatus: json["have_other_dependents_status"],
    spouseStartDate: json["spouse_start_date"],
    spouseEndDate: json["spouse_end_date"],
    spouseAnnualIncome: json["spouse_annual_income"],
    stayDuration: json["stay_duration"],
    inviterRelated: json["inviter_related"],
    inviterResidentStatus: json["inviter_resident_status"],
    inviterFamilySizeUnit: json["inviter_family_size_unit"],
    inviterOccupation: json["inviter_occupation"],
    invitationLetterStatus: json["invitation_letter_status"],
    immigrationHistoryFlag: json["immigration_history_flag"],
    propertyValuation: json["property_valuation"],
    propertyAddress: json["property_address"],
    maxGrossAmount: json["max_gross_amount"],
    apostilleCountryId: json["apostille_country_id"],
    translationCountryId: json["translation_country_id"],
    telegraphicTransferAmount: json["telegraphic_transfer_amount"],
    telegraphicTransferCurrencyId: json["telegraphic_transfer_currency_id"],
    middleName: json["middle_name"],
    soprfDesignation: json["soprf_designation"],
    soprfNoCandidate: json["soprf_no_candidate"],
    soprfSalary: json["soprf_salary"],
    soprfPlaceInterview: json["soprf_place_interview"],
    soprfInterviewTime: json["soprf_interview_time"],
    soprfDutiesResponsibilities: json["soprf_duties_responsibilities"],
    soprfNote: json["soprf_note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "agent_id": agentId,
    "admin_id": adminId,
    "first_name": firstName,
    "last_name": lastName,
    "other_name_status": otherNameStatus,
    "other_name": otherName,
    "changed_name_status": changedNameStatus,
    "changed_name": changedName,
    "dob": dob,
    "passport_no": passportNo,
    "passport_exp_date": passportExpDate,
    "first_language": firstLanguage,
    "citizen_country_id": citizenCountryId,
    "gender": gender,
    "email_id": emailId,
    "mobile_no": mobileNo,
    "phone_no": phoneNo,
    "parent_email_id": parentEmailId,
    "current_address": currentAddress,
    "current_country_id": currentCountryId,
    "current_state_id": currentStateId,
    "current_city_id": currentCityId,
    "current_zip_code": currentZipCode,
    "same_as_current_address": sameAsCurrentAddress,
    "communication_address": communicationAddress,
    "communication_country_id": communicationCountryId,
    "communication_state_id": communicationStateId,
    "communication_city_id": communicationCityId,
    "communication_zip_code": communicationZipCode,
    "sponsor_full_name": sponsorFullName,
    "sponsor_relation": sponsorRelation,
    "sponsor_annual_income": sponsorAnnualIncome,
    "sponsor_available_bal": sponsorAvailableBal,
    "sponsor_occupation": sponsorOccupation,
    "sponsor_organization_name": sponsorOrganizationName,
    "sponsor_affidavit_status": sponsorAffidavitStatus,
    "marital_status": maritalStatus,
    "spouse_full_name": spouseFullName,
    "date_of_marriage": dateOfMarriage,
    "place_of_marriage": placeOfMarriage,
    "date_of_betrothal": dateOfBetrothal,
    "spouse_family_name": spouseFamilyName,
    "spouse_dob": spouseDob,
    "spouse_education": spouseEducation,
    "marriage_reg_no": marriageRegNo,
    "divorce_reg_no": divorceRegNo,
    "have_child_status": haveChildStatus,
    "jewellery_valuation": jewelleryValuation,
    "home_valuation": homeValuation,
    "c_a_report": cAReport,
    "job_phone_no": jobPhoneNo,
    "job_email_id": jobEmailId,
    "agent_read_status": agentReadStatus,
    "admin_read_status": adminReadStatus,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "study_loan_status": studyLoanStatus,
    "loan_bank_name": loanBankName,
    "loan_amount": loanAmount,
    "loan_guarantor": loanGuarantor,
    "country_visa_applied_status": countryVisaAppliedStatus,
    "visa_applied_country_id": visaAppliedCountryId,
    "visa_applied_application": visaAppliedApplication,
    "denied_country_entry_status": deniedCountryEntryStatus,
    "denied_country_entry_note": deniedCountryEntryNote,
    "applied_visa_cancelled_status": appliedVisaCancelledStatus,
    "applied_visa_cancelled_note": appliedVisaCancelledNote,
    "police_verify_certificate_status": policeVerifyCertificateStatus,
    "pending_criminal_status": pendingCriminalStatus,
    "convicted_criminal_status": convictedCriminalStatus,
    "criminal_record_text": criminalRecordText,
    "medical_condition_status": medicalConditionStatus,
    "medical_condition_note": medicalConditionNote,
    "travelled_history_status": travelledHistoryStatus,
    "country_visa_refused_status": countryVisaRefusedStatus,
    "spouse_living_address": spouseLivingAddress,
    "spouse_visa_grant_no": spouseVisaGrantNo,
    "spouse_visa_validity_date": spouseVisaValidityDate,
    "spouse_institute": spouseInstitute,
    "spouse_course": spouseCourse,
    "spouse_changed_course_status": spouseChangedCourseStatus,
    "spouse_depart_foreign_study": spouseDepartForeignStudy,
    "spouse_work_status": spouseWorkStatus,
    "spouse_work_place": spouseWorkPlace,
    "spouse_work_place_address": spouseWorkPlaceAddress,
    "spouse_designation": spouseDesignation,
    "spouse_from_date": spouseFromDate,
    "spouse_to_date": spouseToDate,
    "spouse_income": spouseIncome,
    "spouse_passport_no": spousePassportNo,
    "spouse_occupation": spouseOccupation,
    "spouse_organization_address": spouseOrganizationAddress,
    "have_other_dependents_status": haveOtherDependentsStatus,
    "spouse_start_date": spouseStartDate,
    "spouse_end_date": spouseEndDate,
    "spouse_annual_income": spouseAnnualIncome,
    "stay_duration": stayDuration,
    "inviter_related": inviterRelated,
    "inviter_resident_status": inviterResidentStatus,
    "inviter_family_size_unit": inviterFamilySizeUnit,
    "inviter_occupation": inviterOccupation,
    "invitation_letter_status": invitationLetterStatus,
    "immigration_history_flag": immigrationHistoryFlag,
    "property_valuation": propertyValuation,
    "property_address": propertyAddress,
    "max_gross_amount": maxGrossAmount,
    "apostille_country_id": apostilleCountryId,
    "translation_country_id": translationCountryId,
    "telegraphic_transfer_amount": telegraphicTransferAmount,
    "telegraphic_transfer_currency_id": telegraphicTransferCurrencyId,
    "middle_name": middleName,
    "soprf_designation": soprfDesignation,
    "soprf_no_candidate": soprfNoCandidate,
    "soprf_salary": soprfSalary,
    "soprf_place_interview": soprfPlaceInterview,
    "soprf_interview_time": soprfInterviewTime,
    "soprf_duties_responsibilities": soprfDutiesResponsibilities,
    "soprf_note": soprfNote,
  };
}

class UserSops {
  UserSops({
    required this.id,
    this.razorpayPaymentId,
    this.stripePaymentId,
    required this.userId,
    required this.agentId,
    required this.adminId,
    required this.serviceTypeId,
    required this.letterTypeId,
    required this.countryId,
    this.description,
    required this.orderQty,
    required this.netPrice,
    required this.orderPrice,
    this.cgst,
    this.sgst,
    required this.igst,
    required this.gstOrderPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.holdOfferLetterStatus,
    required this.refundStatus,
    required this.refundPrice,
    this.refundDate,
    required this.cancelStatus,
    required this.cancelPrice,
    this.cancelDate,
    required this.adminUnreadCount,
    required this.agentUnreadCount,
    required this.paymentDate,
    required this.walletPaymentStatus,
    required this.walletOrderPrice,
    required this.paytmOrderPrice,
    required this.paytmTransactionStatus,
    required this.completeAt,
    required this.invoicePdf,
    this.paymentOnByMethod,
    required this.invoiceId,
    required this.invoiceNumber,
    required this.invoiceYear,
  });

  int id;
  dynamic razorpayPaymentId;
  dynamic stripePaymentId;
  int userId;
  int agentId;
  int adminId;
  int serviceTypeId;
  int letterTypeId;
  int countryId;
  dynamic description;
  int orderQty;
  String netPrice;
  String orderPrice;
  dynamic cgst;
  dynamic sgst;
  String igst;
  String gstOrderPrice;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int holdOfferLetterStatus;
  int refundStatus;
  String refundPrice;
  dynamic refundDate;
  int cancelStatus;
  String cancelPrice;
  dynamic cancelDate;
  int adminUnreadCount;
  int agentUnreadCount;
  DateTime paymentDate;
  int walletPaymentStatus;
  String walletOrderPrice;
  String paytmOrderPrice;
  int paytmTransactionStatus;
  DateTime completeAt;
  String invoicePdf;
  dynamic paymentOnByMethod;
  String invoiceId;
  String invoiceNumber;
  String invoiceYear;

  factory UserSops.fromJson(Map<String, dynamic> json) => UserSops(
    id: json["id"],
    razorpayPaymentId: json["razorpay_payment_id"],
    stripePaymentId: json["stripe_payment_id"],
    userId: json["user_id"],
    agentId: json["agent_id"],
    adminId: json["admin_id"],
    serviceTypeId: json["service_type_id"],
    letterTypeId: json["letter_type_id"],
    countryId: json["country_id"],
    description: json["description"],
    orderQty: json["order_qty"],
    netPrice: json["net_price"],
    orderPrice: json["order_price"],
    cgst: json["cgst"],
    sgst: json["sgst"],
    igst: json["igst"],
    gstOrderPrice: json["gst_order_price"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    holdOfferLetterStatus: json["hold_offer_letter_status"],
    refundStatus: json["refund_status"],
    refundPrice: json["refund_price"],
    refundDate: json["refund_date"],
    cancelStatus: json["cancel_status"],
    cancelPrice: json["cancel_price"],
    cancelDate: json["cancel_date"],
    adminUnreadCount: json["admin_unread_count"],
    agentUnreadCount: json["agent_unread_count"],
    paymentDate: DateTime.parse(json["payment_date"]),
    walletPaymentStatus: json["wallet_payment_status"],
    walletOrderPrice: json["wallet_order_price"],
    paytmOrderPrice: json["paytm_order_price"],
    paytmTransactionStatus: json["paytm_transaction_status"],
    completeAt: DateTime.parse(json["complete_at"]),
    invoicePdf: json["invoice_pdf"],
    paymentOnByMethod: json["payment_on_by_method"],
    invoiceId: json["invoice_id"],
    invoiceNumber: json["invoice_number"],
    invoiceYear: json["invoice_year"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "razorpay_payment_id": razorpayPaymentId,
    "stripe_payment_id": stripePaymentId,
    "user_id": userId,
    "agent_id": agentId,
    "admin_id": adminId,
    "service_type_id": serviceTypeId,
    "letter_type_id": letterTypeId,
    "country_id": countryId,
    "description": description,
    "order_qty": orderQty,
    "net_price": netPrice,
    "order_price": orderPrice,
    "cgst": cgst,
    "sgst": sgst,
    "igst": igst,
    "gst_order_price": gstOrderPrice,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "hold_offer_letter_status": holdOfferLetterStatus,
    "refund_status": refundStatus,
    "refund_price": refundPrice,
    "refund_date": refundDate,
    "cancel_status": cancelStatus,
    "cancel_price": cancelPrice,
    "cancel_date": cancelDate,
    "admin_unread_count": adminUnreadCount,
    "agent_unread_count": agentUnreadCount,
    "payment_date": paymentDate.toIso8601String(),
    "wallet_payment_status": walletPaymentStatus,
    "wallet_order_price": walletOrderPrice,
    "paytm_order_price": paytmOrderPrice,
    "paytm_transaction_status": paytmTransactionStatus,
    "complete_at": "${completeAt.year.toString().padLeft(4, '0')}-${completeAt.month.toString().padLeft(2, '0')}-${completeAt.day.toString().padLeft(2, '0')}",
    "invoice_pdf": invoicePdf,
    "payment_on_by_method": paymentOnByMethod,
    "invoice_id": invoiceId,
    "invoice_number": invoiceNumber,
    "invoice_year": invoiceYear,
  };
}

class Tab {
  Tab({
    required this.tab,
    required this.status,
  });

  String tab;
  int status;

  factory Tab.fromJson(Map<String, dynamic> json) => Tab(
    tab: json["tab"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "tab": tab,
    "status": status,
  };
}