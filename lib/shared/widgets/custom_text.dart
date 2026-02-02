import 'package:flutter/material.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/core/extensions/responsive_extension.dart';
import 'package:ptac_invoice/shared/widgets/extracted_dialogs.dart';
// import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double hpadding;
  final double vpadding;
  final double height;
  final double? fontSize;
  final FontWeight? weight;
  final Color? color;
  final String? family;
  final TextAlign textAlign;
  final int? maxLine;
  final TextDecoration decoration;
  final TextOverflow textOverflow;
  final double? letterSpacing;
  final TextStyle? style;

  const CustomText({
    super.key,
    this.maxLine,
    this.height = 0,
    this.style,
    required this.text,
    this.fontSize,
    this.hpadding = 0,
    this.vpadding = 0,
    this.decoration = TextDecoration.none,
    this.weight = FontWeight.w400,
    this.color,
    this.family = 'SFpro',
    this.letterSpacing = 0.8,
    this.textOverflow = TextOverflow.visible,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        style ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: family,
          fontSize: fontSize,
          fontWeight: weight,
          decoration: decoration,
          letterSpacing: letterSpacing,
          height: height,
          color: color ?? Theme.of(context).colorScheme.onSurface,
        );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hpadding, vertical: vpadding),
      child: Text(
        text ?? '',
        style: baseStyle,
        maxLines: maxLine,
        textAlign: textAlign,
      ),
    );
  }
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
}

class NoData extends StatelessWidget {
  final String title;
  final bool isDef;
  final Color? color;

  const NoData({
    this.title = 'No Data',
    this.isDef = true,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          const Icon(Icons.error, color: Colors.red),
          SizedBox(height: 1.v),
          CustomText(
            text: title,
            color: color ?? Theme.of(context).primaryColorLight,
            fontSize: 12.dp,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

// Helper function to create TextSpan with common styles
TextSpan buildTextSpan(
  String text,
  Color color, {
  bool underline = false,
  fontsize,
}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontSize: fontsize ?? 11.dp,
      fontFamily: 'SFpro',
      height: 1.3,
      color: color,
      decoration: underline ? TextDecoration.underline : null,
    ),
  );
}

//big heading

CustomText bigHeading({
  required String text,
  required BuildContext context,
  FontWeight? weight,
  TextAlign? align,
}) {
  return CustomText(
    text: text,
    fontSize: fontSize(context, 0.017),
    weight: weight ?? FontWeightManager.semibold,
    textAlign: align ?? TextAlign.center,
  );
}

CustomText semiHeading({
  required String text,
  required BuildContext context,
  FontWeight? weight,
  TextAlign? align,
}) {
  return CustomText(
    text: text,
    fontSize: fontSize(context, 0.014),
    weight: weight ?? FontWeightManager.semibold,
    textAlign: align ?? TextAlign.center,
  );
}

//body
CustomText bodyText({
  required String text,
  required BuildContext context,
  TextAlign align = TextAlign.center,
  FontWeight? weight,
}) {
  return CustomText(
    text: text,
    fontSize: fontSize(context, 0.0125),
    color: context.colorScheme.onSurfaceVariant,
    textAlign: align,
    weight: weight,
  );
}

//small text

CustomText smallBodyText({
  required String text,
  TextAlign align = TextAlign.center,
  required BuildContext context,
  double height = 1.5,
  Color? color,
}) {
  return CustomText(
    text: text,
    fontSize: fontSize(context, 0.011),
    color: color ?? context.colorScheme.onSurfaceVariant,
    textAlign: align,
    height: height,
    maxLine: 2,
  );
}
