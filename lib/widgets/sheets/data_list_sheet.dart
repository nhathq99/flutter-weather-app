import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/widgets/sheets/bottom_sheet.dart';

class DataListSheet {
  DataListSheet({
    required this.context,
    required this.data,
    this.title = '',
    this.titleColor,
    this.selectedIndex = 0,
    this.isUseSelectedIcon = false,
    this.isCloseSheetWhenItemPressed = true,
    this.onItemPressed,
  });
  BuildContext context;
  String title;
  Color? titleColor;
  List<String> data;
  int selectedIndex;
  bool isUseSelectedIcon;
  bool isCloseSheetWhenItemPressed;
  void Function(int)? onItemPressed;

  Widget _buildBody() {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.80 * (context.size?.width ?? 1)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                return _buildItem(
                  index: index,
                  dataText: data[index],
                  isShowSelectedIcon:
                      isUseSelectedIcon && selectedIndex == index,
                  onItemPressed: _onItemPressed,
                );
              },
              separatorBuilder: (ctx, index) {
                return Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.dark2,
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    int index = 0,
    String dataText = '',
    bool isShowSelectedIcon = false,
    void Function(int)? onItemPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onItemPressed != null ? () => onItemPressed(index) : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  dataText,
                  style: AppTheme.bodyTextStyle.copyWith(color: titleColor),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Icon(
                isShowSelectedIcon
                    ? Icons.check_circle
                    : Icons.chevron_right_rounded,
                color: AppColors.mineShaft,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemPressed(int index) {
    onItemPressed?.call(index);
    if (isCloseSheetWhenItemPressed) {
      Navigator.pop(context);
    }
  }

  void show() {
    CustomBottomSheet.show(
      context: context,
      title: title,
      isWrapHeight: true,
      isScrollControlled: true,
      child: _buildBody(),
    );
  }
}
