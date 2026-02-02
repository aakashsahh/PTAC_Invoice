import 'package:flutter/material.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';

/// Generic reusable modal bottom sheet for item selection
///
/// Usage:
/// ```dart
/// showCustomModalBottomSheet<MyItem>(
///   context: context,
///   title: 'Select Item',
///   items: myItemsList,
///   selectedItem: currentItem,
///   itemBuilder: (item) => ListTile(title: Text(item.name)),
///   onItemSelected: (item) => handleSelection(item),
///   showSearch: true,
/// );
/// ```
Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required Widget Function(T item) itemBuilder,
  required void Function(T item) onItemSelected,
  T? selectedItem,
  bool showSearch = false,
  String searchHint = 'Search...',
  double? height,
  bool isDismissible = true,
  bool enableDrag = true,
  String Function(T item)? searchFilter,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _CustomModalBottomSheetContent<T>(
      title: title,
      items: items,
      itemBuilder: itemBuilder,
      onItemSelected: onItemSelected,
      selectedItem: selectedItem,
      showSearch: showSearch,
      searchHint: searchHint,
      height: height,
      searchFilter: searchFilter,
    ),
  );
}

class _CustomModalBottomSheetContent<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final void Function(T item) onItemSelected;
  final T? selectedItem;
  final bool showSearch;
  final String searchHint;
  final double? height;
  final String Function(T item)? searchFilter;

  const _CustomModalBottomSheetContent({
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.onItemSelected,
    this.selectedItem,
    required this.showSearch,
    required this.searchHint,
    this.height,
    this.searchFilter,
  });

  @override
  State<_CustomModalBottomSheetContent<T>> createState() =>
      _CustomModalBottomSheetContentState<T>();
}

class _CustomModalBottomSheetContentState<T>
    extends State<_CustomModalBottomSheetContent<T>> {
  late List<T> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredItems = widget.items;
      });
      return;
    }

    setState(() {
      _filteredItems = widget.items.where((item) {
        if (widget.searchFilter != null) {
          return widget.searchFilter!(item).toLowerCase().contains(query);
        }
        return item.toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.screenHeight * 0.85;
    final bottomSheetHeight = widget.height ?? maxHeight;

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Search Bar
          if (widget.showSearch) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],

          // Divider
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),

          // Items List
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items found',
                          style: context.bodyLarge?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredItems.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = widget.selectedItem == item;

                      return Container(
                        color: isSelected
                            ? context.colorScheme.primary.withOpacity(0.05)
                            : null,
                        child: InkWell(
                          onTap: () {
                            widget.onItemSelected(item);
                            Navigator.pop(context, item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 4,
                            ),
                            child: widget.itemBuilder(item),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
