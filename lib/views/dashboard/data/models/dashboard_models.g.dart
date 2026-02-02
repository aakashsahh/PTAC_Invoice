// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponseModel _$DashboardResponseModelFromJson(
  Map<String, dynamic> json,
) => DashboardResponseModel(
  status: json['status'] as bool,
  data: DashboardDataModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
);

Map<String, dynamic> _$DashboardResponseModelToJson(
  DashboardResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) =>
    DashboardDataModel(
      userData: (json['userData'] as List<dynamic>)
          .map((e) => UserDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      branch: (json['branch'] as List<dynamic>)
          .map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      formData: (json['formData'] as List<dynamic>)
          .map((e) => FormDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataModelToJson(DashboardDataModel instance) =>
    <String, dynamic>{
      'userData': instance.userData,
      'branch': instance.branch,
      'formData': instance.formData,
    };

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      companyName: json['CompanyName'] as String,
      address1: json['Address1'] as String,
      address2: json['Address2'] as String,
      validityUpto: DateTimeModel.fromJson(
        json['Valdityupto'] as Map<String, dynamic>,
      ),
      serialKey: json['SerialKey'] as String,
      agentName: json['AgentName'] as String,
      code: (json['Code'] as num).toInt(),
      userId: json['UserID'] as String,
      dpCode: json['DpCode'] as String,
      userType: (json['UserType'] as num).toInt(),
      serverDate: DateTimeModel.fromJson(
        json['ServerDate'] as Map<String, dynamic>,
      ),
      backDays: (json['BackDays'] as num).toInt(),
      sAdmin: (json['SAdmin'] as num).toInt(),
      mobileNo: json['MobileNo'] as String,
      accountName: json['AccountName'] as String,
      emailId: json['EmailID'] as String,
      crmCode: json['CRMCode'] as String,
      userRole: json['UserRole'] as String,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'CompanyName': instance.companyName,
      'Address1': instance.address1,
      'Address2': instance.address2,
      'Valdityupto': instance.validityUpto,
      'SerialKey': instance.serialKey,
      'AgentName': instance.agentName,
      'Code': instance.code,
      'UserID': instance.userId,
      'DpCode': instance.dpCode,
      'UserType': instance.userType,
      'ServerDate': instance.serverDate,
      'BackDays': instance.backDays,
      'SAdmin': instance.sAdmin,
      'MobileNo': instance.mobileNo,
      'AccountName': instance.accountName,
      'EmailID': instance.emailId,
      'CRMCode': instance.crmCode,
      'UserRole': instance.userRole,
    };

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
  branchCode: json['BranchCode'] as String,
  branchName: json['BranchName'] as String,
  tokenNo: json['TokenNo'] as String,
  branchAbbr: json['BranchAbbr'] as String,
  branchId: json['BranchID'] as String,
);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'BranchCode': instance.branchCode,
      'BranchName': instance.branchName,
      'TokenNo': instance.tokenNo,
      'BranchAbbr': instance.branchAbbr,
      'BranchID': instance.branchId,
    };

FormDataModel _$FormDataModelFromJson(Map<String, dynamic> json) =>
    FormDataModel(
      groupName: json['GroupName'] as String,
      category: json['Category'] as String,
      formKey: (json['FormKey'] as num).toInt(),
      formName: json['FormName'] as String,
      fGroup: (json['FGroup'] as num).toInt(),
      subCategory: (json['SubCategory'] as num).toInt(),
      serNo: (json['SerNo'] as num).toInt(),
      sGroup: (json['SGroup'] as num).toInt(),
      formColor: json['FormColor'] as String,
      formIcon: json['FormIcon'] as String,
      fCreation: (json['FCreation'] as num).toInt(),
      fAlteration: (json['FAlteration'] as num).toInt(),
      fDeletion: (json['FDeletion'] as num).toInt(),
      fPrint: (json['FPrint'] as num).toInt(),
    );

Map<String, dynamic> _$FormDataModelToJson(FormDataModel instance) =>
    <String, dynamic>{
      'GroupName': instance.groupName,
      'Category': instance.category,
      'FormKey': instance.formKey,
      'FormName': instance.formName,
      'FGroup': instance.fGroup,
      'SubCategory': instance.subCategory,
      'SerNo': instance.serNo,
      'SGroup': instance.sGroup,
      'FormColor': instance.formColor,
      'FormIcon': instance.formIcon,
      'FCreation': instance.fCreation,
      'FAlteration': instance.fAlteration,
      'FDeletion': instance.fDeletion,
      'FPrint': instance.fPrint,
    };

DateTimeModel _$DateTimeModelFromJson(Map<String, dynamic> json) =>
    DateTimeModel(
      date: json['date'] as String,
      timezoneType: (json['timezone_type'] as num).toInt(),
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$DateTimeModelToJson(DateTimeModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'timezone_type': instance.timezoneType,
      'timezone': instance.timezone,
    };
