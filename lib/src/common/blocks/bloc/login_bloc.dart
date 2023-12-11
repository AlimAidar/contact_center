import 'package:bloc/bloc.dart';
import 'package:contact_center/src/common/services/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthService authService,
  }) : super(LoginInitial()) {
    on<LoginPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        await authService.authorize(
          event.email,
          event.password,
        );

        emit(LoginLoaded());
      } on DioException {
        emit(
          LoginFailed(message: 'Неверные данные'),
        );
        rethrow;
      } catch (e) {
        emit(LoginFailed(message: 'UNKNOWN_ERROR'));

        rethrow;
      }
    });
  }
}
