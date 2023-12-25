// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_peer_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocalPeerOfferModel _$LocalPeerOfferModelFromJson(Map<String, dynamic> json) {
  return _LocalPeerOfferModel.fromJson(json);
}

/// @nodoc
mixin _$LocalPeerOfferModel {
  String? get sdp => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalPeerOfferModelCopyWith<LocalPeerOfferModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalPeerOfferModelCopyWith<$Res> {
  factory $LocalPeerOfferModelCopyWith(
          LocalPeerOfferModel value, $Res Function(LocalPeerOfferModel) then) =
      _$LocalPeerOfferModelCopyWithImpl<$Res, LocalPeerOfferModel>;
  @useResult
  $Res call({String? sdp, String? type});
}

/// @nodoc
class _$LocalPeerOfferModelCopyWithImpl<$Res, $Val extends LocalPeerOfferModel>
    implements $LocalPeerOfferModelCopyWith<$Res> {
  _$LocalPeerOfferModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sdp = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      sdp: freezed == sdp
          ? _value.sdp
          : sdp // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalPeerOfferModelImplCopyWith<$Res>
    implements $LocalPeerOfferModelCopyWith<$Res> {
  factory _$$LocalPeerOfferModelImplCopyWith(_$LocalPeerOfferModelImpl value,
          $Res Function(_$LocalPeerOfferModelImpl) then) =
      __$$LocalPeerOfferModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? sdp, String? type});
}

/// @nodoc
class __$$LocalPeerOfferModelImplCopyWithImpl<$Res>
    extends _$LocalPeerOfferModelCopyWithImpl<$Res, _$LocalPeerOfferModelImpl>
    implements _$$LocalPeerOfferModelImplCopyWith<$Res> {
  __$$LocalPeerOfferModelImplCopyWithImpl(_$LocalPeerOfferModelImpl _value,
      $Res Function(_$LocalPeerOfferModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sdp = freezed,
    Object? type = freezed,
  }) {
    return _then(_$LocalPeerOfferModelImpl(
      sdp: freezed == sdp
          ? _value.sdp
          : sdp // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalPeerOfferModelImpl implements _LocalPeerOfferModel {
  _$LocalPeerOfferModelImpl({this.sdp, this.type});

  factory _$LocalPeerOfferModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalPeerOfferModelImplFromJson(json);

  @override
  final String? sdp;
  @override
  final String? type;

  @override
  String toString() {
    return 'LocalPeerOfferModel(sdp: $sdp, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalPeerOfferModelImpl &&
            (identical(other.sdp, sdp) || other.sdp == sdp) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sdp, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalPeerOfferModelImplCopyWith<_$LocalPeerOfferModelImpl> get copyWith =>
      __$$LocalPeerOfferModelImplCopyWithImpl<_$LocalPeerOfferModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalPeerOfferModelImplToJson(
      this,
    );
  }
}

abstract class _LocalPeerOfferModel implements LocalPeerOfferModel {
  factory _LocalPeerOfferModel({final String? sdp, final String? type}) =
      _$LocalPeerOfferModelImpl;

  factory _LocalPeerOfferModel.fromJson(Map<String, dynamic> json) =
      _$LocalPeerOfferModelImpl.fromJson;

  @override
  String? get sdp;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$LocalPeerOfferModelImplCopyWith<_$LocalPeerOfferModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
