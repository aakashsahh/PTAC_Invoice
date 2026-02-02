import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ptac_invoice/views/dashboard/domain/entities/dashboard_entities.dart';
import 'package:ptac_invoice/views/dashboard/domain/usecases/get_dashboard_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData _getDashboardData;

  DashboardBloc(this._getDashboardData) : super(DashboardInitial()) {
    on<LoadDashboardDataEvent>(_onLoadDashboardData);
    on<RefreshDashboardDataEvent>(_onRefreshDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    debugPrint('📊 Loading Dashboard Data...');
    emit(DashboardLoading());

    final result = await _getDashboardData();

    result.fold(
      (failure) {
        debugPrint('❌ Dashboard Load Failed: ${failure.message}');
        emit(DashboardError(failure.message));
      },
      (data) {
        debugPrint('✅ Dashboard Loaded Successfully');
        debugPrint('   - Forms: ${data.formData.length}');
        debugPrint('   - Branches: ${data.branch.length}');
        emit(DashboardLoaded(data));
      },
    );
  }

  Future<void> _onRefreshDashboardData(
    RefreshDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    debugPrint('🔄 Refreshing Dashboard Data...');

    // Keep current data while refreshing
    if (state is DashboardLoaded) {
      emit(DashboardRefreshing((state as DashboardLoaded).dashboardData));
    } else {
      emit(DashboardLoading());
    }

    final result = await _getDashboardData();

    result.fold(
      (failure) {
        debugPrint('❌ Dashboard Refresh Failed: ${failure.message}');
        // If we have existing data, keep it and show error as snackbar
        if (state is DashboardRefreshing) {
          emit(
            DashboardLoaded(
              (state as DashboardRefreshing).dashboardData,
              errorMessage: failure.message,
            ),
          );
        } else {
          emit(DashboardError(failure.message));
        }
      },
      (data) {
        debugPrint('✅ Dashboard Refreshed Successfully');
        emit(DashboardLoaded(data));
      },
    );
  }
}
