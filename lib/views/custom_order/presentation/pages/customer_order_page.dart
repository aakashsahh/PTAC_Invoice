import 'package:flutter/material.dart';
import 'package:ptac_invoice/core/constants/image_constants.dart';
import 'package:ptac_invoice/core/constants/storage_constants.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/core/extensions/responsive_extension.dart';
import 'package:ptac_invoice/shared/widgets/buttons.dart';
import 'package:ptac_invoice/shared/widgets/custom_modal_bottom_sheeet.dart';
import 'package:ptac_invoice/shared/widgets/custom_text.dart';
import 'package:ptac_invoice/shared/widgets/custom_textfield.dart';
import 'package:ptac_invoice/views/custom_order/presentation/widgets/scrollable_order_data_table.dart';

class CustomerOrderPage extends StatefulWidget {
  const CustomerOrderPage({super.key});

  @override
  State<CustomerOrderPage> createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends State<CustomerOrderPage> {
  final TextEditingController _partyNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Mock data for parties
  final List<PartyItem> _parties = [
    PartyItem(id: '1', name: 'ABC Traders'),
    PartyItem(id: '2', name: 'XYZ Enterprises'),
    PartyItem(id: '3', name: 'Global Solutions'),
    PartyItem(id: '4', name: 'Tech Industries'),
    PartyItem(id: '5', name: 'Metro Suppliers'),
    PartyItem(id: '6', name: 'Elite Commerce'),
    PartyItem(id: '7', name: 'Prime Distributors'),
    PartyItem(id: '8', name: 'Royal Traders'),
    PartyItem(id: '9', name: 'Alpha Suppliers'),
    PartyItem(id: '10', name: 'Beta Distributors'),
    PartyItem(id: '11', name: 'Gamma Merchants'),
    PartyItem(id: '12', name: 'Delta Traders'),
    PartyItem(id: '13', name: 'Epsilon Enterprises'),
    PartyItem(id: '14', name: 'Zeta Industries'),
    PartyItem(id: '15', name: 'Eta Solutions'),
  ];

  // Mock order data
  final List<OrderData> _orders = [
    OrderData(
      srNo: '1',
      orderNo: '001',
      bDate: '2026-01-12',
      partyName: 'ABC Company',
      itemName: 'Steel',
      quantity: '10',
      rate: '200',
      amount: '2000',
    ),
    OrderData(
      srNo: '2',
      orderNo: '002',
      bDate: '2026-01-12',
      partyName: 'Modern Electronics',
      itemName: 'Heater',
      quantity: '10',
      rate: '10000',
      amount: '100000',
    ),
    OrderData(
      srNo: '3',
      orderNo: '001',
      bDate: '2026-01-12',
      partyName: 'ABC Company',
      itemName: 'Steel',
      quantity: '10',
      rate: '200',
      amount: '2000',
    ),
    OrderData(
      srNo: '4',
      orderNo: '002',
      bDate: '2026-01-12',
      partyName: 'Modern Electronics',
      itemName: 'Heater',
      quantity: '10',
      rate: '10000',
      amount: '100000',
    ),
    OrderData(
      srNo: '5',
      orderNo: '001',
      bDate: '2026-01-12',
      partyName: 'ABC Company',
      itemName: 'Steel',
      quantity: '10',
      rate: '200',
      amount: '2000',
    ),
    OrderData(
      srNo: '6',
      orderNo: '002',
      bDate: '2026-01-12',
      partyName: 'Modern Electronics',
      itemName: 'Heater',
      quantity: '10',
      rate: '10000',
      amount: '100000',
    ),
    OrderData(
      srNo: '7',
      orderNo: '001',
      bDate: '2026-01-12',
      partyName: 'ABC Company',
      itemName: 'Steel',
      quantity: '10',
      rate: '200',
      amount: '2000',
    ),
    OrderData(
      srNo: '8',
      orderNo: '002',
      bDate: '2026-01-12',
      partyName: 'Modern Electronics',
      itemName: 'Heater',
      quantity: '10',
      rate: '10000',
      amount: '100000',
    ),
    OrderData(
      srNo: '9',
      orderNo: '001',
      bDate: '2026-01-12',
      partyName: 'ABC Company',
      itemName: 'Steel',
      quantity: '10',
      rate: '200',
      amount: '2000',
    ),
    OrderData(
      srNo: '10',
      orderNo: '002',
      bDate: '2026-01-12',
      partyName: 'Modern Electronics',
      itemName: 'Heater',
      quantity: '10',
      rate: '10000',
      amount: '100000',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);

    _startDateController.text = _formatDate(startOfYear);
    _endDateController.text = _formatDate(now);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}';
  }

  void _showPartySelectionSheet() {
    showCustomModalBottomSheet<PartyItem>(
      context: context,
      title: 'Select Party',
      items: _parties,
      selectedItem: _parties.firstWhere(
        (party) => party.name == _partyNameController.text,
        orElse: () => _parties.first,
      ),
      itemBuilder: (party) => ListTile(
        title: Text(
          party.name,
          style: context.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.chevron_right, color: context.colorScheme.primary),
      ),
      onItemSelected: (party) {
        setState(() {
          _partyNameController.text = party.name;
        });
      },
      showSearch: true,
      searchHint: 'Search party...',
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: context.colorScheme),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        controller.text = _formatDate(picked);
      });
    }
  }

  void _showOrders() {
    // Implement show orders logic
    context.showSuccessSnackBar('Loading orders...');
  }

  @override
  void dispose() {
    _partyNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Column(
          children: [
            Image.asset(
              ImageConstants.ptacLogo,
              height: 48.h,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'PTAC',
                  style: context.headlineSmall?.copyWith(
                    color: context.onSurface,
                  ),
                );
              },
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: StorageConstants.clientName,
              style: context.bodySmall?.copyWith(
                color: context.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: context.primaryColor.withValues(alpha: 0.1),
              child: Icon(Icons.person, color: context.primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title and Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Customer Order',
                    style: context.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to add order page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Filter Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.shadow.withValues(alpha: 0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Party Name
                    Text(
                      'PARTY NAME',
                      style: context.labelMedium?.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _showPartySelectionSheet,
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: 'Select Party',
                          controller: _partyNameController,
                          readOnly: true,
                          isLabel: false,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Start Date
                    Text(
                      'START DATE',
                      style: context.labelMedium?.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(_startDateController),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: 'Select Start Date',
                          controller: _startDateController,
                          readOnly: true,
                          isLabel: false,
                          icon: Icon(
                            Icons.calendar_today,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // End Date
                    Text(
                      'END DATE',
                      style: context.labelMedium?.copyWith(
                        color: context.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(_endDateController),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: 'Select End Date',
                          controller: _endDateController,
                          readOnly: true,
                          isLabel: false,
                          icon: Icon(
                            Icons.calendar_today,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Show Button
                    LoginButton(
                      text: 'Show',
                      isFull: false,
                      onPress: _showOrders,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Orders Table
              SizedBox(
                height: 500.h,
                width: double.infinity,
                child: ScrollableOrderDataTable(orders: _orders),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Models
class PartyItem {
  final String id;
  final String name;

  PartyItem({required this.id, required this.name});
}

class OrderData {
  final String srNo;
  final String orderNo;
  final String bDate;
  final String partyName;
  final String itemName;
  final String quantity;
  final String rate;
  final String amount;

  OrderData({
    required this.srNo,
    required this.orderNo,
    required this.bDate,
    required this.partyName,
    required this.itemName,
    required this.quantity,
    required this.rate,
    required this.amount,
  });
}
