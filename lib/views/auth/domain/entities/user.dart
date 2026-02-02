import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String tokenNo;
  final String companyName;
  final String logo;
  final int status;

  const User({
    required this.tokenNo,
    required this.companyName,
    required this.logo,
    required this.status,
  });

  @override
  List<Object?> get props => [tokenNo, companyName, logo, status];
}
