import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptac_invoice/core/constants/image_constants.dart';
import 'package:ptac_invoice/core/extensions/base_extension.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/core/theme/color_schemes.dart';
import 'package:ptac_invoice/core/utils/custom_input_formatter.dart';

class CustomTextField extends StatefulWidget {
  final bool autoFocus;
  final bool showCount;
  final void Function(String value)? onSubmit;
  final VoidCallback? onPress;
  final int maxLines;
  final bool suffixIconEnabled;
  final Color? floatingLabelColor;
  final bool isLabel;
  final bool readOnly;
  final TextAlign textAlign;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLength;
  final bool isPass;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? icon;
  final String? Function(String? value)? validator;
  final bool enabled;
  final void Function(String value)? onchange;
  final Color? focusedColor;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final bool isFloating;
  final TextCapitalization textCap;
  final FocusNode? focusNode;
  final void Function(PointerDownEvent event)? onFocusChange;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.autoFocus = false,
    this.showCount = false,
    this.onSubmit,
    this.onPress,
    this.maxLines = 1,
    this.suffixIconEnabled = true,
    this.floatingLabelColor,
    this.isLabel = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength = 1000,
    this.isPass = false,
    this.contentPadding,
    this.icon,
    this.validator,
    this.enabled = true,
    this.onchange,
    this.focusedColor,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.isFloating = false,
    this.textCap = TextCapitalization.none,
    this.focusNode,
    this.onFocusChange,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      key: widget.key,
      onTap: widget.onPress,

      maxLines: widget.maxLines,
      onTapOutside:
          widget.onFocusChange ??
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
      textCapitalization: widget.textCap,
      // textAlignVertical: TextAlignVertical.top,
      readOnly: widget.readOnly,
      onFieldSubmitted: widget.onSubmit,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      //
      textAlign: widget.textAlign,
      cursorColor: Theme.of(context).primaryColor,
      onChanged: widget.onchange,
      focusNode: widget.focusNode,
      style: TextStyle(
        color: theme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
      ),
      obscureText: widget.isPass ? isHidden : false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      validator: widget.validator,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        floatingLabelBehavior: widget.isFloating
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        suffixIcon: widget.suffixIconEnabled
            ? widget.isPass
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Image.asset(
                        isHidden
                            ? ImageConstants.eyeClose
                            : ImageConstants.eyeOpen,
                        color: theme.onSurfaceVariant,
                        scale: 2.5,
                      ),
                    )
                  : widget.icon
            : null,
        counterText: widget.showCount ? null : '',
        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return TextStyle(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontFamily: 'SFpro',
              fontSize: 14.0,
            );
          }
          return TextStyle(
            color: context.colorScheme.outline,
            fontFamily: 'SFpro',
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          );
        }),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.outline),
        ),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return TextStyle(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontFamily: 'SFpro',
              fontSize: 14.0,
            );
          }
          return TextStyle(
            color: context.colorScheme.outline,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFpro',
            fontSize: 14.0,
          );
        }),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: widget.readOnly == true ? 1 : 2,
            color: widget.focusedColor ?? Theme.of(context).primaryColor,
          ),
        ),
        hintText: widget.isLabel ? null : widget.hintText,
        hintStyle: TextStyle(
          color: theme.outline,
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
        ),
        border: const OutlineInputBorder(),
        labelText: widget.isLabel ? widget.hintText : null,
        errorMaxLines: 2,
        contentPadding:
            widget.contentPadding ??
            (widget.suffixIconEnabled
                ? const EdgeInsets.only(right: 0, left: 16)
                : const EdgeInsets.only(right: 15, left: 0)),
      ),
    );
  }
}

class CustomTextFieldSuffix extends StatefulWidget {
  final bool autoFocus;
  final void Function(String value)? onSubmit;
  final VoidCallback? onPress;
  final Color? floatingLabelColor;
  final bool isLabel;
  final bool readOnly;
  final TextAlign textAlign;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLength;
  final Widget? icon;
  final bool isPass;
  final bool enabled;
  final void Function(String value)? onchange;
  final Color? focusedColor;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isFloating;
  final String? Function(String? value)? validator;

