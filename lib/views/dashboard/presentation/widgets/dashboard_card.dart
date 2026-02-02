import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';

class DashboardCard extends StatelessWidget {
  final String iconUrl;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.iconUrl,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconCircle(
              iconUrl: iconUrl,
              iconColor: iconColor,
              bgColor: backgroundColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final String iconUrl;
  final Color iconColor;
  final Color bgColor;

  const _IconCircle({
    required this.iconUrl,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(child: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    if (iconUrl.endsWith('.svg')) {
      return SvgPicture.network(
        iconUrl,
        width: 32,
        height: 32,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    }

    return CachedNetworkImage(
      imageUrl: iconUrl,
      width: 26,
      height: 26,
      color: iconColor,
      errorWidget: (_, __, ___) =>
          Icon(Icons.dashboard_outlined, color: iconColor),
    );
  }
}
