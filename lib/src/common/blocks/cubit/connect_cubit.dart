// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/start_connect/connect_service.dart';
import 'package:meta/meta.dart';

part 'connect_state.dart';

class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit({required this.service}) : super(ConnectInitial());
  final ConnectService service;

  connect(String number, String idRoom) async {
    emit(ConnectLoading());
    try {
      await service.connect(number, idRoom);
      emit(ConnectLoaded());
    } catch (e) {
      emit(ConnectFailed());
    }
  }
}
