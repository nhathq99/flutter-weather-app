import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:flutter_weather_app/l10n/l10n.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/app_theme.dart';
import 'package:flutter_weather_app/models/weather_data.dart';
import 'package:flutter_weather_app/modules/weather_detail/view/detail_info_item.dart';
import 'package:flutter_weather_app/modules/weather_detail/view/three_hours_forecast_item.dart';
import 'package:flutter_weather_app/route_args/weather_detail_args.dart';
import 'package:flutter_weather_app/utils/date_format_util.dart';
import 'package:flutter_weather_app/utils/image_util.dart';

class WeatherDetailPage extends StatefulWidget {
  const WeatherDetailPage({
    super.key,
  });

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  late WeatherData data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)?.settings.arguments as WeatherDetailArgs?;
    if (args != null) {
      data = args.data;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              AppConstants.defaultPadding,
            ),
            child: Column(
              children: [
                _buildDetailInfoGrid(),
                const SizedBox(
                  height: AppConstants.defaultPadding,
                ),
                _buildForecastEvery3Hours(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.melrose,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(
              AppConstants.defaultPadding * 1.5,
            ),
            right: Radius.circular(
              AppConstants.defaultPadding * 1.5,
            ),
          )),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            children: [
              IconButton(
                onPressed: _onBackPressed,
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: ImageUtil.loadNetWorkImage(
                  url: data.current.weather[0].fullIconUrl,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Text(
                      data.current.name,
                      style: AppTheme.bodyTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${data.current.main.temp.toInt()}${data.unit.symbol}',
                          style: AppTheme.bodyTextStyle.copyWith(
                            fontSize: 46,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: AppConstants.defaultPadding / 2,
                        ),
                        Column(
                          children: [
                            Text(
                              'H:${data.hightTemp}${data.unit.symbol}',
                            ),
                            Text(
                              'L:${data.lowTemp}${data.unit.symbol}',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      toBeginningOfSentenceCase(
                            data.current.weather[0].description,
                          ) ??
                          '',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Feels like ${data.current.main.feelsLike.toInt()}${data.unit.symbol}',
                  ),
                ),
                Expanded(
                  child: Text(
                    DateFormatUtil.ddMMyyyyHHmmFormat(
                          DateTime.fromMillisecondsSinceEpoch(
                            data.current.dt * 1000,
                          ),
                        ) ??
                        '',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppConstants.defaultPadding,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInfoGrid() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            DetailInfoItem(
                title: context.l10n.wind,
                value: '${data.current.wind.speed}${data.unit.speedUnit}'),
            const SizedBox(
              width: AppConstants.defaultPadding,
            ),
            DetailInfoItem(
              title: context.l10n.pressure,
              value: '${data.current.main.pressure}hPa',
            ),
          ],
        ),
        const SizedBox(
          height: AppConstants.defaultPadding,
        ),
        Row(
          children: [
            DetailInfoItem(
              title: context.l10n.visibility,
              value: '${data.current.visibility / 1000}km',
            ),
            const SizedBox(
              width: AppConstants.defaultPadding,
            ),
            DetailInfoItem(
              title: context.l10n.humidity,
              value: '${data.current.main.humidity}%',
            ),
          ],
        ),
        const SizedBox(
          height: AppConstants.defaultPadding,
        ),
        Row(
          children: [
            DetailInfoItem(
              title: context.l10n.sunrise,
              value: DateFormatUtil.hhmmFormat(
                    DateTime.fromMillisecondsSinceEpoch(
                      data.current.sys.sunrise * 1000,
                    ),
                  ) ??
                  '',
            ),
            const SizedBox(
              width: AppConstants.defaultPadding,
            ),
            DetailInfoItem(
              title: context.l10n.sunset,
              value: DateFormatUtil.hhmmFormat(
                    DateTime.fromMillisecondsSinceEpoch(
                      data.current.sys.sunset * 1000,
                    ),
                  ) ??
                  '',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForecastEvery3Hours() {
    return Container(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.defaultPadding,
        ),
        color: AppColors.melrose,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.everyThreeHoursForecast),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.list.length,
            itemBuilder: (context, index) {
              return ThreeHoursForecastItem(
                forecast: data.list[index],
                unit: data.unit,
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: AppConstants.defaultPadding,
              );
            },
          ),
        ],
      ),
    );
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }
}
