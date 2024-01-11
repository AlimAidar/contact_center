// ignore_for_file: invalid_annotation_target, depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_token.freezed.dart';
part 'manager_token.g.dart';

@freezed
class ManagerTokenModel with _$ManagerTokenModel {
  factory ManagerTokenModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _ManagerTokenModel;

  factory ManagerTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ManagerTokenModelFromJson(json);
}
