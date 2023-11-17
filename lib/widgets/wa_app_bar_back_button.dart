import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/widgets/wa_back_button.dart';

class WaAppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  const WaAppBarWithBackButton({
    super.key,
    this.label = '',
    this.bgColor,
    this.onBackPressed,
    this.isShowBackButton = true,
    this.isCenterTitle = true,
    this.height,
    this.trailing,
  });

  final double? height;
  final String label;
  final Color? bgColor;
  final void Function()? onBackPressed;
  final bool isShowBackButton;
  final bool isCenterTitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.transparent,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: isShowBackButton
                ? WaBackButton(
                    onPressed: onBackPressed,
                  )
                : const SizedBox(),
          ),
          if (trailing != null)
            Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          Align(
            alignment: isCenterTitle ? Alignment.centerLeft : Alignment.center,
            child: Padding(
              padding: isCenterTitle
                  ? const EdgeInsets.only(left: 12)
                  : EdgeInsets.zero,
              child: Text(
                label,
                style: AppTheme.headerTextStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
