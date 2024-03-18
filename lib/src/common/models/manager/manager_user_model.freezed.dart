// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manager_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ManagerUserModel _$ManagerUserModelFromJson(Map<String, dynamic> json) {
  return _ManagerUserModel.fromJson(json);
}

/// @nodoc
mixin _$ManagerUserModel {
  String? get username => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ManagerUserModelCopyWith<ManagerUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagerUserModelCopyWith<$Res> {
  factory $ManagerUserModelCopyWith(
          ManagerUserModel value, $Res Function(ManagerUserModel) then) =
      _$ManagerUserModelCopyWithImpl<$Res, ManagerUserModel>;
  @useResult
  $Res call({String? username, String? photo, bool verified});
}

/// @nodoc
class _$ManagerUserModelCopyWithImpl<$Res, $Val extends ManagerUserModel>
    implements $ManagerUserModelCopyWith<$Res> {
  _$ManagerUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? photo = freezed,
    Object? verified = null,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManagerUserModelImplCopyWith<$Res>
    implements $ManagerUserModelCopyWith<$Res> {
  factory _$$ManagerUserModelImplCopyWith(_$ManagerUserModelImpl value,
          $Res Function(_$ManagerUserModelImpl) then) =
      __$$ManagerUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? username, String? photo, bool verified});
}

/// @nodoc
class __$$ManagerUserModelImplCopyWithImpl<$Res>
    extends _$ManagerUserModelCopyWithImpl<$Res, _$ManagerUserModelImpl>
    implements _$$ManagerUserModelImplCopyWith<$Res> {
  __$$ManagerUserModelImplCopyWithImpl(_$ManagerUserModelImpl _value,
      $Res Function(_$ManagerUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? photo = freezed,
    Object? verified = null,
  }) {
    return _then(_$ManagerUserModelImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagerUserModelImpl implements _ManagerUserModel {
  _$ManagerUserModelImpl({this.username, this.photo, required this.verified});

  factory _$ManagerUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagerUserModelImplFromJson(json);

  @override
  final String? username;
  @override
  final String? photo;
  @override
  final bool verified;

  @override
  String toString() {
    return 'ManagerUserModel(username: $username, photo: $photo, verified: $verified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagerUserModelImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.verified, verified) ||
                other.verified == verified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, photo, verified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagerUserModelImplCopyWith<_$ManagerUserModelImpl> get copyWith =>
      __$$ManagerUserModelImplCopyWithImpl<_$ManagerUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagerUserModelImplToJson(
      this,
    );
  }
}

abstract class _ManagerUserModel implements ManagerUserModel {
  factory _ManagerUserModel(
      {final String? username,
      final String? photo,
      required final bool verified}) = _$ManagerUserModelImpl;

  factory _ManagerUserModel.fromJson(Map<String, dynamic> json) =
      _$ManagerUserModelImpl.fromJson;

  @override
  String? get username;
  @override
  String? get photo;
  @override
  bool get verified;
  @override
  @JsonKey(ignore: true)
  _$$ManagerUserModelImplCopyWith<_$ManagerUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
