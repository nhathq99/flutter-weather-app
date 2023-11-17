import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    this.title = '',
    this.isShowBackButton = true,
    this.isWrapHeight = false,
    this.onBackPressed,
    this.child,
    this.actionButton,
  });

  final String title;
  final bool isShowBackButton;
  final bool isWrapHeight;
  final void Function()? onBackPressed;
  final Widget? child;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppConstants.defaultPadding),
        topRight: Radius.circular(AppConstants.defaultPadding),
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ColoredBox(
          color: Colors.white.withOpacity(0.2),
          child: _buildContent(isWrapHeight),
        ),
      ),
    );
  }

  Widget _buildContent(bool isWrapHeight) {
    if (isWrapHeight) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          // _buildDivider(),
          child ?? Container(),
        ],
      );
    }
    return Column(
      children: [
        _buildHeader(),
        // _buildDivider(),
        Expanded(child: child ?? Container()),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildBackBtn(),
          ),
          Align(
            child: _buildTitle(title),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: actionButton ?? Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackBtn() {
    if (isShowBackButton) {
      return Builder(
        builder: (ctx) {
          return IconButton(
            onPressed: onBackPressed ?? () => Navigator.pop(ctx),
            icon: const Icon(Icons.arrow_back_ios_new),
          );
        },
      );
    }
    return Container();
  }

  Widget _buildTitle(String title) {
    return Builder(
      builder: (ctx) {
        return Text(
          title,
          style: AppTheme.headerTextStyle,
        );
      },
    );
  }

  // Widget _buildDivider() {
  //   return Builder(builder: (ctx) {
  //     return Container(
  //       height: 1,
  //       width: MediaQuery.of(ctx).size.width,
  //       color: AppColors.dark2,
  //     );
  //   });
  // }

  static Future<dynamic> show({
    required BuildContext context,
    required Widget child,
    String title = '',
    double heightRatio = 0.5,
    bool isShowBackButton = true,
    bool isWrapHeight = false,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool enableDrag = true,
    void Function()? onBackPressed,
    Widget? actionButton,
  }) {
    final content = CustomBottomSheet(
      title: title,
      isShowBackButton: isShowBackButton,
      isWrapHeight: isWrapHeight,
      onBackPressed: onBackPressed,
      actionButton: actionButton ?? Container(),
      child: child,
    );
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      enableDrag: enableDrag,
      context: context,
      builder: (ctx) {
        if (isWrapHeight) {
          return Wrap(
            children: [
              content,
            ],
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * heightRatio,
          child: content,
        );
      },
    );
  }
}
