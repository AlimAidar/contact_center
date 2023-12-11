import 'package:flutter_webrtc/flutter_webrtc.dart';

class ExpectationArgs {
  ExpectationArgs({required this.localVideo, required this.remoteVideo});
  final RTCVideoRenderer localVideo;
  final RTCVideoRenderer remoteVideo;
}
