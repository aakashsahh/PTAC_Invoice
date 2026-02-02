part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardRefreshing extends DashboardState {
  final DashboardData dashboardData;

  const DashboardRefreshing(this.dashboardData);

  @override
  List<Object?> get props => [dashboardData];
}

class DashboardLoaded extends DashboardState {
  final DashboardData dashboardData;
  final String? errorMessage; // For refresh errors

  const DashboardLoaded(this.dashboardData, {this.errorMessage});

  // Get only menu items (SubCategory == 0)
  List<FormData> get menuItems =>
      dashboardData.formData.where((f) => f.isMenuItem).toList();

  // Get categories (SubCategory == 1)
  List<FormData> get categories =>
      dashboardData.formData.where((f) => f.isCategory).toList();

  // Get user data
  UserData? get userData =>
      dashboardData.userData.isNotEmpty ? dashboardData.userData.first : null;

  // Get branch data
  Branch? get branch =>
      dashboardData.branch.isNotEmpty ? dashboardData.branch.first : null;

  @override
  List<Object?> get props => [dashboardData, errorMessage];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardEmpty extends DashboardState {
  const DashboardEmpty();
}
