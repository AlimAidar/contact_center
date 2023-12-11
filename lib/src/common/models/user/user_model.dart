// ignore_for_file: invalid_annotation_target, depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {

  factory UserModel(
    int? id,
    String? login,  
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'id_role') int? idRole,
    String? username,
    String? position,
    String? phone,
    String? email,

  ) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}