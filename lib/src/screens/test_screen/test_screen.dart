// import 'dart:developer';

// import 'package:contact_center/src/common/blocks/bloc/login_bloc.dart';
// import 'package:contact_center/src/common/services/signalling.service.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   dynamic offer;
//   String? callerId;
//   String? calleeId;
//   final socket = SignallingService.instance.socket;
// // videoRenderer for localPeer
//   final _localRTCVideoRenderer = RTCVideoRenderer();

//   // videoRenderer for remotePeer
//   final _remoteRTCVideoRenderer = RTCVideoRenderer();

//   // mediaStream for localPeer
//   MediaStream? _localStream;
//   // RTC peer connection
//   RTCPeerConnection? _rtcPeerConnection;
//   List<RTCIceCandidate> rtcIceCadidates = [];

//   bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
//   dynamic incomingSDPOffer;

//   // final _remoteRTCVideoRenderer = RTCVideoRenderer();
//   // InAppLocalhostServer localhostServer = InAppLocalhostServer(
//   //     directoryIndex: 'index.html', documentRoot: 'assets', shared: true);
//   var maskFormatter = MaskTextInputFormatter(
//     mask: '+# (###) ###-##-##',
//     filter: {"#": RegExp(r'[0-9]')},
//     type: MaskAutoCompletionType.lazy,
//   );
//   @override
//   void initState() {
//     context.read<LoginBloc>().add(
//           LoginPressed(
//             email: 'touchpoint',
//             password: '670894439',
//           ),
//         );
//     // initializing renderers
//     // localhostServer.start();
//     // getDevice();
//     // runCamera();
//     WidgetsFlutterBinding.ensureInitialized();

//     _localRTCVideoRenderer.initialize();
//     _remoteRTCVideoRenderer.initialize();
//     SignallingService.instance.socket?.on("newCall", (data) {
//       if (mounted) {
//         log('ded');
//         // set SDP Offer of incoming call
//         incomingSDPOffer = data;
//         offer = incomingSDPOffer["sdpOffer"];
//         callerId = incomingSDPOffer["callerId"]!;
//         _setupPeerConnection();
//       }
//     });

//     // setup Peer Connection
//     super.initState();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   // runCamera() async {
//   //   await Permission.camera.request();
//   //   await Permission.microphone.request();
//   // }

//   // getDevice() async {
//   //   final session = await AudioSession.instance;
//   //   List<AudioDevice> audioDevices = (await session.getDevices()).toList();
//   //   log(audioDevices.toString());
//   // }

//   _setupPeerConnection() async {
//     // create peer connection
//     _rtcPeerConnection = await createPeerConnection({
//       // "bundlePolicy": "balanced",
//       // "encodedInsertableStreams": false,
//       // "iceCandidatePoolSize": 0,
//       'iceServers': [
//         {
//           'urls': "turn:77.243.80.210:3478",
//           'credential': "123",
//           'username': "admin"
//         }
//       ],
//       // "iceTransportPolicy": "all",
//       // "rtcpMuxPolicy": "require",
//       // "sdpSemantics": "unified-plan"
//     });
//     socket!.on("IceCandidate", (data) {
//       String candidate = data["iceCandidate"]["candidate"];
//       String sdpMid = data["iceCandidate"]["id"];
//       int sdpMLineIndex = data["iceCandidate"]["label"];

//       // add iceCandidate
//       _rtcPeerConnection!.addCandidate(RTCIceCandidate(
//         candidate,
//         sdpMid,
//         sdpMLineIndex,
//       ));
//     });
//     _rtcPeerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
//       socket!.emit("IceCandidate", {
//         "calleeId": callerId,
//         "iceCandidate": {
//           "id": candidate.sdpMid,
//           "label": candidate.sdpMLineIndex,
//           "candidate": candidate.candidate
//         }
//       });
//     };
// //      final pc = await createPeerConnection({
// //       "bundlePolicy": "balanced",
// //       "encodedInsertableStreams": false,
// //       "iceCandidatePoolSize": 0,
// //       "iceServers": [
// //         {
// //           "credential": "",
// //           "urls": ["stun:stun.l.google.com:19302"],
// //           "username": ""
// //         },
// //         {
// //           "credential": "",
// //           "urls": ["stun:global.stun.twilio.com:3478"],
// //           "username": ""
// //         }
// //       ],
// //       "iceTransportPolicy": "all",
// //       "rtcpMuxPolicy": "require",
// //       "sdpSemantics": "unified-plan"
// // });

