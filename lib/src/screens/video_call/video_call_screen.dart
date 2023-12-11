import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/widgets/gradient_selected_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen(
      {Key? key, required this.localVideo, required this.previewVideo})
      : super(key: key);

  final RTCVideoRenderer localVideo;
  final RTCVideoRenderer previewVideo;
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int selectedIndex = 0; 
  //   dynamic offer;
//   String? callerId;
//   String? calleeId;
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
//     numberModal = false;
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
//     // }
  List<String> images = [
    'assets/materials/backsplash.png',
    'assets/materials/black_mramor.png',
    'assets/materials/dark_wood.png',
    'assets/materials/mutniy_granit.png',
    'assets/materials/mutniy_granit.png',
    'assets/materials/white_mramor.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/dotted_texture.png'),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/logo.svg'),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: AppColors.grey2,
                          border: Border.all(color: AppColors.grey2)),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/managers_photo/photo_3.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          const Text(
                            'Менеджер: ',
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Text(
                            'Айнур Худабердиев',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    RTCVideoView(
                      widget.previewVideo,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: SizedBox(
                        height: 150,
                        width: 120,
                        child: RTCVideoView(
                          widget.localVideo,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     CupertinoPageRoute(builder: (context) {
                    //   return const ReviewScreen();
                    // }));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Выберете материал вашей будущей кухни',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.grey2,
                        ),
                        child: GradientSelectorTabs(
                          selectedIndex: selectedIndex,
                          textColor: Colors.black,
                          borderColor: Colors.transparent,
                          onSelected: (value) {
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                          tabs: const [
                            'Фасады',
                            'Фартук',
                            'Столешница',
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 200,
                        child: Swiper(
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                ),
                              ),
                              duration: const Duration(
                                milliseconds: 100,
                              ),
                              curve: Curves.bounceIn,
                            );
                          },
                          scale: 1,
                          viewportFraction: 0.2,
                          autoplay: true,
                          itemCount: images.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
