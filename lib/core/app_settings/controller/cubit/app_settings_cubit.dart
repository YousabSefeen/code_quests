import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/app_settings/controller/states/app_settings_states.dart';
import 'package:flutter_task/core/enum/internet_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsStates> {
  AppSettingsCubit() : super(AppSettingsStates.initial());

  StreamSubscription<List<ConnectivityResult>>? _streamSubscription;

  Future<void> checkInternetConnection() async {
    // فحص أولي عند بداية التطبيق
    final result = await Connectivity().checkConnectivity();
    _handleResult(result);

    // الاشتراك في تغيّرات الاتصال
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen(_handleResult);
  }

  void _handleResult(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      emit(state.copyWith(internetState: InternetState.connected));
    } else {
      emit(state.copyWith(internetState: InternetState.disconnected));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
