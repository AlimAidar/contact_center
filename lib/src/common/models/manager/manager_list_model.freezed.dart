// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manager_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ManagerListModel _$ManagerListModelFromJson(Map<String, dynamic> json) {
  return _ManagerListModel.fromJson(json);
}

/// @nodoc
mixin _$ManagerListModel {
  @JsonKey(name: 'id_group')
  int get idGroup => throw _privateConstructorUsedError;
  ManagerUserModel get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ManagerListModelCopyWith<ManagerListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagerListModelCopyWith<$Res> {
  factory $ManagerListModelCopyWith(
          ManagerListModel value, $Res Function(ManagerListModel) then) =
      _$ManagerListModelCopyWithImpl<$Res, ManagerListModel>;
  @useResult
  $Res call({@JsonKey(name: 'id_group') int idGroup, ManagerUserModel user});

  $ManagerUserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$ManagerListModelCopyWithImpl<$Res, $Val extends ManagerListModel>
    implements $ManagerListModelCopyWith<$Res> {
  _$ManagerListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idGroup = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      idGroup: null == idGroup
          ? _value.idGroup
          : idGroup // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ManagerUserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ManagerUserModelCopyWith<$Res> get user {
    return $ManagerUserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ManagerListModelImplCopyWith<$Res>
    implements $ManagerListModelCopyWith<$Res> {
  factory _$$ManagerListModelImplCopyWith(_$ManagerListModelImpl value,
          $Res Function(_$ManagerListModelImpl) then) =
      __$$ManagerListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'id_group') int idGroup, ManagerUserModel user});

  @override
  $ManagerUserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$ManagerListModelImplCopyWithImpl<$Res>
    extends _$ManagerListModelCopyWithImpl<$Res, _$ManagerListModelImpl>
    implements _$$ManagerListModelImplCopyWith<$Res> {
  __$$ManagerListModelImplCopyWithImpl(_$ManagerListModelImpl _value,
      $Res Function(_$ManagerListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idGroup = null,
    Object? user = null,
  }) {
    return _then(_$ManagerListModelImpl(
      idGroup: null == idGroup
          ? _value.idGroup
          : idGroup // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ManagerUserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagerListModelImpl implements _ManagerListModel {
  _$ManagerListModelImpl(
      {@JsonKey(name: 'id_group') required this.idGroup, required this.user});

  factory _$ManagerListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagerListModelImplFromJson(json);

  @override
  @JsonKey(name: 'id_group')
  final int idGroup;
  @override
  final ManagerUserModel user;

  @override
  String toString() {
    return 'ManagerListModel(idGroup: $idGroup, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagerListModelImpl &&
            (identical(other.idGroup, idGroup) || other.idGroup == idGroup) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idGroup, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagerListModelImplCopyWith<_$ManagerListModelImpl> get copyWith =>
      __$$ManagerListModelImplCopyWithImpl<_$ManagerListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagerListModelImplToJson(
      this,
    );
  }
}

abstract class _ManagerListModel implements ManagerListModel {
  factory _ManagerListModel(
      {@JsonKey(name: 'id_group') required final int idGroup,
      required final ManagerUserModel user}) = _$ManagerListModelImpl;

  factory _ManagerListModel.fromJson(Map<String, dynamic> json) =
      _$ManagerListModelImpl.fromJson;

  @override
  @JsonKey(name: 'id_group')
  int get idGroup;
  @override
  ManagerUserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$ManagerListModelImplCopyWith<_$ManagerListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
