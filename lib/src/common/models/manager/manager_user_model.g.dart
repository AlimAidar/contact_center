// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagerUserModelImpl _$$ManagerUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ManagerUserModelImpl(
      username: json['username'] as String?,
      photo: json['photo'] as String?,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$$ManagerUserModelImplToJson(
        _$ManagerUserModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'photo': instance.photo,
      'verified': instance.verified,
    };
