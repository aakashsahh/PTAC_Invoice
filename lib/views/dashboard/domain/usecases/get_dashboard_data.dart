import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/dashboard_entities.dart';
import '../repositories/dashboard_repository.dart';

@lazySingleton
class GetDashboardData {
  final DashboardRepository _repository;

  GetDashboardData(this._repository);

  Future<Either<Failure, DashboardData>> call() async {
    return await _repository.getDashboardData();
  }
}
