// import 'dart:async';
// import 'dart:developer';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:contact_center/src/common/constants/color_constants.dart';
// import 'package:contact_center/src/common/router/routing_constant.dart';
// import 'package:contact_center/src/common/services/signalling.service.dart';
// import 'package:contact_center/src/common/widgets/gradient_selected_tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';

// class ExpectationScreen extends StatefulWidget {
//   const ExpectationScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ExpectationScreen> createState() => _ExpectationScreenState();
// }

// class _ExpectationScreenState extends State<ExpectationScreen> {
//   final PageController pageViewController = PageController();

//   List<String> imagesManager = [
//     'assets/managers_photo/photo_1.png',
//     'assets/managers_photo/photo_2.png',
//     'assets/managers_photo/photo_3.png',
//     'assets/managers_photo/photo_4.png',
//     'assets/managers_photo/photo_5.png',
//   ];
//   List<String> imagesMaterial = [
//     'assets/materials/backsplash.png',
//     'assets/materials/black_mramor.png',
//     'assets/materials/dark_wood.png',
//     'assets/materials/mutniy_granit.png',
//     'assets/materials/mutniy_granit.png',
//     'assets/materials/white_mramor.png',
//   ];

//   dynamic offer;
//   String? callerId;
//   String? calleeId;
//   int selectedIndex = 0;

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

//   // list of rtcCandidates to be sent over signalling

//   String? managerSoketId;
//   String? managerID;
//   Map streamLabels = {};

//   // media status
//   bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
//   dynamic incomingSDPOffer;
//   @override
//   void initState() {
//     _localRTCVideoRenderer.initialize();
//     _remoteRTCVideoRendererScreen.initialize();
//     _remoteRTCVideoRenderer.initialize();
//     WidgetsFlutterBinding.ensureInitialized();
//     _setupPeerConnection();
//     // SignallingService.instance.socket?.on("newCall", (data) {
//     //   if (mounted) {
//     //     log('New Call');
//     //     // set SDP Offer of incoming call
//     //     incomingSDPOffer = data;
//     //     offer = incomingSDPOffer["sdpOffer"];
//     //     callerId = incomingSDPOffer["callerId"]!;
//     //   }
//     // });

//     super.initState();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   _setupPeerConnection() async {
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
//       if (managerSoketId == data) {
//         _localRTCVideoRenderer.dispose();
//         _remoteRTCVideoRenderer.dispose();
//         _remoteRTCVideoRendererScreen.dispose();
//         _localStream?.dispose();
//         _rtcPeerConnection?.dispose();
//         SignallingService.instance.disconnect();

//         Navigator.popAndPushNamed(
//           context,
//           RoutingConst.review,
//         );
//       }
//     });
//     // List<MediaDeviceInfo> devices =
//     //     await navigator.mediaDevices.enumerateDevices();

//     // for (var dev in devices) {
//     //   if (dev.kind != 'audioinput') continue;
//     //   Map kek = {
//     //     'label': dev.label,
//     //     'deviceId': dev.deviceId,
//     //     'groupId': dev.groupId,
//     //     'kind': dev.kind
//     //   };

//     //   devicesId.add(kek);
//     // }
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': isAudioOn,
//       'video': isVideoOn,
//     });

//     _localStream!.getTracks().forEach((track) {
//       log('$track Track');

//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });

//     _localRTCVideoRenderer.srcObject = _localStream;
//     setState(() {});

//     socket!.on("mediaOffer", (data) async {
//       log("$data MediaOffersssssssssssssssssadasdasdasd");

//       if (managerSoketId != null) {
//         managerID = data.manager_id;
//         managerSoketId = data.from;
//       }
//       streamLabels = data['streamLabels'];
//       await _rtcPeerConnection!.setRemoteDescription(
//         RTCSessionDescription(data['offer']["sdp"], data['offer']["type"]),
//       );

//       RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

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
//         {"to": managerSoketId, "candidate": candidate.candidate},
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
//             setState(() {});
//           } else {
//             _remoteRTCVideoRendererScreen.srcObject = srcObject;
//             setState(() {});
//           }
//         }
//       }
//     };

//     // // get localStream

//     // // set source for local video renderer

//     // // for Incoming call
//     // if (offer != null) {
//     //   // listen for Remote IceCandidate

//     //   // set SDP offer as remoteDescription for peerConnection

//     //   // create SDP answer

