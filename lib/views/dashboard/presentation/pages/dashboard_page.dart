import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptac_invoice/core/constants/image_constants.dart';
import 'package:ptac_invoice/core/utils/user_preference.dart';
import 'package:ptac_invoice/views/dashboard/domain/entities/dashboard_entities.dart';
import 'package:ptac_invoice/views/dashboard/presentation/bloc/bloc/dashboard_bloc.dart';
import 'package:ptac_invoice/views/dashboard/presentation/widgets/profile_menu.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/dashboard_shimmer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<DashboardBloc>()..add(const LoadDashboardDataEvent()),
      child: const _DashboardPageContent(),
    );
  }
}

class _DashboardPageContent extends StatelessWidget {
  const _DashboardPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Column(
          children: [
            Image.asset(
              ImageConstants.ptacLogo,
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'PTAC',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00696a),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return Text(
                    '${state.userData?.companyName ?? UserPreference.companyName} || ${state.branch?.branchName ?? ''}',
                    style: context.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return Text(
                  UserPreference.companyName,
                  style: context.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
        toolbarHeight: 80,
        actions: [
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoaded) {
                final userData = state.userData;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    userData?.userRole ?? 'USER',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => _showProfileMenu(context),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: context.primaryColor.withValues(alpha: 0.1),
                child: Icon(Icons.person, color: context.primaryColor),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoaded && state.errorMessage != null) {
            context.showErrorSnackBar(state.errorMessage!);
          } else if (state is DashboardError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const DashboardShimmer();
          }

          if (state is DashboardError) {
            return _buildErrorState(context, state.message);
          }

          if (state is DashboardLoaded) {
            return _buildLoadedState(context, state);
          }

          return const Center(child: Text('Welcome!'));
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: context.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DashboardBloc>().add(
                  const LoadDashboardDataEvent(),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  //show profile menu in app bar
  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: context.read<DashboardBloc>(),
        child: ProfileMenu(),
      ),
    );
  }

  // Widget _buildLoadedState(BuildContext context, DashboardLoaded state) {
  //   final formData = state.dashboardData.formData;
  //   const int maxVisibleItems = 7;
  //   const int gridColumns = 4;

  //   if (formData.isEmpty) {
  //     return _buildEmptyState(context);
  //   }

  //   // Separate categories and menu items
  //   final categories = formData.where((item) => item.isCategory).toList();
  //   final menuItems = formData.where((item) => item.isMenuItem).toList();

  //   // Group categories by FGroup
  //   final groupedByFGroup = <int, List<FormData>>{};
  //   for (var category in categories) {
  //     if (!groupedByFGroup.containsKey(category.fGroup)) {
  //       groupedByFGroup[category.fGroup] = [];
  //     }
  //     groupedByFGroup[category.fGroup]!.add(category);
  //   }

  //   // Sort groups by FGroup value
  //   final sortedGroups = groupedByFGroup.keys.toList()..sort();

  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       context.read<DashboardBloc>().add(const LoadDashboardDataEvent());
  //       await Future.delayed(const Duration(seconds: 1));
  //     },
  //     child: SingleChildScrollView(
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Show Graphs Button
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () {},
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFF5B7FFF),
  //                 padding: const EdgeInsets.symmetric(vertical: 16),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 elevation: 0,
  //               ),
  //               child: const Text(
  //                 'Show Graphs',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 28),

  //           // Grouped Dashboard Sections
  //           ...sortedGroups.map((fGroup) {
  //             final categoriesInGroup = groupedByFGroup[fGroup]!;

  //             // Get the group name from first category
  //             final groupName = categoriesInGroup.first.groupName;

  //             // Get menu items for this FGroup that have SGroup = 0 (no parent category)
  //             final directMenuItems = menuItems
  //                 .where((item) => item.fGroup == fGroup && item.sGroup == 0)
  //                 .toList();
  //             final groupMenuItems = menuItems
  //                 .where((item) => item.fGroup == fGroup)
  //                 .toList();

  //             final hasMore = groupMenuItems.length > maxVisibleItems;

  //             final visibleItems = hasMore
  //                 ? groupMenuItems.take(maxVisibleItems).toList()
  //                 : groupMenuItems;
  //             return Container(
  //               margin: const EdgeInsets.only(bottom: 24),
  //               padding: const EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black.withOpacity(0.04),
  //                     blurRadius: 12,
  //                     offset: const Offset(0, 6),
  //                   ),
  //                 ],
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Section Header (Group name)
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 20, top: 4),
  //                     child: Text(
  //                       groupName,
  //                       style: const TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF1A1A1A),
  //                         letterSpacing: -0.5,
  //                       ),
  //                     ),
  //                   ),

