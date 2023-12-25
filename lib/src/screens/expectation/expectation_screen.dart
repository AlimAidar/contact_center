import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/common/widgets/gradient_selected_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpectationScreen extends StatefulWidget {
  const ExpectationScreen({
    Key? key,
    required this.pageViewController,
    required this.localRTCVideoRenderer,
    required this.remoteRTCVideoRenderer,
    required this.remoteRTCVideoRendererScreen,
  }) : super(key: key);
  final PageController pageViewController;
  final RTCVideoRenderer localRTCVideoRenderer;

  // videoRenderer for remotePeer
  final RTCVideoRenderer remoteRTCVideoRenderer;
  final RTCVideoRenderer remoteRTCVideoRendererScreen;

  @override
  State<ExpectationScreen> createState() => _ExpectationScreenState();
}

class _ExpectationScreenState extends State<ExpectationScreen> {
  List<Map> itemsManager = [
    {
      'image': 'assets/managers_photo/photo_1.png',
      'name': 'Айжан Шулембаева',
    },
    {
      'image': 'assets/managers_photo/photo_2.png',
      'name': 'Айжан Шулембаева',
    },
    {
      'image': 'assets/managers_photo/photo_3.png',
      'name': 'Айжан Шулембаева',
    },
    {
      'image': 'assets/managers_photo/photo_4.png',
      'name': 'Айжан Шулембаева',
    },
    {
      'image': 'assets/managers_photo/photo_5.png',
      'name': 'Айжан Шулембаева',
    },
  ];
  List<Map> imagesMaterial = [
    {
      'image': 'assets/materials/black_mramor.png',
      'article': '1',
    },
    {
      'image': 'assets/materials/dark_wood.png',
      'article': '2',
    },
    {
      'image': 'assets/materials/mutniy_granit.png',
      'article': '3',
    },
    {
      'image': 'assets/materials/mutniy_granit.png',
      'article': '4',
    },
    {
      'image': 'assets/materials/white_mramor.png',
      'article': '5',
    }
  ];

  // dynamic offer;
  // String? callerId;
  // String? calleeId;
  int selectedIndex = 0;
  int selectedTab = 0;

  // final socket = SignallingService.instance.socket;
  // final _localRTCVideoRenderer = RTCVideoRenderer();

  // // videoRenderer for remotePeer
  // final _remoteRTCVideoRenderer = RTCVideoRenderer();
  // final _remoteRTCVideoRendererScreen = RTCVideoRenderer();

  // // mediaStream for localPeer
  // List<Map> devicesId = [];
  // MediaStream? _localStream;

  // // RTC peer connection
  // RTCPeerConnection? _rtcPeerConnection;

  // // list of rtcCandidates to be sent over signalling

  // String? managerSocketId;
  // int? managerID;
  // Map streamLabels = {};

  // // media status
  // bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  // dynamic incomingSDPOffer;
  // @override
  // void initState() {
  //   _localRTCVideoRenderer.initialize();
  //   _remoteRTCVideoRendererScreen.initialize();
  //   _remoteRTCVideoRenderer.initialize();
  //   WidgetsFlutterBinding.ensureInitialized();
  //   _setupPeerConnection();

  //   super.initState();
  // }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  // _setupPeerConnection() async {
  //   _rtcPeerConnection = await createPeerConnection({
  //     'iceServers': [
  //       {
  //         'urls': "turn:77.243.80.210:3478",
  //         'credential': "123",
  //         'username': "admin"
  //       }
  //     ]
  //   });
  //   socket!.on('disconnected', (data) {
  //     log('$data otcluchil');
  //     log(managerSocketId.toString());
  //     if (managerSocketId == data) {
  //       disconnectFunction();
  //     }
  //   });

  //   _localStream = await navigator.mediaDevices.getUserMedia({
  //     'audio': isAudioOn,
  //     'video': isVideoOn,
  //   });
  //   // _localStream!.getAudioTracks().forEach((element) {
  //   //   pageViewController.animateToPage(
  //   //     1,
  //   //     duration: const Duration(milliseconds: 100),
  //   //     curve: Curves.ease,
  //   //   );
  //   // });
  //   _localStream!.getTracks().forEach((track) {
  //     log('$track Track');

