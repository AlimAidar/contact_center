// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/call/call_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit({required this.service}) : super(CallInitial());

  final CallService service;

  startCall(String number, String idRoom, String name) async {
    emit(CallLoading());
    try {
      await service.postNumber(number, idRoom, name);
      emit(CallLoaded());
    } on DioException catch (e) {
      emit(
        CallFailed(
          message: e.response != null ? e.response?.data : 'UNKNOWN_ERROR',
        ),
      );
    }
  }
}
