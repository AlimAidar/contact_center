import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_peer_offer.freezed.dart';
part 'local_peer_offer.g.dart';

@freezed
class LocalPeerOfferModel with _$LocalPeerOfferModel {

  factory LocalPeerOfferModel({String? sdp,String? type,}) = _LocalPeerOfferModel;

  factory LocalPeerOfferModel.fromJson(Map<String, dynamic> json) => _$LocalPeerOfferModelFromJson(json);
}