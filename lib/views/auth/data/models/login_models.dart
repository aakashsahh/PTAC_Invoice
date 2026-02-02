import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'login_models.g.dart';

// ============ LOGIN REQUEST ============
class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({required this.username, required this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

// ============ LOGIN RESPONSE ============
@JsonSerializable()
class LoginResponseModel {
  final bool status;
  final LoginDataModel data;
  final String message;

  LoginResponseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  User toEntity() => User(
    tokenNo: data.tokenNo,
    companyName: data.companyName,
    logo: data.logo,
    status: data.status,
  );
}

// ============ LOGIN DATA ============
@JsonSerializable()
class LoginDataModel {
  @JsonKey(name: 'TokenNo')
  final String tokenNo;

  @JsonKey(name: 'CompanyName')
  final String companyName;

  @JsonKey(name: 'Logo')
  final String logo;

  @JsonKey(name: 'Status')
  final int status;

  LoginDataModel({
    required this.tokenNo,
    required this.companyName,
    required this.logo,
    required this.status,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
}

// Note: Run this command to generate the .g.dart file:
// dart run build_runner build --delete-conflicting-outputs
