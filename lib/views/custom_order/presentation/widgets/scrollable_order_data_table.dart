import 'package:flutter/material.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';

import '../pages/customer_order_page.dart';

class ScrollableOrderDataTable extends StatefulWidget {
  final List<OrderData> orders;

  const ScrollableOrderDataTable({super.key, required this.orders});

  @override
  State<ScrollableOrderDataTable> createState() =>
      _ScrollableOrderDataTableState();
}

class _ScrollableOrderDataTableState extends State<ScrollableOrderDataTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  bool _showScrollHint = true;

  @override
  void initState() {
    super.initState();
    _horizontalController.addListener(_onScroll);
    // Hide scroll hint after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showScrollHint = false);
      }
    });
  }

  void _onScroll() {
    if (_horizontalController.offset > 10 && _showScrollHint) {
      setState(() => _showScrollHint = false);
    }
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Scroll Hint
          if (_showScrollHint && widget.orders.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.swipe,
                    size: 16,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Swipe left/right to view all columns',
                    style: context.bodySmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Table Content
          Expanded(
            child: widget.orders.isEmpty
                ? _buildEmptyState()
                : _buildScrollableTable(),
          ),
          //SizedBox(height: 28.h),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: context.bodyLarge?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select filters and click "Show" to display orders',
            style: context.bodySmall?.copyWith(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableTable() {
    return Scrollbar(
      controller: _horizontalController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: context.screenWidth - 32),
          child: Column(
            children: [
              // Sticky Header
              _buildTableHeader(),

              // Scrollable Body
              Expanded(
                child: Scrollbar(
                  controller: _verticalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _verticalController,
                    child: _buildTableBody(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell('SR\nNO', 60),
          //_buildHeaderCell('ACTION', 140),
          _buildHeaderCell('ORDER\nNO.', 120),
          _buildHeaderCell('BDATE', 110),
          _buildHeaderCell('PARTY\nNAME', 180),
          _buildHeaderCell('ITEM\nNAME', 180),
          _buildHeaderCell('QTY', 80),
          _buildHeaderCell('RATE', 100),
          _buildHeaderCell('AMOUNT', 120),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF3F51B5),
          letterSpacing: 0.5,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildTableBody() {
    return Column(
      children: widget.orders.asMap().entries.map((entry) {
        final index = entry.key;
        final order = entry.value;
        final isEven = index % 2 == 0;

        return Container(
          decoration: BoxDecoration(
            color: isEven
                ? context.colorScheme.surfaceContainer
                : context.colorScheme.surfaceContainerLowest,
            border: Border(
              bottom: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildDataCell(order.srNo, 60),
              // _buildActionCell(order, 140),
              _buildDataCell(order.orderNo, 120),
              _buildDataCell(order.bDate, 110),
              _buildDataCell(order.partyName, 180),
              _buildDataCell(order.itemName, 180),
              _buildDataCell(order.quantity, 80),
              _buildDataCell(order.rate, 100),
              _buildDataCell(order.amount, 120, isBold: true),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDataCell(String text, double width, {bool isBold = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          color: const Color(0xFF424242),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ignore: unused_element
  Widget _buildActionCell(OrderData order, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ActionButton(
            icon: Icons.edit_outlined,
            color: const Color(0xFF2196F3),
            tooltip: 'Edit',
            onTap: () {
              context.showSnackBar('Edit order: ${order.orderNo}');
            },
          ),
          const SizedBox(width: 6),
          _ActionButton(
            icon: Icons.delete_outline,
            color: const Color(0xFFE53935),
            tooltip: 'Delete',
            onTap: () {
              _showDeleteConfirmation(order);
            },
          ),
          const SizedBox(width: 6),
          _ActionButton(
            icon: Icons.visibility_outlined,
            color: const Color(0xFF43A047),
            tooltip: 'View',
            onTap: () {
              context.showSnackBar('View order: ${order.orderNo}');
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(OrderData order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: Text(
          'Are you sure you want to delete order ${order.orderNo}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.showErrorSnackBar('Order deleted: ${order.orderNo}');
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFE53935),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
