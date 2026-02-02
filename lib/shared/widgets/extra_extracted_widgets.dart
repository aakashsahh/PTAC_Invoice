import 'package:flutter/material.dart';

class InkWellWithDelay extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double radius;
  final int delay;
  const InkWellWithDelay({
    super.key,
    required this.onTap,
    required this.child,
    this.radius = 16,
    this.delay = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: InkWell(
        splashColor: Colors.grey.withValues(alpha: .5),
        highlightColor: Colors.grey.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(radius),
        autofocus: true,
        onTap: () {
          Future.delayed(Duration(milliseconds: delay), () {
            onTap?.call();
          });
        },
        child: child,
      ),
    );
  }
}