  const CustomTextFieldSuffix({
    super.key,
    this.autoFocus = false,
    this.onSubmit,
    this.onPress,
    this.floatingLabelColor,
    this.isLabel = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength = 1000,
    this.isPass = false,
    this.icon,
    this.validator,
    this.enabled = true,
    this.onchange,
    this.focusedColor,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.isFloating = false,
  });

  @override
  State<CustomTextFieldSuffix> createState() => _CustomTextFieldSuffixState();
}

class _CustomTextFieldSuffixState extends State<CustomTextFieldSuffix> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onPress,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      readOnly: widget.readOnly,
      onFieldSubmitted: widget.onSubmit,
      autofocus: widget.autoFocus,
      textAlign: widget.textAlign,
      cursorColor: Theme.of(context).primaryColor,
      onChanged: widget.onchange,
      style: const TextStyle(
        color: kDarkSurfaceColor,
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
      ),
      obscureText: widget.isPass ? (isHidden ? true : false) : false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      validator: widget.validator,
      enabled: widget.enabled,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: widget.isFloating
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        // suffixIcon: widget.icon,
        counterText: '',
        labelStyle: const TextStyle(
          color: kLightSurfaceColor,
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
        ),
        // disabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: kLightSurfaceColor)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightSurfaceColor.withValues(alpha: 0.4),
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: widget.floatingLabelColor ?? Theme.of(context).primaryColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: widget.readOnly == true ? 1 : 2,
            color: widget.focusedColor ?? Theme.of(context).primaryColor,
          ),
        ),
        hintText: widget.isLabel ? null : widget.hintText,
        hintStyle: const TextStyle(
          color: kLightSurfaceColor,
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
        ),
        border: const OutlineInputBorder(),
        labelText: widget.isLabel ? widget.hintText : null,
        // contentPadding: widget.suffixIconEnabled
        //     ? EdgeInsets.only(right: 0, left: 16)
        //     : EdgeInsets.only(right: 15, left: 0),
      ),
    );
  }
}

class CustomAmountTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final bool? isPass;
  final void Function(String value)? onchange;
  final bool? suffixIconEnabled;
  final TextAlign? textAlign;
  final String? Function(String? value)? validator;
  final Widget? icon;
  final bool? isFloating;
  final bool? readOnly;
  final VoidCallback? onPress;
  final Color? floatingLabelColor;
  final bool? enabled;
  final Color? focusedColor;
  final bool? isLabel;
  final bool? autoFocus;
  final void Function(String? value)? onSubmit;
  final bool? showCount;
  final Widget? prefixIcon;
  final int? maxLines;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCap;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(PointerDownEvent event)? onFocusChange;

  const CustomAmountTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.isPass,
    this.onchange,
    this.suffixIconEnabled,
    this.textAlign,
    this.validator,
    this.icon,
    this.isFloating,
    this.readOnly,
    this.onPress,
    this.floatingLabelColor,
    this.enabled,
    this.focusedColor,
    this.isLabel,
    this.autoFocus,
    this.onSubmit,
    this.showCount,
    this.prefixIcon,
    this.maxLines,
    this.focusNode,
    this.inputFormatters,
    this.textCap,
    this.contentPadding,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText ?? '',
      controller: controller,
      validator: validator,
      maxLength: maxLength ?? 10,
      keyboardType:
          keyboardType ?? const TextInputType.numberWithOptions(decimal: true),
      inputFormatters:
          inputFormatters ?? <TextInputFormatter>[DecimalInputFormatter()],
      onchange: onchange,

      onFocusChange: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
        controller?.text = controller?.text.toFormattedPriceAmount() ?? '';
        onFocusChange?.call(event);
      },
    );
  }
}
