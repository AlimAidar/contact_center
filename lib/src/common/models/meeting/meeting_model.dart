// ignore_for_file: invalid_annotation_target

import 'package:contact_center/src/common/models/meeting/local_peer_offer/local_peer_offer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_model.freezed.dart';
part 'meeting_model.g.dart';

@freezed
class MeetingModel with _$MeetingModel {

  factory MeetingModel({
    String? id,
    @JsonKey(name:'id_room') String? idRoom,
    @JsonKey(name:'local_peer_offer') LocalPeerOfferModel? localPeerOffer,
    @JsonKey(name:'ice_candidates') List<Map>? iceCandidates,
    List<String>? tracks,


  }) = _MeetingModel;

  factory MeetingModel.fromJson(Map<String, dynamic> json) => _$MeetingModelFromJson(json);
}