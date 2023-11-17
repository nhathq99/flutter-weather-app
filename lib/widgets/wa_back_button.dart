import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/assets_path.dart';
import 'package:flutter_weather_app/utils/image_util.dart';

class WaBackButton extends StatelessWidget {
  const WaBackButton({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: IconButton(
        icon: ImageUtil.loadAssetsImage(
          assetPath: AssetsPath.icBackCircle,
        ),
        onPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }
}
