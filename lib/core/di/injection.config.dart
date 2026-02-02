// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../views/auth/data/datasources/auth_remote_data_source.dart'
    as _i109;
import '../../views/auth/data/repositories/auth_repository_impl.dart' as _i31;
import '../../views/auth/domain/repositories/auth_repository.dart' as _i1066;
import '../../views/auth/domain/usecases/login_usecase.dart' as _i48;
import '../../views/auth/presentation/bloc/bloc/auth_bloc.dart' as _i1054;
import '../../views/dashboard/data/datasources/dashboard_remote_data_source.dart'
    as _i83;
import '../../views/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i1048;
import '../../views/dashboard/domain/repositories/dashboard_repository.dart'
    as _i763;
import '../../views/dashboard/domain/usecases/get_dashboard_data.dart'
    as _i1005;
import '../../views/dashboard/presentation/bloc/bloc/dashboard_bloc.dart'
    as _i659;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/logging_interceptor.dart' as _i344;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i344.LoggingInterceptor>(
      () => _i344.LoggingInterceptor(),
    );
    gh.lazySingleton<_i83.DashboardRemoteDataSource>(
      () => _i83.DashboardRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i109.AuthRemoteDataSource>(
      () => _i109.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i745.AuthInterceptor>(
      () => _i745.AuthInterceptor(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i763.DashboardRepository>(
      () =>
          _i1048.DashboardRepositoryImpl(gh<_i83.DashboardRemoteDataSource>()),
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(
        authInterceptor: gh<_i745.AuthInterceptor>(),
        loggingInterceptor: gh<_i344.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i1066.AuthRepository>(
      () => _i31.AuthRepositoryImpl(
        gh<_i109.AuthRemoteDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i1005.GetDashboardData>(
      () => _i1005.GetDashboardData(gh<_i763.DashboardRepository>()),
    );
    gh.lazySingleton<_i48.LoginUseCase>(
      () => _i48.LoginUseCase(gh<_i1066.AuthRepository>()),
    );
    gh.factory<_i1054.AuthBloc>(
      () =>
          _i1054.AuthBloc(gh<_i48.LoginUseCase>(), gh<_i1066.AuthRepository>()),
    );
    gh.factory<_i659.DashboardBloc>(
      () => _i659.DashboardBloc(gh<_i1005.GetDashboardData>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