  //                   // Categories and their menu items
  //                   ...categoriesInGroup.map((category) {
  //                     // Get menu items that belong to this category (SGroup = category.formKey)
  //                     final categoryMenuItems = menuItems
  //                         .where((item) => item.sGroup == category.formKey)
  //                         .toList();

  //                     // Skip if no menu items
  //                     if (categoryMenuItems.isEmpty) {
  //                       return const SizedBox.shrink();
  //                     }

  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         // Category Title
  //                         Container(
  //                           margin: const EdgeInsets.only(bottom: 12),
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 12,
  //                             vertical: 6,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: Colors.grey.shade100,
  //                             borderRadius: BorderRadius.circular(20),
  //                           ),
  //                           child: Text(
  //                             category.formName,
  //                             style: const TextStyle(
  //                               fontSize: 13,
  //                               fontWeight: FontWeight.w600,
  //                               color: Color(0xFF555555),
  //                             ),
  //                           ),
  //                         ),

  //                         // Menu items grid
  //                         GridView.builder(
  //                           shrinkWrap: true,
  //                           physics: const NeverScrollableScrollPhysics(),
  //                           itemCount: visibleItems.length + (hasMore ? 1 : 0),
  //                           gridDelegate:
  //                               const SliverGridDelegateWithFixedCrossAxisCount(
  //                                 crossAxisCount: gridColumns,
  //                                 mainAxisSpacing: 14,
  //                                 crossAxisSpacing: 14,
  //                                 childAspectRatio: 0.9,
  //                               ),
  //                           itemBuilder: (context, index) {
  //                             // 👉 Arrow tile
  //                             if (hasMore && index == visibleItems.length) {
  //                               return _ViewAllArrow(
  //                                 onTap: () {
  //                                   // Option A: navigate
  //                                   // Option B: expand inline
  //                                 },
  //                               );
  //                             }

  //                             final item = visibleItems[index];
  //                             return DashboardCard(
  //                               iconUrl: item.formIcon,
  //                               iconColor: _getIconColorForGroup(item.fGroup),
  //                               backgroundColor: item.formColor,
  //                               title: item.formName,
  //                               onTap: () => _handleCardTap(context, item),
  //                             );
  //                           },
  //                         ),

  //                         // DashboardWrap(
  //                         //   items: categoryMenuItems,
  //                         //   padding: const EdgeInsets.symmetric(horizontal: 0),
  //                         //   onTap: (item) => _handleCardTap(context, item),
  //                         // ),
  //                         const SizedBox(height: 20),
  //                       ],
  //                     );
  //                   }),

