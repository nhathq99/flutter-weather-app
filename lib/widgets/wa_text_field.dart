import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';

class WaTextField extends StatelessWidget {
  const WaTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.suffix,
    this.prefix,
    this.focusNode,
    this.obscureText = false,
    this.inputFormatters,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.autoFocus = false,
    this.textInputType,
    this.textInputAction,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      obscureText: obscureText,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: AppColors.melrose,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.defaultPadding,
            ),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.defaultPadding,
            ),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding / 2,
          horizontal: AppConstants.defaultPadding / 2,
        ),
        label: label?.isNotEmpty ?? false ? Text(label ?? '') : null,
        labelStyle:
            AppTheme.titleTextStyle.copyWith(color: AppColors.mineShaft),
        hintText: hint ?? '',
        hintStyle: AppTheme.titleTextStyle.copyWith(color: AppColors.mineShaft),
        floatingLabelStyle:
            AppTheme.titleTextStyle.copyWith(color: AppColors.primaryColor),
        suffixIcon: suffix,
        prefixIcon: prefix,
      ),
      controller: controller,
      focusNode: focusNode,
    );
  }
}
