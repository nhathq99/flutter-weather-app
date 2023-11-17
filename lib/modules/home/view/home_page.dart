import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/di/injection.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_weather_app/base/base_state.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/l10n/l10n.dart';
import 'package:flutter_weather_app/models/models.dart';
import 'package:flutter_weather_app/modules/home/home.dart';
import 'package:flutter_weather_app/modules/home/view/weather_skeleton_item.dart';
import 'package:flutter_weather_app/repositories/repositories.dart';
import 'package:flutter_weather_app/route_args/weather_detail_args.dart';
import 'package:flutter_weather_app/utils/routes.dart';
import 'package:flutter_weather_app/widgets/sheets/data_list_sheet.dart';
import 'package:flutter_weather_app/widgets/wa_app_bar_back_button.dart';
import 'package:flutter_weather_app/widgets/wa_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => injector.get<HomeCubit>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  final _searchController = TextEditingController();
  final _searchNotifier = ValueNotifier('');

  @override
  void initState() {
    context.read<HomeCubit>().initialData();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WaAppBarWithBackButton(
        label: context.l10n.weather,
        isShowBackButton: false,
        trailing: IconButton(
          icon: const Icon(Icons.pending),
          iconSize: 28,
          onPressed: _onMorePressed,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status == DataStatus.loading) {
              showLoadingDialog();
              return;
            }
            hideLoadingDialog();
            if (state.status == DataStatus.failurePopup) {
              showSnackBar(
                getErrorMsg(state.error),
                type: SnackBarType.failure,
              );
            }
            if (state.status == DataStatus.success) {
              _searchController.text = '';
              _searchNotifier.value = '';
            }
          },
          builder: (context, state) {
            if (state.status == DataStatus.failure) {
              return getErrorWidget(
                state.error,
                onPressed: () => context.read<HomeCubit>().initialData(
                      isRefresh: true,
                    ),
              );
            }
            return Skeletonizer(
              enabled: state.status == DataStatus.initial,
              child: _buildBody(state.list, state.status == DataStatus.initial),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(List<WeatherData> data, bool showSkeleton) {
    return Column(
      children: [
        const SizedBox(height: AppConstants.defaultPadding),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: WaTextField(
            controller: _searchController,
            hint: context.l10n.search,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (val) {
              if (val == null) return;
              context.read<HomeCubit>().onSubmitted(val);
            },
            onChanged: (s) {
              _searchNotifier.value = s;
            },
            prefix: const Icon(Icons.search),
            suffix: ValueListenableBuilder<String>(
              valueListenable: _searchNotifier,
              builder: (context, s, child) {
                if (s.isEmpty) {
                  return const SizedBox();
                }
                return IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: _onClearPressed,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Expanded(
          child: _buildContent(data, showSkeleton),
        ),
      ],
    );
  }

  Widget _buildContent(List<WeatherData> data, bool showSkeleton) {
    if (!showSkeleton && data.isEmpty) {
      return Center(
        child: Text(context.l10n.nothingToShow),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        if (showSkeleton) return;
        return context.read<HomeCubit>().initialData();
      },
      child: ListView.separated(
        padding:
            const EdgeInsets.all(AppConstants.defaultPadding).copyWith(top: 0),
        // shrinkWrap: true,
        itemCount: showSkeleton ? 10 : data.length,
        itemBuilder: (context, index) {
          if (showSkeleton) return const WeatherSkeletonItem();
          return WeatherItem(
            data: data[index],
            onPressed: (data) {
              final args = WeatherDetailArgs(data: data);
              navigate(Routes.weatherDetailPage, args: args);
            },
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: AppConstants.defaultPadding,
          );
        },
      ),
    );
  }

  void _onClearPressed() {
    if (_searchController.text.isNotEmpty) {
      _searchController.text = '';
      _searchNotifier.value = '';
    }
  }

  void _onMorePressed() {
    final data = TempUnit.tempUnits.map((e) => e.name).toList();
    DataListSheet(
      context: context,
      data: data,
      title: context.l10n.temperatureUnit,
      isUseSelectedIcon: true,
      selectedIndex: context.read<HomeCubit>().state.selectedUnit,
      onItemPressed: context.read<HomeCubit>().onChangeUnit,
    ).show();
  }
}
