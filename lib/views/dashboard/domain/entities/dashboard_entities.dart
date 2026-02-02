import 'dart:ui';

import 'package:equatable/equatable.dart';

// ============ DASHBOARD DATA ============
class DashboardData extends Equatable {
  final List<UserData> userData;
  final List<Branch> branch;
  final List<FormData> formData;

  const DashboardData({
    required this.userData,
    required this.branch,
    required this.formData,
  });

  @override
  List<Object?> get props => [userData, branch, formData];
}

// ============ USER DATA ============
class UserData extends Equatable {
  final String companyName;
  final String address1;
  final String address2;
  final DateTime validityUpto;
  final String serialKey;
  final String agentName;
  final int code;
  final String userId;
  final String dpCode;
  final int userType;
  final DateTime serverDate;
  final int backDays;
  final int sAdmin;
  final String mobileNo;
  final String accountName;
  final String emailId;
  final String crmCode;
  final String userRole;

  const UserData({
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

  @override
  List<Object?> get props => [
    companyName,
    address1,
    address2,
    validityUpto,
    serialKey,
    userId,
    dpCode,
    userType,
    serverDate,
    mobileNo,
    accountName,
    userRole,
  ];
}

// ============ BRANCH ============
class Branch extends Equatable {
  final String branchCode;
  final String branchName;
  final String tokenNo;
  final String branchAbbr;
  final String branchId;

  const Branch({
    required this.branchCode,
    required this.branchName,
    required this.tokenNo,
    required this.branchAbbr,
    required this.branchId,
  });

  @override
  List<Object?> get props => [
    branchCode,
    branchName,
    tokenNo,
    branchAbbr,
    branchId,
  ];
}

// ============ FORM DATA (Dashboard Cards) ============
class FormData extends Equatable {
  final String groupName;
  final String category;
  final int formKey;
  final String formName;
  final int fGroup;
  final int subCategory;
  final int serNo;
  final int sGroup;
  final Color formColor;
  final String formIcon;
  final bool fCreation;
  final bool fAlteration;
  final bool fDeletion;
  final bool fPrint;

  const FormData({
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

  // Check if this is a category header (SubCategory == 1)
  bool get isCategory => subCategory == 1;

  // Check if this is a menu item (SubCategory == 0)
  bool get isMenuItem => subCategory == 0;

  // Check if user can create
  bool get canCreate => fCreation;

  // Check if user can edit
  bool get canEdit => fAlteration;

  // Check if user can delete
  bool get canDelete => fDeletion;

  // Check if user can print
  bool get canPrint => fPrint;

  @override
  List<Object?> get props => [
    groupName,
    category,
    formKey,
    formName,
    fGroup,
    subCategory,
    serNo,
    sGroup,
    formColor,
    formIcon,
    fCreation,
    fAlteration,
    fDeletion,
    fPrint,
  ];
}