//     // }
//     Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (_rtcPeerConnection!.iceConnectionState ==
//           RTCIceConnectionState.RTCIceConnectionStateConnected) {
//         pageViewController.animateToPage(
//           1,
//           duration: const Duration(milliseconds: 100),
//           curve: Curves.ease,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: pageViewController,
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/dotted_texture.png'),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 35),
//                     color: Colors.white,
//                     child: Row(
//                       children: [SvgPicture.asset('assets/logo.svg')],
//                     ),
//                   ),
//                   const Spacer(),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 230),
//                     child: Text(
//                       'Ждем подключения менеджера продаж',
//                       style: TextStyle(
//                         fontSize: 64,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 120,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     height: 302,
//                     child: Swiper(
//                       itemBuilder: (context, index) {
//                         return AnimatedContainer(
//                           height: 200,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 imagesManager[index],
//                               ),
//                             ),
//                           ),
//                           duration: const Duration(
//                             milliseconds: 100,
//                           ),
//                           curve: Curves.bounceIn,
//                         );
//                       },
//                       scale: 0,
//                       viewportFraction: 0.2,
//                       autoplay: true,
//                       itemCount: imagesManager.length,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   // BrButton(
//                   //   onPressed: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       CupertinoPageRoute(
//                   //         builder: (context) {
//                   //           return VideoCallScreen(
//                   //             localVideo: widget.localVide,
//                   //             previewVideo: widget.previewVideo,
//                   //           );
//                   //         },
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/dotted_texture.png'),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 25),
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         SvgPicture.asset('assets/logo.svg'),
//                         const Spacer(),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(360),
//                               color: AppColors.grey2,
//                               border: Border.all(color: AppColors.grey2)),
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(360),
//                                   image: const DecorationImage(
//                                     image: AssetImage(
//                                       'assets/managers_photo/photo_3.png',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 24,
//                               ),
//                               const Text(
//                                 'Менеджер: ',
//                                 style: TextStyle(
//                                   color: AppColors.orange,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               const Text(
//                                 'Айнур Худабердиев',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 24,
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.grey,
//                       ),
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: RTCVideoView(
//                               _remoteRTCVideoRenderer,
//                               objectFit: RTCVideoViewObjectFit
//                                   .RTCVideoViewObjectFitCover,
//                             ),
//                           ),
//                           Positioned(
//                             right: 65,
//                             bottom: 65,
//                             child: SizedBox(
//                               height: 150,
//                               width: 150,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: RTCVideoView(
//                                   _localRTCVideoRenderer,
//                                   mirror: true,
//                                   objectFit: RTCVideoViewObjectFit
//                                       .RTCVideoViewObjectFitCover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 398,
//                             bottom: 65,
//                             child: InkWell(
//                               onTap: () {
//                                 _localRTCVideoRenderer.dispose();
//                                 _remoteRTCVideoRenderer.dispose();
//                                 _localStream?.dispose();
//                                 _rtcPeerConnection?.dispose();
//                                 SignallingService.instance.disconnect();
//                                 Navigator.pushNamed(
//                                   context,
//                                   RoutingConst.review,
//                                 );
//                               },
//                               child: SvgPicture.asset(
//                                   'assets/icon/end_call_button.svg'),
//                             ),
//                           ),
//                           Positioned(
//                             left: 540,
//                             bottom: 65,
//                             child: InkWell(
//                               onTap: () {},
//                               child: SvgPicture.asset(
//                                   'assets/icon/turn_off_micro.svg'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 60),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           const Text(
//                             'Выберете материал вашей будущей кухни',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: AppColors.grey2,
//                             ),
//                             child: GradientSelectorTabs(
//                               selectedIndex: selectedIndex,
//                               textColor: Colors.black,
//                               borderColor: Colors.transparent,
//                               onSelected: (value) {
//                                 setState(() {
//                                   selectedIndex = value;
//                                 });
//                               },
//                               tabs: const [
//                                 'Фасады',
//                                 'Фартук',
//                                 'Столешница',
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 44,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             height: 200,
//                             child: Swiper(
//                               itemBuilder: (context, index) {
//                                 return AnimatedContainer(
//                                   height: 200,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(imagesMaterial[index]),
//                                     ),
//                                   ),
//                                   duration: const Duration(
//                                     milliseconds: 100,
//                                   ),
//                                   curve: Curves.bounceIn,
//                                 );
//                               },
//                               scale: 1,
//                               viewportFraction: 0.2,
//                               autoplay: true,
//                               itemCount: imagesMaterial.length,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
