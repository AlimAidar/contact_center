// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.service}) : super(AuthInitial());

  final AuthService service;

  authFunc(String login, String password,) async {
    emit(AuthLoading());
    try {
      await service.authorize(login, password);
      emit(AuthLoaded());
    } on DioException catch (e) {
      emit(
        AuthFailed(
          message: e.response != null ? e.response?.data : 'UNKNOWN_ERROR',
        ),
      );
    }
  }
}
