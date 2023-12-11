part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginFailed extends LoginState {
  LoginFailed({
    required this.message,
  });
  final String message;
}
