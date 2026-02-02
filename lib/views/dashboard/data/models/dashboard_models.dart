import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptac_invoice/views/dashboard/domain/entities/dashboard_entities.dart';

part 'dashboard_models.g.dart';

// ============ DASHBOARD RESPONSE ============
@JsonSerializable()
class DashboardResponseModel {
  final bool status;
  final DashboardDataModel data;
  final String message;

  DashboardResponseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseModelToJson(this);

  DashboardData toEntity() => DashboardData(
    userData: data.userData.map((e) => e.toEntity()).toList(),
    branch: data.branch.map((e) => e.toEntity()).toList(),
    formData: data.formData.map((e) => e.toEntity()).toList(),
  );
}

// ============ DASHBOARD DATA ============
@JsonSerializable()
class DashboardDataModel {
  final List<UserDataModel> userData;
  final List<BranchModel> branch;
  final List<FormDataModel> formData;

  DashboardDataModel({
    required this.userData,
    required this.branch,
    required this.formData,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataModelToJson(this);
}

// ============ USER DATA ============
@JsonSerializable()
class UserDataModel {
  @JsonKey(name: 'CompanyName')
  final String companyName;

  @JsonKey(name: 'Address1')
  final String address1;

  @JsonKey(name: 'Address2')
  final String address2;

  @JsonKey(name: 'Valdityupto')
  final DateTimeModel validityUpto;

  @JsonKey(name: 'SerialKey')
  final String serialKey;

  @JsonKey(name: 'AgentName')
  final String agentName;

  @JsonKey(name: 'Code')
  final int code;

  @JsonKey(name: 'UserID')
  final String userId;

  @JsonKey(name: 'DpCode')
  final String dpCode;

  @JsonKey(name: 'UserType')
  final int userType;

  @JsonKey(name: 'ServerDate')
  final DateTimeModel serverDate;

  @JsonKey(name: 'BackDays')
  final int backDays;

  @JsonKey(name: 'SAdmin')
  final int sAdmin;

  @JsonKey(name: 'MobileNo')
  final String mobileNo;

  @JsonKey(name: 'AccountName')
  final String accountName;

  @JsonKey(name: 'EmailID')
  final String emailId;

  @JsonKey(name: 'CRMCode')
  final String crmCode;

  @JsonKey(name: 'UserRole')
  final String userRole;

  UserDataModel({
    required this.companyName,
    required this.address1,
    required this.address2,
    required this.validityUpto,
    required this.serialKey,
    required this.agentName,
    required this.code,
    required this.userId,
    required this.dpCode,
    required this.userType,
    required this.serverDate,
    required this.backDays,
    required this.sAdmin,
    required this.mobileNo,
    required this.accountName,
    required this.emailId,
    required this.crmCode,
    required this.userRole,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  UserData toEntity() => UserData(
    companyName: companyName,
    address1: address1,
    address2: address2,
    validityUpto: validityUpto.toDateTime(),
    serialKey: serialKey,
    agentName: agentName,
    code: code,
    userId: userId,
    dpCode: dpCode,
    userType: userType,
    serverDate: serverDate.toDateTime(),
    backDays: backDays,
    sAdmin: sAdmin,
    mobileNo: mobileNo,
    accountName: accountName,
    emailId: emailId,
    crmCode: crmCode,
    userRole: userRole,
  );
}

// ============ BRANCH ============
@JsonSerializable()
class BranchModel {
  @JsonKey(name: 'BranchCode')
  final String branchCode;

  @JsonKey(name: 'BranchName')
  final String branchName;

  @JsonKey(name: 'TokenNo')
  final String tokenNo;

  @JsonKey(name: 'BranchAbbr')
  final String branchAbbr;

  @JsonKey(name: 'BranchID')
  final String branchId;

  BranchModel({
    required this.branchCode,
    required this.branchName,
    required this.tokenNo,
    required this.branchAbbr,
    required this.branchId,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  Branch toEntity() => Branch(
    branchCode: branchCode,
    branchName: branchName,
    tokenNo: tokenNo,
    branchAbbr: branchAbbr,
    branchId: branchId,
  );
}

// ============ FORM DATA (Dashboard Cards) ============
@JsonSerializable()
class FormDataModel {
  @JsonKey(name: 'GroupName')
  final String groupName;

  @JsonKey(name: 'Category')
  final String category;

  @JsonKey(name: 'FormKey')
  final int formKey;

  @JsonKey(name: 'FormName')
  final String formName;

  @JsonKey(name: 'FGroup')
  final int fGroup;

  @JsonKey(name: 'SubCategory')
  final int subCategory;

  @JsonKey(name: 'SerNo')
  final int serNo;

  @JsonKey(name: 'SGroup')
  final int sGroup;

  @JsonKey(name: 'FormColor')
  final String formColor;

  @JsonKey(name: 'FormIcon')
  final String formIcon;

  @JsonKey(name: 'FCreation')
  final int fCreation;

  @JsonKey(name: 'FAlteration')
  final int fAlteration;

  @JsonKey(name: 'FDeletion')
  final int fDeletion;

  @JsonKey(name: 'FPrint')
  final int fPrint;

  FormDataModel({
    required this.groupName,
    required this.category,
    required this.formKey,
    required this.formName,
    required this.fGroup,
    required this.subCategory,
    required this.serNo,
    required this.sGroup,
    required this.formColor,
    required this.formIcon,
    required this.fCreation,
    required this.fAlteration,
    required this.fDeletion,
    required this.fPrint,
  });

  factory FormDataModel.fromJson(Map<String, dynamic> json) =>
      _$FormDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataModelToJson(this);

  FormData toEntity() => FormData(
    groupName: groupName,
    category: category,
    formKey: formKey,
    formName: formName,
    fGroup: fGroup,
    subCategory: subCategory,
    serNo: serNo,
    sGroup: sGroup,
    formColor: _parseColor(formColor),
    formIcon: formIcon,
    fCreation: fCreation == 1,
    fAlteration: fAlteration == 1,
    fDeletion: fDeletion == 1,
    fPrint: fPrint == 1,
  );

  Color _parseColor(String hexColor) {
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return const Color(0xFFE5FFFA);
    }
  }
}

// ============ DATE TIME MODEL ============
@JsonSerializable()
class DateTimeModel {
  final String date;

  @JsonKey(name: 'timezone_type')
  final int timezoneType;

  final String timezone;

  DateTimeModel({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory DateTimeModel.fromJson(Map<String, dynamic> json) =>
      _$DateTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeModelToJson(this);

  DateTime toDateTime() {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }
}

// Keep your existing UserDataModel, BranchModel, and DateTimeModel...
