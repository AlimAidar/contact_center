import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_user_model.freezed.dart';
part 'manager_user_model.g.dart';

@freezed
class ManagerUserModel with _$ManagerUserModel {

  factory ManagerUserModel({
 String? username,
 String? photo,
required bool verified,
  }) = _ManagerUserModel;

  factory ManagerUserModel.fromJson(Map<String, dynamic> json) => _$ManagerUserModelFromJson(json);
}

