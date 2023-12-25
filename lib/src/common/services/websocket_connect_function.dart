// import 'dart:developer';

// import 'package:contact_center/src/common/router/routing_constant.dart';
// import 'package:contact_center/src/common/services/signalling.service.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';

//   dynamic offer;
//   String? callerId;
//   String? calleeId;
//    String? managerSocketId;
//   int? managerID;
//   Map streamLabels = {};

//   final socket = SignallingService.instance.socket;
//   final _localRTCVideoRenderer = RTCVideoRenderer();

//   // videoRenderer for remotePeer
//   final _remoteRTCVideoRenderer = RTCVideoRenderer();
//   final _remoteRTCVideoRendererScreen = RTCVideoRenderer();

//   // mediaStream for localPeer
//   List<Map> devicesId = [];
//   MediaStream? _localStream;

//   // RTC peer connection
//   RTCPeerConnection? _rtcPeerConnection;

// _setupPeerConnection() async {
//     _rtcPeerConnection = await createPeerConnection({
//       'iceServers': [
//         {
//           'urls': "turn:77.243.80.210:3478",
//           'credential': "123",
//           'username': "admin"
//         }
//       ]
//     });
//     socket!.on('disconnected', (data) {
//       log('$data otcluchil');
//       log(managerSocketId.toString());
//       // if (managerSocketId == data) {
//       //   // disconnectFunction();
//       // }
//     });

//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': true,
//       'video': true,
//     });
//     // _localStream!.getAudioTracks().forEach((element) {
//     //   pageViewController.animateToPage(
//     //     1,
//     //     duration: const Duration(milliseconds: 100),
//     //     curve: Curves.ease,
//     //   );
//     // });
//     _localStream!.getTracks().forEach((track) {
//       log('$track Track');

//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });

//     _localRTCVideoRenderer.srcObject = _localStream;
//     // setState(() {});

//     socket!.on("mediaOffer", (data) async {
//       log("$data MediaOffersssssssssssssssssadasdasdasd");

//       if (managerSocketId == null) {
//         managerID = data['manager_id'];
//         managerSocketId = data['from'];
//       }
//       streamLabels = data['streamLabels'];
//       await _rtcPeerConnection!.setRemoteDescription(
//         RTCSessionDescription(data['offer']["sdp"], data['offer']["type"]),
//       );

//       RTCSessionDescription answer = await _rtcPeerConnection!
//           .createAnswer({'offerToReceiveAudio': 1, 'offerToReceiveVideo': 1});

//       // set SDP answer as localDescription for peerConnection
//       await _rtcPeerConnection!.setLocalDescription(answer);
//       // send SDP answer to remote peer over signalling
//       socket!.emit("mediaAnswer", {
//         "answer": answer.toMap(),
//         "from": socket!.id,
//         "to": data['from'],
//       });
//     });
//     socket!.on('mediaAnswer', (data) async {
//       await _rtcPeerConnection!.setRemoteDescription(data['answer']);
//     });
//     socket!.on('remotePeerIceCandidate', (data) async {
//       try {
//         RTCIceCandidate candidate = RTCIceCandidate(
//             data['candidate']['candidate'],
//             data['candidate']['sdpMid'],
//             data['candidate']['sdpMLineIndex']);
//         await _rtcPeerConnection!.addCandidate(candidate);
//       } catch (e) {
//         log(e.toString());
//       }
//     });

//     _rtcPeerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
//       log('$candidate onIceCandidate');
//       socket!.emit(
//         "iceCandidate",
//         {"to": managerSocketId, "candidate": candidate.candidate},
//       );
//     };
//     // // listen for remotePeer mediaTrack event
//     _rtcPeerConnection!.onTrack = (event) {
//       pageViewController.animateToPage(
//         1,
//         duration: const Duration(milliseconds: 100),
//         curve: Curves.ease,
//       );
//       log('$event EventConnection');
//       MediaStream srcObject = event.streams[0];
//       log("${streamLabels.keys}"
//           'afadfadfdfasdfffffffffffffffffffffffffffffffffffffffff');
//       for (var key in streamLabels.keys) {
//         log(streamLabels[key]);
//         log('${srcObject.id} asdasdasd');
//         if (streamLabels[key] == srcObject.id) {
//           if (key == 'webcam') {
//             log(key + '     webcam       ');
//             _remoteRTCVideoRenderer.srcObject = srcObject;
//             // setState(() {});
//           } else {
//             _remoteRTCVideoRendererScreen.srcObject = srcObject;
//             // setState(() {});
//           }
//         }
//       }
//     };
//   }

 