  //                   // Direct menu items (no parent category, SGroup = 0)
  //                   if (directMenuItems.isNotEmpty)
  //                     Column(
  //                       children: [
  //                         GridView.builder(
  //                           shrinkWrap: true,
  //                           physics: const NeverScrollableScrollPhysics(),
  //                           gridDelegate:
  //                               const SliverGridDelegateWithFixedCrossAxisCount(
  //                                 crossAxisCount: 2,
  //                                 mainAxisSpacing: 14,
  //                                 crossAxisSpacing: 14,
  //                                 childAspectRatio: 1.15,
  //                               ),
  //                           itemCount: directMenuItems.length,
  //                           itemBuilder: (context, index) {
  //                             final item = directMenuItems[index];
  //                             return DashboardCard(
  //                               iconUrl: item.formIcon,
  //                               iconColor: _getIconColorForGroup(item.fGroup),
  //                               backgroundColor: item.formColor,
  //                               title: item.formName,
  //                               onTap: () => _handleCardTap(context, item),
  //                             );
  //                           },
  //                         ),
  //                         const SizedBox(height: 20),
  //                       ],
  //                     ),

  //                   const SizedBox(height: 12),
  //                 ],
  //               ),
  //             );
  //           }),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildLoadedState(BuildContext context, DashboardLoaded state) {
    final formData = state.dashboardData.formData;

    if (formData.isEmpty) {
      return _buildEmptyState(context);
    }

    // 1️⃣ Parent categories → container headers
    final categories =
        formData
            .where((item) => item.subCategory == 1 && item.sGroup == 0)
            .toList()
          ..sort((a, b) => a.serNo.compareTo(b.serNo));

