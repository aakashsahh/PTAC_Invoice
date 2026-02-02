import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/shared/widgets/custom_text.dart';
import 'package:ptac_invoice/shared/widgets/extra_extracted_widgets.dart';
import 'package:ptac_invoice/shared/widgets/extracted_dialogs.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String text;
  final Color? color;
  final Color? textcolor;
  final bool isFull;
  final bool isLoading;
  final bool isNewButton;
  final String icon;
  final double? padBot;
  final Color? borderColor;
  final FontWeight? weight;

  const LoginButton({
    super.key,
    this.onPress,
    this.text = '',
    this.color,
    this.icon = '',
    this.textcolor,
    this.isFull = true,
    this.isLoading = false,
    this.isNewButton = false,
    this.padBot,
    this.borderColor,
    this.weight = FontWeightManager.semibold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFull ? double.infinity : null,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: padBot == null
              ? Platform.isIOS
                    ? 16.0
                    : 8.0
              : padBot ?? 0,
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPress,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: isLoading
                ? Theme.of(context).primaryColor.withValues(alpha: 0.4)
                : Theme.of(context).disabledColor,
            elevation: isNewButton ? 0 : 2,
            backgroundColor: color ?? context.colorScheme.tertiaryFixed,
            shape: RoundedRectangleBorder(
              side: isNewButton
                  ? BorderSide(
                      color: borderColor ?? context.colorScheme.primary,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: isLoading
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: isFull ? 16.0 : 0.0),
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(0.5),
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: isFull ? 18.0 : 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon == ''
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Image.asset(icon, scale: 3),
                            ),
                      CustomText(
                        text: text,
                        fontSize: fontSize(context, 0.0115),
                        weight: weight,
                        color:
                            textcolor ??
                            Theme.of(context).colorScheme.onPrimary,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final void Function() onTap;
  final String image;

  const CircleButton({super.key, required this.onTap, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWellWithDelay(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
          image: DecorationImage(image: AssetImage(image), scale: 2),
        ),
      ),
    );
  }
}
