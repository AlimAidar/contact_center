// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/update_id/update_id_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'update_id_state.dart';

class UpdateIdCubit extends Cubit<UpdateIdState> {
  UpdateIdCubit({required this.service}) : super(UpdateIdInitial());

  final UpdateIdService service;

  updateSocket(String idSocket, String idRoom) async {
    emit(UpdateIdLoading());
    try {
      await service.updateId(idSocket, idRoom);
      emit(UpdateIdLoaded());
    } on DioException catch (e) {
      emit(UpdateIdFailed(
          message: e.response != null ? e.response?.data : 'UNKNOWN_ERROR'));
    }
  }
}
