// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      json['id'] as int?,
      json['login'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['id_role'] as int?,
      json['username'] as String?,
      json['position'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id_role': instance.idRole,
      'username': instance.username,
      'position': instance.position,
      'phone': instance.phone,
      'email': instance.email,
    };
