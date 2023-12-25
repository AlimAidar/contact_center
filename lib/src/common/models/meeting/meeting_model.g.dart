// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingModelImpl _$$MeetingModelImplFromJson(Map<String, dynamic> json) =>
    _$MeetingModelImpl(
      id: json['id'] as String?,
      idRoom: json['id_room'] as String?,
      localPeerOffer: json['local_peer_offer'] == null
          ? null
          : LocalPeerOfferModel.fromJson(
              json['local_peer_offer'] as Map<String, dynamic>),
      iceCandidates: (json['ice_candidates'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      tracks:
          (json['tracks'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MeetingModelImplToJson(_$MeetingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_room': instance.idRoom,
      'local_peer_offer': instance.localPeerOffer,
      'ice_candidates': instance.iceCandidates,
      'tracks': instance.tracks,
    };
