// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) {
  return _MeetingModel.fromJson(json);
}

/// @nodoc
mixin _$MeetingModel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_room')
  String? get idRoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_peer_offer')
  LocalPeerOfferModel? get localPeerOffer => throw _privateConstructorUsedError;
  @JsonKey(name: 'ice_candidates')
  List<Map>? get iceCandidates => throw _privateConstructorUsedError;
  List<String>? get tracks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingModelCopyWith<MeetingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingModelCopyWith<$Res> {
  factory $MeetingModelCopyWith(
          MeetingModel value, $Res Function(MeetingModel) then) =
      _$MeetingModelCopyWithImpl<$Res, MeetingModel>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'id_room') String? idRoom,
      @JsonKey(name: 'local_peer_offer') LocalPeerOfferModel? localPeerOffer,
      @JsonKey(name: 'ice_candidates') List<Map>? iceCandidates,
      List<String>? tracks});

  $LocalPeerOfferModelCopyWith<$Res>? get localPeerOffer;
}

/// @nodoc
class _$MeetingModelCopyWithImpl<$Res, $Val extends MeetingModel>
    implements $MeetingModelCopyWith<$Res> {
  _$MeetingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? idRoom = freezed,
    Object? localPeerOffer = freezed,
    Object? iceCandidates = freezed,
    Object? tracks = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      idRoom: freezed == idRoom
          ? _value.idRoom
          : idRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      localPeerOffer: freezed == localPeerOffer
          ? _value.localPeerOffer
          : localPeerOffer // ignore: cast_nullable_to_non_nullable
              as LocalPeerOfferModel?,
      iceCandidates: freezed == iceCandidates
          ? _value.iceCandidates
          : iceCandidates // ignore: cast_nullable_to_non_nullable
              as List<Map>?,
      tracks: freezed == tracks
          ? _value.tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocalPeerOfferModelCopyWith<$Res>? get localPeerOffer {
    if (_value.localPeerOffer == null) {
      return null;
    }

    return $LocalPeerOfferModelCopyWith<$Res>(_value.localPeerOffer!, (value) {
      return _then(_value.copyWith(localPeerOffer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetingModelImplCopyWith<$Res>
    implements $MeetingModelCopyWith<$Res> {
  factory _$$MeetingModelImplCopyWith(
          _$MeetingModelImpl value, $Res Function(_$MeetingModelImpl) then) =
      __$$MeetingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'id_room') String? idRoom,
      @JsonKey(name: 'local_peer_offer') LocalPeerOfferModel? localPeerOffer,
      @JsonKey(name: 'ice_candidates') List<Map>? iceCandidates,
      List<String>? tracks});

  @override
  $LocalPeerOfferModelCopyWith<$Res>? get localPeerOffer;
}

/// @nodoc
class __$$MeetingModelImplCopyWithImpl<$Res>
    extends _$MeetingModelCopyWithImpl<$Res, _$MeetingModelImpl>
    implements _$$MeetingModelImplCopyWith<$Res> {
  __$$MeetingModelImplCopyWithImpl(
      _$MeetingModelImpl _value, $Res Function(_$MeetingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? idRoom = freezed,
    Object? localPeerOffer = freezed,
    Object? iceCandidates = freezed,
    Object? tracks = freezed,
  }) {
    return _then(_$MeetingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      idRoom: freezed == idRoom
          ? _value.idRoom
          : idRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      localPeerOffer: freezed == localPeerOffer
          ? _value.localPeerOffer
          : localPeerOffer // ignore: cast_nullable_to_non_nullable
              as LocalPeerOfferModel?,
      iceCandidates: freezed == iceCandidates
          ? _value._iceCandidates
          : iceCandidates // ignore: cast_nullable_to_non_nullable
              as List<Map>?,
      tracks: freezed == tracks
          ? _value._tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingModelImpl implements _MeetingModel {
  _$MeetingModelImpl(
      {this.id,
      @JsonKey(name: 'id_room') this.idRoom,
      @JsonKey(name: 'local_peer_offer') this.localPeerOffer,
      @JsonKey(name: 'ice_candidates') final List<Map>? iceCandidates,
      final List<String>? tracks})
      : _iceCandidates = iceCandidates,
        _tracks = tracks;

  factory _$MeetingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'id_room')
  final String? idRoom;
  @override
  @JsonKey(name: 'local_peer_offer')
  final LocalPeerOfferModel? localPeerOffer;
  final List<Map>? _iceCandidates;
  @override
  @JsonKey(name: 'ice_candidates')
  List<Map>? get iceCandidates {
    final value = _iceCandidates;
    if (value == null) return null;
    if (_iceCandidates is EqualUnmodifiableListView) return _iceCandidates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tracks;
  @override
  List<String>? get tracks {
    final value = _tracks;
    if (value == null) return null;
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MeetingModel(id: $id, idRoom: $idRoom, localPeerOffer: $localPeerOffer, iceCandidates: $iceCandidates, tracks: $tracks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idRoom, idRoom) || other.idRoom == idRoom) &&
            (identical(other.localPeerOffer, localPeerOffer) ||
                other.localPeerOffer == localPeerOffer) &&
            const DeepCollectionEquality()
                .equals(other._iceCandidates, _iceCandidates) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      idRoom,
      localPeerOffer,
      const DeepCollectionEquality().hash(_iceCandidates),
      const DeepCollectionEquality().hash(_tracks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingModelImplCopyWith<_$MeetingModelImpl> get copyWith =>
      __$$MeetingModelImplCopyWithImpl<_$MeetingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingModelImplToJson(
      this,
    );
  }
}

abstract class _MeetingModel implements MeetingModel {
  factory _MeetingModel(
      {final String? id,
      @JsonKey(name: 'id_room') final String? idRoom,
      @JsonKey(name: 'local_peer_offer')
      final LocalPeerOfferModel? localPeerOffer,
      @JsonKey(name: 'ice_candidates') final List<Map>? iceCandidates,
      final List<String>? tracks}) = _$MeetingModelImpl;

  factory _MeetingModel.fromJson(Map<String, dynamic> json) =
      _$MeetingModelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'id_room')
  String? get idRoom;
  @override
  @JsonKey(name: 'local_peer_offer')
  LocalPeerOfferModel? get localPeerOffer;
  @override
  @JsonKey(name: 'ice_candidates')
  List<Map>? get iceCandidates;
  @override
  List<String>? get tracks;
  @override
  @JsonKey(ignore: true)
  _$$MeetingModelImplCopyWith<_$MeetingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
