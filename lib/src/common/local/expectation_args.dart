import 'package:contact_center/src/common/models/meeting/meeting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ExpectationArgs {
  ExpectationArgs( {
   required this.mdoel,
    required this.localVideo,
    required this.remoteVideo,
    required this.remoteVideoScreen,
    required this.pageViewController,
  });
  final RTCVideoRenderer localVideo;
  final MeetingModel mdoel;
  final RTCVideoRenderer remoteVideo;
  final RTCVideoRenderer remoteVideoScreen;
  final PageController pageViewController;
}
