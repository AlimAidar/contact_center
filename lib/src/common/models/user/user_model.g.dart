// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
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

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
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
