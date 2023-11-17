import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/exceptions/exceptions.dart';
import 'package:flutter_weather_app/l10n/l10n.dart';
import 'package:flutter_weather_app/widgets/dialogs/custom_dialog.dart';
import 'package:flutter_weather_app/widgets/dialogs/loading_dialog.dart';
import 'package:flutter_weather_app/widgets/primary_button.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool _isShowingLoadingDialog = false;
  bool _isShowingDialog = false;

  void showLoadingDialog({String text = ''}) {
    if (_isShowingLoadingDialog) {
      return;
    }
    _isShowingLoadingDialog = true;
    unFocus();
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const LoadingDialog();
      },
    );
  }

  Future<dynamic> showConfirmDialog({
    required String message,
    String? title,
    Color? titleColor,
    String? okText,
    String? closeText,
    void Function()? onOkPressed,
    void Function()? onClosePressed,
    bool bearerDismissible = true,
  }) async {
    hideLoadingDialog();
    hideDialog();
    _isShowingDialog = true;
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: bearerDismissible,
      builder: (ctx) {
        return CustomDialog(
          CustomDialogType.confirm,
          title ?? ctx.l10n.confirm,
          message,
          titleColor: titleColor,
          okText: okText,
          closeText: closeText,
          okTextColor: Colors.white,
          onOkPressed: () {
            if (onOkPressed != null) {
              onOkPressed();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
          onClosePressed: () {
            if (onClosePressed != null) {
              onClosePressed();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
        );
      },
    );
    _isShowingDialog = false;
    return result;
  }

  Future<dynamic> showInformDialog({
    required String message,
    String? title,
    String? btnText,
    Function? onClosePressed,
    bool bearerDismissible = true,
  }) async {
    hideLoadingDialog();
    hideDialog();
    _isShowingDialog = true;
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: bearerDismissible,
      builder: (ctx) {
        return CustomDialog(
          CustomDialogType.inform,
          title ?? ctx.l10n.notice,
          message,
          closeText: btnText,
          onClosePressed: () {
            if (onClosePressed != null) {
              onClosePressed();
              Navigator.of(ctx, rootNavigator: true).pop();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
        );
      },
    );
    _isShowingDialog = false;
    return result;
  }

  void hideDialog() {
    unFocus();
    if (_isShowingDialog) {
      _isShowingDialog = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void hideLoadingDialog() {
    unFocus();
    if (_isShowingLoadingDialog) {
      _isShowingLoadingDialog = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Widget getLoadingWidget() {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.white,
      ),
    );
  }

  Widget getErrorWidget(
    dynamic exception, {
    String? unknownError,
    String? btnText,
    void Function()? onPressed,
  }) {
    final msg = getErrorMsg(
      exception,
      msg: unknownError,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Text(
              msg,
              style: AppTheme.titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          if (onPressed != null) ...[
            const SizedBox(height: AppConstants.defaultPadding),
            PrimaryButton(
              width: MediaQuery.of(context).size.width * 0.5,
              label: btnText ?? 'Try Again',
              onPressed: onPressed,
            ),
          ]
        ],
      ),
    );
  }

  void unFocus() {
    if (WidgetsBinding.instance.focusManager.primaryFocus?.hasFocus ?? false) {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    }
  }

  Future<dynamic> navigate(
    String name, {
    dynamic args,
    bool isReplace = false,
  }) async {
    if (isReplace) {
      return Navigator.pushReplacementNamed(
        context,
        name,
        arguments: args,
      );
    }
    return Navigator.pushNamed(
      context,
      name,
      arguments: args,
    );
  }

  Future<dynamic> pushAndRemoveUtil(
    String name,
    bool Function(Route<dynamic> route) predicate, {
    dynamic args,
  }) {
    Navigator.popUntil(context, predicate);
    return Navigator.pushReplacementNamed(
      context,
      name,
      arguments: args,
    );

    ///Navigator.pushAndRemoveUtil isn't working because this is a bug from flutter
    ///https://github.com/Flutterando/modular/issues/615
    // return Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   name,
    //   predicate,
    //   arguments: args,
    // );
  }

  void popUntil(bool Function(Route<dynamic> route) predicate) {
    Navigator.popUntil(context, predicate);
  }

  /// get error message from exception
  /// example:
  /// if(state is LoginFailed) {
  ///   String msg = getErrorMsg(state.ex);
  /// }
  String getErrorMsg(dynamic ex, {String? msg}) {
    if (ex is ServerException) {
      var err = ex.error?.toString() ?? '';
      if (err.isEmpty) {
        err = context.l10n.anErrorOccurred;
      }
      return err;
    }
    if (ex is ManuallyException) {
      return ex.message;
    }
    if (ex is ConnectionException) {
      return ex.message;
    }
    if (ex is Error) {
      return context.l10n.anErrorOccurred;
    }
    return msg ?? context.l10n.anErrorOccurred;
  }

  void showSnackBar(String message,
      {SnackBarType type = SnackBarType.success}) {
    Flushbar<dynamic>(
      messageText: Text(
        message,
        style: AppTheme.bodyTextStyle,
      ),
      icon: const Icon(
        Icons.info_outlined,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppConstants.defaultPadding / 2)
          .copyWith(top: kToolbarHeight),
      borderRadius: BorderRadius.circular(AppConstants.defaultPadding),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: type.snackBarColor,
      boxShadows: const [
        BoxShadow(
          color: Colors.black54,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      isDismissible: true,
    ).show(context);
  }
}

enum SnackBarType {
  success,
  failure,
  warning,
}

extension SnackBarTypeEx on SnackBarType {
  Color get snackBarColor {
    switch (this) {
      case SnackBarType.success:
        return AppColors.eucalyptus;
      case SnackBarType.failure:
        return AppColors.violetRed;
      case SnackBarType.warning:
        return AppColors.violetRed;
    }
  }
}
