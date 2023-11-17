import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.onPressed,
    this.icon,
    this.style,
    this.direction = TextDirection.rtl,
    this.isLoading = false,
  }) : super(key: key);

  final String label;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final void Function()? onPressed;
  final Widget? icon;
  final TextDirection direction;
  final bool isLoading;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final labelStyle = ElevatedButton.styleFrom(
      backgroundColor: color ?? AppColors.accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
    return SizedBox(
      height: height ?? 45,
      width: width,
      child: Directionality(
        textDirection: direction,
        child: ElevatedButton.icon(
          style: style ?? labelStyle,
          label: _buildContent(),
          onPressed: isLoading ? () {} : onPressed,
          icon: (isLoading || icon == null) ? Container() : icon!,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: (height ?? 45) / 1.8,
        height: (height ?? 45) / 1.8,
        child: const CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 2,
        ),
      );
    }
    return Text(
      label,
      style: AppTheme.buttonTextStyle.copyWith(
        color: textColor ?? Colors.black,
      ),
    );
  }
}
