part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginPressed extends LoginEvent {
  LoginPressed({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
