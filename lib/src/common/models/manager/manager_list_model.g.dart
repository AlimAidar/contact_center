// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagerListModelImpl _$$ManagerListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ManagerListModelImpl(
      idGroup: json['id_group'] as int,
      user: ManagerUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ManagerListModelImplToJson(
        _$ManagerListModelImpl instance) =>
    <String, dynamic>{
      'id_group': instance.idGroup,
      'user': instance.user,
    };