  //     _rtcPeerConnection!.addTrack(track, _localStream!);
  //   });

  //   _localRTCVideoRenderer.srcObject = _localStream;
  //   setState(() {});

  //   socket!.on("mediaOffer", (data) async {
  //     log("$data MediaOffersssssssssssssssssadasdasdasd");

  //     if (managerSocketId == null) {
  //       managerID = data['manager_id'];
  //       managerSocketId = data['from'];
  //     }
  //     streamLabels = data['streamLabels'];
  //     await _rtcPeerConnection!.setRemoteDescription(
  //       RTCSessionDescription(data['offer']["sdp"], data['offer']["type"]),
  //     );

  //     RTCSessionDescription answer = await _rtcPeerConnection!
  //         .createAnswer({'offerToReceiveAudio': 1, 'offerToReceiveVideo': 1});

  //     // set SDP answer as localDescription for peerConnection
  //     await _rtcPeerConnection!.setLocalDescription(answer);
  //     // send SDP answer to remote peer over signalling
  //     socket!.emit("mediaAnswer", {
  //       "answer": answer.toMap(),
  //       "from": socket!.id,
  //       "to": data['from'],
  //     });
  //   });
  //   socket!.on('mediaAnswer', (data) async {
  //     await _rtcPeerConnection!.setRemoteDescription(data['answer']);
  //   });
  //   socket!.on('remotePeerIceCandidate', (data) async {
  //     try {
  //       RTCIceCandidate candidate = RTCIceCandidate(
  //           data['candidate']['candidate'],
  //           data['candidate']['sdpMid'],
  //           data['candidate']['sdpMLineIndex']);
  //       await _rtcPeerConnection!.addCandidate(candidate);
  //     } catch (e) {
  //       log(e.toString());
  //     }
  //   });

  //   _rtcPeerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
  //     log('$candidate onIceCandidate');
  //     socket!.emit(
  //       "iceCandidate",
  //       {"to": managerSocketId, "candidate": candidate.candidate},
  //     );
  //   };
  //   // // listen for remotePeer mediaTrack event
  //   _rtcPeerConnection!.onTrack = (event) {
  //     pageViewController.animateToPage(
  //       1,
  //       duration: const Duration(milliseconds: 100),
  //       curve: Curves.ease,
  //     );
  //     log('$event EventConnection');
  //     MediaStream srcObject = event.streams[0];
  //     log("${streamLabels.keys}"
  //         'afadfadfdfasdfffffffffffffffffffffffffffffffffffffffff');
  //     for (var key in streamLabels.keys) {
  //       log(streamLabels[key]);
  //       log('${srcObject.id} asdasdasd');
  //       if (streamLabels[key] == srcObject.id) {
  //         if (key == 'webcam') {
  //           log(key + '     webcam       ');
  //           _remoteRTCVideoRenderer.srcObject = srcObject;
  //           setState(() {});
  //         } else {
  //           _remoteRTCVideoRendererScreen.srcObject = srcObject;
  //           setState(() {});
  //         }
  //       }
  //     }
  //   };
  // }

  // disconnectFunction() {
  //   // _localRTCVideoRenderer.dispose();
  //   _remoteRTCVideoRenderer.dispose();
  //   _remoteRTCVideoRendererScreen.dispose();
  //   // _localStream?.dispose();
  //   // _rtcPeerConnection?.dispose();
  //   // SignallingService.instance.disconnect();

