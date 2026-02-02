import 'package:flutter/material.dart';
import 'package:ptac_invoice/views/dashboard/domain/entities/dashboard_entities.dart';
import 'package:ptac_invoice/views/dashboard/presentation/widgets/dashboard_card.dart';

class CategoryAllItemsScreen extends StatelessWidget {
  final String title;
  final List<FormData> items;
  final void Function(FormData item) onTap;

  const CategoryAllItemsScreen({
    super.key,
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
