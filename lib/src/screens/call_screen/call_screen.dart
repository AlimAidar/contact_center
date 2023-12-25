import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/constants/text_styles.dart';
import 'package:contact_center/src/common/local/expectation_args.dart';
import 'package:contact_center/src/common/local/function/soket_connect.dart';
import 'package:contact_center/src/common/models/meeting/meeting_model.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:contact_center/src/common/widgets/br_button.dart';
import 'package:contact_center/src/common/widgets/br_divider.dart';
import 'package:contact_center/src/common/widgets/br_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hive/hive.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    Key? key,
    required this.pageViewController,
    required this.localRTCVideoRenderer,
    required this.remoteRTCVideoRenderer,
    required this.remoteRTCVideoRendererScreen,
    required this.model,
  }) : super(key: key);

  final MeetingModel model;
  final PageController pageViewController;
  final RTCVideoRenderer localRTCVideoRenderer;

  // videoRenderer for remotePeer
  final RTCVideoRenderer remoteRTCVideoRenderer;
  final RTCVideoRenderer remoteRTCVideoRendererScreen;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  List<String> images = [
    'assets/gallery/gellary_item_1.png',
    'assets/gallery/gellary_item_2.png',
    'assets/gallery/gellary_item_3.png',
  ];
  TextEditingController controller = TextEditingController();

  // _setupPeerConnection() async {
  // _rtcPeerConnection = await createPeerConnection({
  //   'iceServers': [
  //     {
  //       'urls': "turn:77.243.80.210:3478",
  //       'credential': "123",
  //       'username': "admin"
  //     }
  //   ]
  // });
  // socket!.on('disconnected', (data) {
  //   log('$data otcluchil');
  //   log('$managerSocketId pizdec');
  //   if (managerSocketId == data) {
  //     // disconnectFunction();
  //   }
  // });

  // _localStream!.getAudioTracks().forEach((element) {
  //   pageViewController.animateToPage(
  //     1,
  //     duration: const Duration(milliseconds: 100),
  //     curve: Curves.ease,
  //   );
  // });

  // socket!.on("mediaOffer", (data) async {
  //   log("$data MediaOffersssssssssssssssssadasdasdasd");

  //   if (managerSocketId == null) {
  //     managerID = data['manager_id'];
  //     managerSocketId = data['from'];
  //   }
  //   streamLabels = data['streamLabels'];
  //   await _rtcPeerConnection!.setRemoteDescription(
  //     RTCSessionDescription(data['offer']["sdp"], data['offer']["type"]),
  //   );

  //   RTCSessionDescription answer = await _rtcPeerConnection!
  //       .createAnswer({'offerToReceiveAudio': 1, 'offerToReceiveVideo': 1});

  //   // set SDP answer as localDescription for peerConnection
  //   await _rtcPeerConnection!.setLocalDescription(answer);
  //   // send SDP answer to remote peer over signalling
  //   socket!.emit("mediaAnswer", {
  //     "answer": answer.toMap(),
  //     "from": socket!.id,
  //     "to": data['from'],
  //   });
  // });
  // socket!.on('mediaAnswer', (data) async {
  //   await _rtcPeerConnection!.setRemoteDescription(data['answer']);
  // });
  // socket!.on('remotePeerIceCandidate', (data) async {
  //   try {
  //     RTCIceCandidate candidate = RTCIceCandidate(
  //         data['candidate']['candidate'],
  //         data['candidate']['sdpMid'],
  //         data['candidate']['sdpMLineIndex']);
  //     await _rtcPeerConnection!.addCandidate(candidate);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // });

  // _rtcPeerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
  //   log('$candidate onIceCandidate');
  //   socket!.emit(
  //     "iceCandidate",
  //     {"to": managerSocketId, "candidate": candidate.candidate},
  //   );
  // };
  // // listen for remotePeer mediaTrack event
  // _rtcPeerConnection!.onTrack = (event) {
  //   pageViewController.animateToPage(
  //     1,
  //     duration: const Duration(milliseconds: 100),
  //     curve: Curves.ease,
  //   );
  //   log('$event EventConnection');
  //   MediaStream srcObject = event.streams[0];
  //   log("${streamLabels.keys}"
  //       'afadfadfdfasdfffffffffffffffffffffffffffffffffffffffff');
  //   for (var key in streamLabels.keys) {
  //     log(streamLabels[key]);
  //     log('${srcObject.id} asdasdasd');
  //     if (streamLabels[key] == srcObject.id) {
  //       if (key == 'webcam') {
  //         log(key + '     webcam       ');
  //         _remoteRTCVideoRenderer.srcObject = srcObject;
  //         setState(() {});
  //       } else {
  //         _remoteRTCVideoRendererScreen.srcObject = srcObject;
  //         setState(() {});
  //       }
  //     }
  //   }
  // };
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
  // }

  var maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  int count = 0;
  String? language;

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/dotted_texture.png'),
                ),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 35,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/logo.svg'),
                        const Spacer(),
                        PopupMenuButton(
                          offset: const Offset(-10, 40),
                          onSelected: (value) {
                            setState(() {
                              language = value.countryCode;
                            });
                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(value);
                          },
                          itemBuilder: (BuildContext context) {
                            return AllLocales.all.map((Locale choice) {
                              language = choice.countryCode;
                              return PopupMenuItem<Locale>(
                                value: choice,
                                child: Text(
                                  choice.countryCode!,
                                ),
                              );
                            }).toList();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.grey2,
                                border: Border.all(color: AppColors.grey2)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 5),
                            child: Text(
                              language ??
                                  AppLocalizations.of(context)!.language,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Text(
                          // 'Закажите кухню своей мечты',
                          AppLocalizations.of(context)!.main_appbar,
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 169),
                        child: Text(
                          // 'Устали от старой кухни? Закажите новую у нас! Нажмите на большую оранжевую кнопку и получите консультацию от нашего менеджера продаж. Он создаст проект кухни для вас и покажет рендер будущей кухни. Закажите кухню сегодня и наслаждайтесь ею уже завтра!',
                          AppLocalizations.of(context)!.main_description,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        height: 740,
                        child: Swiper(
                          controller: _swiperController,
                          onIndexChanged: (index) {
                            setState(() {
                              count = index;
                            });
                          },
                          scale: 0.9,
                          viewportFraction: 0.6,
                          autoplay: true,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(images[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(
                      //     horizontal: 40,
                      //   ),
                      //   height: 500,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Colors.grey,
                      //   ),
                      //   child: Stack(
                      //     children: [
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(12),
                      //         child: RTCVideoView(
                      //           _remoteRTCVideoRenderer,
                      //           objectFit: RTCVideoViewObjectFit
                      //               .RTCVideoViewObjectFitCover,
                      //         ),
                      //       ),
                      //       Positioned(
                      //         right: 65,
                      //         bottom: 65,
                      //         child: SizedBox(
                      //           height: 150,
                      //           width: 150,
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(12),
                      //             child: RTCVideoView(
                      //               _localRTCVideoRenderer,
                      //               mirror: true,
                      //               objectFit: RTCVideoViewObjectFit
                      //                   .RTCVideoViewObjectFitCover,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left: 398,
                      //         bottom: 65,
                      //         child: InkWell(
                      //           onTap: () {
                      //             // disconnectFunction();
                      //           },
                      //           child: SvgPicture.asset(
                      //               'assets/icon/end_call_button.svg'),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left: 540,
                      //         bottom: 65,
                      //         child: InkWell(
                      //           onTap: () {},
                      //           child: SvgPicture.asset(
                      //               'assets/icon/turn_off_micro.svg'),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              _swiperController.move(count - 1);
                            },
                            child: SvgPicture.asset('assets/left_button.svg'),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey,
                            ),
                            width: 4,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey,
                            ),
                            width: 4,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          Text(
                            '${count + 1}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            '/',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            images.length.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey,
                            ),
                            width: 4,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey,
                            ),
                            width: 4,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          InkWell(
                            onTap: () {
                              _swiperController.next();
                            },
                            child: SvgPicture.asset('assets/right_button.svg'),
                          ),
                          const Spacer(),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 100,
                      // ),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                                bottom: 500,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 68, vertical: 60),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        // 'Укажите  ваш номер телефона',
                                        AppLocalizations.of(context)!
                                            .modal_appbar,
                                        style: const TextStyle(
                                          fontSize: 64,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        // 'Согласие на хранение номера телефона позволяет вам восстановить доступ к аккаунту и получать важные обновления и уведомления',
                                        AppLocalizations.of(context)!
                                            .modal_description,

                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 97,
                                      ),
                                      BrTextField(
                                        controller: controller,
                                        lableText: '',
                                        inputFormatters: [maskFormatter],
                                        labelStyle: TextStyles.body
                                            .copyWith(color: AppColors.grey),
                                        textInputType: const TextInputType
                                            .numberWithOptions(),
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      Text(
                                        // 'Согласен на обработку персональных данных',
                                        AppLocalizations.of(context)!
                                            .modal_contract,

                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 97,
                                      ),
                                      const BrDivider(),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BrButton(
                                              color: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.grey,
                                              onPressed: () {
                                                // SignallingService.instance
                                                //     .disconnect();

                                                // setState(() {
                                                //   numberModal = false;
                                                // });

                                                Navigator.pop(context);
                                              },
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .modal_button_close,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          Expanded(
                                            child: BrButton(
                                              onPressed: () async {
                                                // setState(() {
                                                //   numberModal = false;
                                                // });
                                                await navigatorFunction(
                                                  context,
                                                  controller,
                                                  widget.model.idRoom ?? 'null',
                                                  widget.localRTCVideoRenderer,
                                                  widget.remoteRTCVideoRenderer,
                                                  widget
                                                      .remoteRTCVideoRendererScreen,
                                                  widget.pageViewController,
                                                  widget.model,
                                                );
                                                controller.clear();
                                              },
                                              label:
                                                  AppLocalizations.of(context)!
                                                      .modal_button_send,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/button_call.png'),
                            ),
                            borderRadius: BorderRadius.circular(360),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        // 'Нажмите на кнопку',
                        AppLocalizations.of(context)!.main_button,

                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.clear();

    super.dispose();
  }
}

navigatorFunction(
  BuildContext context,
  TextEditingController controller,
  String idRoom,
  RTCVideoRenderer localRTCVideoRenderer,
  RTCVideoRenderer remoteRTCVideoRenderer,
  RTCVideoRenderer remoteRTCVideoRendererScreen,
  PageController pageController,
  MeetingModel model,
) {
  context.read<CallCubit>().startCall(
        controller.text.trim(),
        SignallingService.instance.socket!.id ?? '',
        idRoom,
      );
  context.read<ConnectCubit>().connect(
        controller.text.trim(),
        SignallingService.instance.socket!.id ?? '',
        idRoom,
      );
  Navigator.popAndPushNamed(
    context,
    RoutingConst.expectation,
    arguments: ExpectationArgs(
      mdoel: model,
      localVideo: localRTCVideoRenderer,
      remoteVideo: remoteRTCVideoRenderer,
      remoteVideoScreen: remoteRTCVideoRendererScreen,
      pageViewController: pageController,
    ),
  );
}
