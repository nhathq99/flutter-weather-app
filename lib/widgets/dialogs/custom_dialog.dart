import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/l10n/l10n.dart';

enum CustomDialogType {
  confirm,
  inform,
}

class CustomDialog extends StatelessWidget {
  const CustomDialog(
    this.type,
    this.title,
    this.message, {
    Key? key,
    this.okText,
    this.closeText,
    this.okBgColor,
    this.okTextColor,
    this.closeBgColor,
    this.closeTextColor,
    this.titleColor,
    this.onOkPressed,
    this.onClosePressed,
  }) : super(key: key);

  final CustomDialogType type;
  final String title;
  final String message;
  final String? okText;
  final String? closeText;
  final Color? okBgColor;
  final Color? closeBgColor;
  final Color? okTextColor;
  final Color? closeTextColor;
  final Color? titleColor;
  final void Function()? onOkPressed;
  final void Function()? onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBody(),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            _buildButtonSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTheme.titleTextStyle.copyWith(color: titleColor),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: AppTheme.bodyTextStyle.copyWith(height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Widget _buildButtonSection(BuildContext context) {
    if (type == CustomDialogType.inform) {
      return Row(
        children: [
          Expanded(
            child: _buildButton(
              closeText ?? context.l10n.close,
              closeBgColor,
              closeTextColor,
              onClosePressed,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            okText ?? context.l10n.yes,
            okBgColor,
            okTextColor,
            onOkPressed,
          ),
        ),
        Container(
          height: 32,
          width: 1,
          color: AppColors.silver,
        ),
        Expanded(
          child: _buildButton(
            closeText ?? 'Close',
            closeBgColor,
            closeTextColor,
            onClosePressed,
          ),
        )
      ],
    );
  }

  Widget _buildButton(String? text, Color? bgColor, Color? textColor,
      void Function()? onPressed) {
    return Builder(builder: (context) {
      return Material(
        color: bgColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: AppTheme.buttonTextStyle.copyWith(
                color: textColor,
              ),
            ),
          ),
          onTap: () {
            if (onPressed != null) {
              onPressed();
              return;
            }
          },
        ),
      );
    });
  }
}
