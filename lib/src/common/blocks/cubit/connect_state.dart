part of 'connect_cubit.dart';

@immutable
sealed class ConnectState {}

final class ConnectInitial extends ConnectState {}

final class ConnectLoading extends ConnectState {}

final class ConnectLoaded extends ConnectState {}

final class ConnectFailed extends ConnectState {}