//     // listen for remotePeer mediaTrack event
//     _rtcPeerConnection!.onTrack = (event) {
//       _remoteRTCVideoRenderer.srcObject = event.streams[0];
//       setState(() {});
//     };
//     // get localStream
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': isAudioOn,
//     });

//     // add mediaTrack to peerConnection
//     _localStream!.getTracks().forEach((track) {
//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });

//     // set source for local video renderer
//     // _localRTCVideoRenderer.srcObject = _localStream;
//     // setState(() {});

//     // for Incoming call
//     if (offer != null) {
//       // listen for Remote IceCandidate

//       // set SDP offer as remoteDescription for peerConnection
//       await _rtcPeerConnection!.setRemoteDescription(
//         RTCSessionDescription(offer["sdp"], offer["type"]),
//       );
//       // create SDP answer
//       RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

//       // set SDP answer as localDescription for peerConnection
//       _rtcPeerConnection!.setLocalDescription(answer);

//       // send SDP answer to remote peer over signalling
//       socket!.emit("answerCall", {
//         "callerId": callerId,
//         "sdpAnswer": answer.toMap(),
//       });
//     }
//     // for Outgoing Call
//     // else {
//     //   // listen for local iceCandidate and add it to the list of IceCandidate
//     //   _rtcPeerConnection!.onIceCandidate =
//     //       (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);

//     //   // when call is accepted by remote peer
//     //   socket!.on("callAnswered", (data) async {
//     //     await _rtcPeerConnection!.setRemoteDescription(
//     //       RTCSessionDescription(
//     //         data["sdpAnswer"]["sdp"],
//     //         data["sdpAnswer"]["type"],
//     //       ),
//     //     );

//     //     // send iceCandidate generated to remote peer over signalling
//     //     for (RTCIceCandidate candidate in rtcIceCadidates) {
//     //       socket!.emit("IceCandidate", {
//     //         "calleeId": calleeId,
//     //         "iceCandidate": {
//     //           "id": candidate.sdpMid,
//     //           "label": candidate.sdpMLineIndex,
//     //           "candidate": candidate.candidate
//     //         }
//     //       });
//     //     }
//     //   });

//     //   // create SDP Offer
//     //   RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();

//     //   // set SDP offer as localDescription for peerConnection
//     //   await _rtcPeerConnection!.setLocalDescription(offer);

//     //   // make a call to remote peer over signalling
//     //   socket!.emit('makeCall', {
//     //     "calleeId": calleeId,
//     //     "sdpOffer": offer.toMap(),
//     //   });
//     // }

//     // if (_rtcPeerConnection!.iceConnectionState ==
//     //     RTCIceConnectionState.RTCIceConnectionStateClosed) {
//     //   _rtcPeerConnection?.dispose();
//     // } else if (_rtcPeerConnection!.iceConnectionState ==
//     //     RTCIceConnectionState.RTCIceConnectionStateCompleted) {
//     //   _rtcPeerConnection?.dispose();
//     // } else if (_rtcPeerConnection!.iceConnectionState ==
//     //     RTCIceConnectionState.RTCIceConnectionStateFailed) {
//     //   _rtcPeerConnection?.dispose();
//     // } else if (_rtcPeerConnection!.iceConnectionState ==
//     //     RTCIceConnectionState.RTCIceConnectionStateDisconnected) {
//     //   _rtcPeerConnection?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
