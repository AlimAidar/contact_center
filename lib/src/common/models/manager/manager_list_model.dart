// ignore_for_file: invalid_annotation_target

import 'package:contact_center/src/common/models/manager/manager_user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_list_model.freezed.dart';
part 'manager_list_model.g.dart';

@freezed
class ManagerListModel with _$ManagerListModel {
  factory ManagerListModel({
    @JsonKey(name: 'id_group') required int idGroup,
    required ManagerUserModel user,
  }) = _ManagerListModel;

  factory ManagerListModel.fromJson(Map<String, dynamic> json) =>
      _$ManagerListModelFromJson(json);
}