    // 2️⃣ Helper: children for a category
    List<FormData> categoryItems(FormData category) {
      return formData.where((item) => item.sGroup == category.formKey).toList()
        ..sort((a, b) => a.serNo.compareTo(b.serNo));
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(const LoadDashboardDataEvent());
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Show Graphs Button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF5B7FFF),
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       elevation: 0,
            //     ),
            //     child: const Text(
            //       'Show Graphs',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            Column(
              children: categories.map((category) {
                final items = categoryItems(category);

                if (items.isEmpty) return const SizedBox.shrink();

                return _DashboardCategoryContainer(
                  title: category.formName,
                  items: items,
                  onTap: (item) => _handleCardTap(context, item),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text('No menu items available', style: context.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Please contact administrator',
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  String _getGroupName(int fGroup) {
    switch (fGroup) {
      case 1:
        return 'Master';
      case 2:
        return 'Transaction';
      case 3:
        return 'Reports';
      case 4:
        return 'Analysis';
      case 6:
        return 'Accounts';
      default:
        return 'Others';
    }
  }

  void _handleCardTap(BuildContext context, FormData item) {
    switch (item.formKey) {
      case 105:
        context.pushNamed(AppRouter.partyMaster);
        break;
      case 320:
        context.pushNamed(AppRouter.customerOrder);
        break;
      case 324:
        context.pushNamed(AppRouter.dispatch);
        break;
      case 251:
        context.pushNamed(AppRouter.receiptVoucher);
        break;
      case 252:
        context.pushNamed(AppRouter.paymentVoucher);
        break;
      case 302:
        context.pushNamed(AppRouter.salesRegister);
        break;
      default:
        context.showSnackBar('${item.formName} - Coming Soon');
    }
  }
}

class DashboardWrap extends StatelessWidget {
  final List<FormData> items;
  final double spacing;
  final EdgeInsets padding;
  final void Function(FormData item) onTap;

  const DashboardWrap({
    super.key,
    required this.items,
    required this.onTap,
    this.spacing = 1,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final usableWidth = screenWidth - padding.horizontal - (spacing * 2);
    final itemWidth = usableWidth / 3;

    // Calculate how many placeholders needed
    final remainder = items.length % 3;
    final placeholders = remainder == 0 ? 0 : 3 - remainder;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          // Real items
          ...items.map((item) {
            return SizedBox(
              width: itemWidth,
              child: DashboardCard(
                iconUrl: item.formIcon,
                iconColor: _getIconColorForGroup(item.fGroup),
                backgroundColor: item.formColor,
                title: item.formName,
                onTap: () => onTap(item),
              ),
            );
          }),

          // Invisible placeholders to keep full row width
          for (int i = 0; i < placeholders; i++)
            SizedBox(
              width: itemWidth,
              height: 0, // important: no vertical space
            ),
          //     if (hasMore)
          //       SizedBox(
          //         width: itemWidth,
          //         child: _ViewAllArrow(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (_) => _CategoryAllItemsScreen(
          //                   title: title,
          //                   items: items,
          //                   onTap: onTap,
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
        ],
      ),
    );
  }

  Color _getIconColorForGroup(int fGroup) {
    switch (fGroup) {
      case 1: // Master Info
        return const Color(0xFF5B7FFF);
      case 2: // Transaction
        return const Color(0xFF00C853);
      case 3: // Display
        return const Color(0xFFFF9800);
      case 4: // Reports
        return const Color(0xFF9C27B0);
      case 6: // Accounts
        return const Color(0xFF00BCD4);
      default:
        return const Color(0xFF757575);
    }
  }
}

class _ViewAllArrow extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewAllArrow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF1DB954), // green accent
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardCategoryContainer extends StatelessWidget {
  final String title;
  final List<FormData> items;
  final void Function(FormData item) onTap;

  const _DashboardCategoryContainer({
    required this.title,
    required this.items,
    required this.onTap,
  });

  static const int _maxVisible = 7;

  @override
  Widget build(BuildContext context) {
    final hasMore = items.length > _maxVisible;
    final visibleItems = hasMore ? items.take(_maxVisible).toList() : items;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ),

          // Grid
          LayoutBuilder(
            builder: (context, constraints) {
              return DashboardWrap(items: items, onTap: onTap);
              // Wrap(
              //   spacing: spacing,
              //   runSpacing: spacing,
              //   alignment: WrapAlignment.start,
              //   children: [
              //     ...visibleItems.map((item) {
              //       return SizedBox(
              //         width: itemWidth,
              //         child: DashboardCard(
              //           iconUrl: item.formIcon,
              //           iconColor: _getIconColorForGroup(item.fGroup),
              //           backgroundColor: item.formColor,
              //           title: item.formName,
              //           onTap: () => onTap(item),
              //         ),
              //       );
              //     }),

              //     if (hasMore)
              //       SizedBox(
              //         width: itemWidth,
              //         child: _ViewAllArrow(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => _CategoryAllItemsScreen(
              //                   title: title,
              //                   items: items,
              //                   onTap: onTap,
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //   ],
              // );
            },
          ),
        ],
      ),
    );
  }

  Color _getIconColorForGroup(int fGroup) {
    switch (fGroup) {
      case 1: // Master Info
        return const Color(0xFF5B7FFF);
      case 2: // Transaction
        return const Color(0xFF00C853);
      case 3: // Display
        return const Color(0xFFFF9800);
      case 4: // Reports
        return const Color(0xFF9C27B0);
      case 6: // Accounts
        return const Color(0xFF00BCD4);
      default:
        return const Color(0xFF757575);
    }
  }
}

class _CategoryAllItemsScreen extends StatelessWidget {
  final String title;
  final List<FormData> items;
  final void Function(FormData item) onTap;

  const _CategoryAllItemsScreen({
    required this.title,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return DashboardCard(
              iconUrl: item.formIcon,
              iconColor: _getIconColorForGroup(item.fGroup),
              backgroundColor: item.formColor,
              title: item.formName,
              onTap: () => onTap(item),
            );
          },
        ),
      ),
    );
  }

  Color _getIconColorForGroup(int fGroup) {
    switch (fGroup) {
      case 1: // Master Info
        return const Color(0xFF5B7FFF);
      case 2: // Transaction
        return const Color(0xFF00C853);
      case 3: // Display
        return const Color(0xFFFF9800);
      case 4: // Reports
        return const Color(0xFF9C27B0);
      case 6: // Accounts
        return const Color(0xFF00BCD4);
      default:
        return const Color(0xFF757575);
    }
  }
}
