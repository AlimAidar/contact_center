part of 'update_id_cubit.dart';

@immutable
sealed class UpdateIdState {}

final class UpdateIdInitial extends UpdateIdState {}

final class UpdateIdLoading extends UpdateIdState {}

final class UpdateIdLoaded extends UpdateIdState {}

final class UpdateIdFailed extends UpdateIdState {}