  //   Navigator.popAndPushNamed(
  //     context,
  //     RoutingConst.review,
  //   );
  // }Р    Т
  // ВКЛАДЫШИ 050
  // ПОРШЕНЬ РЕМОНТНЫЙ
  // ПРРОКЛАДКИ ВСЕ

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.pageViewController,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/dotted_texture.png'),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 35),
                    color: Colors.white,
                    child: Row(
                      children: [SvgPicture.asset('assets/logo.svg')],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 230),
                    child: Text(
                      // 'Ждем подключения менеджера продаж',
                      AppLocalizations.of(context)!.call_loading,
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/call_form.png'),
                            ),
                            borderRadius: BorderRadius.circular(360),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 401,
                        child: Swiper(
                          physics: const NeverScrollableScrollPhysics(),
                          onIndexChanged: (index) {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360),
                                    border: Border.all(
                                      width: 4,
                                      color: selectedTab == index
                                          ? Colors.green
                                          : Colors.transparent,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        itemsManager[index]['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 150,
                                ),
                                Text(
                                  itemsManager[index]['name'],
                                  style: TextStyle(
                                    color: selectedTab == index
                                        ? Colors.black
                                        : Colors.transparent,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            );
                          },
                          scale: 0,
                          viewportFraction: 0.2,
                          autoplay: true,
                          itemCount: itemsManager.length,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/dotted_texture.png'),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 25),
                    color: Colors.white,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/logo.svg'),
                        // const Spacer(),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(360),
                        //       color: AppColors.grey2,
                        //       border: Border.all(color: AppColors.grey2)),
                        //   padding: const EdgeInsets.all(5),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         width: 60,
                        //         height: 60,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(360),
                        //           image: const DecorationImage(
                        //             image: AssetImage(
                        //               'assets/managers_photo/photo_3.png',
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 24,
                        //       ),
                        //       const Text(
                        //         'Менеджер: ',
                        //         style: TextStyle(
                        //           color: AppColors.orange,
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w300,
                        //         ),
                        //       ),
                        //       const Text(
                        //         'Айнур Худабердиев',
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w300,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 24,
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: RTCVideoView(
                              widget.remoteRTCVideoRenderer,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitCover,
                            ),
                          ),
                          Positioned(
                            right: 65,
                            bottom: 65,
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: RTCVideoView(
                                  widget.localRTCVideoRenderer,
                                  mirror: true,
                                  objectFit: RTCVideoViewObjectFit
                                      .RTCVideoViewObjectFitCover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 398,
                            bottom: 65,
                            child: InkWell(
                              onTap: () async {
                                await Navigator.popAndPushNamed(
                                    context, RoutingConst.review);
                                // disconnectFunction();
                              },
                              child: SvgPicture.asset(
                                  'assets/icon/end_call_button.svg'),
                            ),
                          ),
                          Positioned(
                            left: 540,
                            bottom: 65,
                            child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  'assets/icon/turn_off_micro.svg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: RTCVideoView(
                          widget.remoteRTCVideoRendererScreen,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                        Text(
                          AppLocalizations.of(context)!.material_main,
                          style: const TextStyle(
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
                            tabs: [
                              AppLocalizations.of(context)!.material_fartuk,
                              AppLocalizations.of(context)!.material_furniture,
                              AppLocalizations.of(context)!.material_table,
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        selectedIndex == 0
                            ? Container(
                                height: 250,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                imagesMaterial[index]['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          imagesMaterial[index]['article'],
                                        )
                                      ],
                                    );
                                  },
                                  scale: 1,
                                  viewportFraction: 0.2,
                                  autoplay: true,
                                  itemCount: imagesMaterial.length,
                                ),
                              )
                            : const Offstage(),
                        selectedIndex == 1
                            ? Container(
                                height: 250,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                imagesMaterial[index]['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          imagesMaterial[index]['article'],
                                        )
                                      ],
                                    );
                                  },
                                  scale: 1,
                                  viewportFraction: 0.2,
                                  autoplay: true,
                                  itemCount: imagesMaterial.length,
                                ),
                              )
                            : const Offstage(),
                        selectedIndex == 2
                            ? Container(
                                height: 250,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                imagesMaterial[index]['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          imagesMaterial[index]['article'],
                                        )
                                      ],
                                    );
                                  },
                                  scale: 1,
                                  viewportFraction: 0.2,
                                  autoplay: true,
                                  itemCount: imagesMaterial.length,
                                ),
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
