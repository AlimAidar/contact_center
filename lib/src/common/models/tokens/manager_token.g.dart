// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagerTokenModelImpl _$$ManagerTokenModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ManagerTokenModelImpl(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
    );

Map<String, dynamic> _$$ManagerTokenModelImplToJson(
        _$ManagerTokenModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
