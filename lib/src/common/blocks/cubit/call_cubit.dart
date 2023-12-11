// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/call/call_service.dart';
import 'package:meta/meta.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit({required this.service}) : super(CallInitial());

  final CallService service;

  startCall(String number,String idSocket) async {
    emit(CallLoading());
    try {
      await service.postNumber(number,idSocket);
      emit(CallLoaded());
    } catch (e) {
      emit(CallFailed());
    }
  }
}
