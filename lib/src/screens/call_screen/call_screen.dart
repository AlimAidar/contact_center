import 'dart:convert';
import 'dart:developer';
import 'package:contact_center/src/common/models/manager/manager_list_model.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:contact_center/src/common/local/function/soket_connect.dart';
import 'package:contact_center/src/common/models/meeting/meeting_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/constants/text_styles.dart';
import 'package:contact_center/src/common/local/expectation_args.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/common/widgets/br_button.dart';
import 'package:contact_center/src/common/widgets/br_divider.dart';
import 'package:contact_center/src/common/widgets/br_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  List<String> images = [
    'assets/gallery/gellary_item_1.png',
    'assets/gallery/gellary_item_2.png',
    'assets/gallery/gellary_item_3.png',
  ];
  TextEditingController controllerNumber = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  dynamic offer;
  final socket = SignallingService.instance.socket;

  final RTCVideoRenderer _localRTCVideoRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRTCVideoRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRTCVideoRendererScreen = RTCVideoRenderer();

  MediaStream? _localStream;

  bool isAudioOn = true, isVideoOn = true;
  PageController pageViewExpectation = PageController();
  PageController callPageView = PageController();
  Dio dioCreate = Dio();
  Dio dioIcecandidate = Dio();
  Dio dioAnswer = Dio();
  Dio dioManager = Dio();
  Dio dioManagerList = Dio();
  final Box meetingHive = Hive.box('meeting_model');
  MeetingModel? meetingModelSend;
  RTCDataChannel? _dataChannel;
  RTCDataChannel? _dataChannel2;
  RTCDataChannel? _dataChannel3;
  RTCPeerConnection? creatorConnection;
  Map managerData = {};
  int selectedTab = 0;
  int selectedLanguage = 0;
  bool isSelected = true;
  Color colorLanguage = AppColors.grey;
  final GlobalKey _formKey = GlobalKey();
  ManagerListModel? modelManager;
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

  @override
  void initState() {
    socetConnect();
    // managerList();
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRendererScreen.initialize();
    _remoteRTCVideoRenderer.initialize();
    WidgetsFlutterBinding.ensureInitialized();
    creator();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  navigatorFunction() {
    Navigator.pushNamed(
      context,
      RoutingConst.expectation,
      arguments: ExpectationArgs(
        managerData: managerData,
        idRoom: meetingModelSend?.idRoom ?? 'null',
        mdoel: meetingModelSend!,
        creatorConnection: creatorConnection,
        localVideo: _localRTCVideoRenderer,
        remoteVideo: _remoteRTCVideoRenderer,
        remoteVideoScreen: _remoteRTCVideoRendererScreen,
        pageViewController: pageViewExpectation,
      ),
    );
    callPageView.animateToPage(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.ease,
    );
  }

  // managerList() async {
  //   Response res = await dioManager.post(
  //     'http://192.168.0.49:8080/api/login',
  //     queryParameters: {
  //       'login': 'test',
  //       'password': 'Admin0912',
  //     },
  //   );
  //   ManagerTokenModel token = ManagerTokenModel.fromJson(res.data);
  //   Response response = await dioManagerList.get(
  //     'http://192.168.0.49:8080/api/workflow/users',
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer ${token.accessToken}',
  //       },
  //     ),
  //   );
  //   ManagerListModel model = ManagerListModel.fromJson(response.data);
  //   modelManager   = model;
  //   log(response.data);
  // }

  creator() async {
    Response responceCreate = await dioCreate.post(
      'http://79.142.54.85:3000/meeting',
    );
    MeetingModel meetingModel = MeetingModel.fromJson(responceCreate.data);
    meetingModelSend = meetingModel;
    await meetingHive.put('id', meetingModel.id);
    await meetingHive.put('id_room', meetingModel.idRoom);
    await meetingHive.put('sdp', meetingModel.localPeerOffer?.sdp ?? '');
    await meetingHive.put('type', meetingModel.localPeerOffer?.type ?? '');
    await meetingHive.put('ice_candidates', meetingModel.iceCandidates);
    creatorConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': "turn:77.243.80.210:3478",
          'credential': "123",
          'username': "admin",
        },
      ],
    });

    creatorConnection!.onIceCandidate = (event) async {
      await dioIcecandidate.post(
        'http://79.142.54.85:3000/post_icecandidate',
        data: {
          'id': meetingModelSend?.id ?? '',
          'id_room': meetingModelSend?.idRoom ?? '',
          'candidate': event.toMap(),
        },
      );
    };

    List<MediaStream> incomingStreams = [];
    creatorConnection!.onTrack = (RTCTrackEvent event) {
      for (MediaStream stream in event.streams) {
        incomingStreams.add(stream);
      }
      setState(() {});
    };

    creatorConnection!.onDataChannel = (RTCDataChannel channel) {
      log(channel.label.toString());
      if (channel.label == 'ping-pong') {
        _dataChannel = channel;
        _dataChannel!.onMessage = (RTCDataChannelMessage message) {
          log('pong');
          if (message.text == 'pong') {}
        };
      } else if (channel.label == 'track_labels') {
        channel.onMessage = (RTCDataChannelMessage message) {
          Map<String, dynamic> parsedMap = json.decode(message.text);

          for (var entry in parsedMap.entries) {
            String outerKey = entry.key;
            Map<String, dynamic> innerMap = entry.value;

            for (var innerEntry in innerMap.entries) {
              String streamId = innerEntry.value;

              MediaStream? matchingStream = incomingStreams.firstWhere(
                (stream) => stream.id == streamId,
              );

              if (outerKey == 'camera') {
                _remoteRTCVideoRenderer.srcObject = matchingStream;
              } else if (outerKey == 'screen') {
                _remoteRTCVideoRendererScreen.srcObject = matchingStream;
              }
            }
          }
        };
      } else if (channel.label == "leave") {
        _dataChannel2 = channel;
        _dataChannel2!.onMessage = (RTCDataChannelMessage message) {
          log('close call');
          setState(() {
            pageViewExpectation.animateToPage(
              1,
              duration: const Duration(milliseconds: 100),
              curve: Curves.ease,
            );
          });
        };
      } else if (channel.label == "client_info") {
        _dataChannel3 = channel;
        _dataChannel3!.onMessage = (RTCDataChannelMessage message) {
          log('clien state');
          setState(() {
            managerData = json.decode(message.text);
          });
          log(message.text);
          if (message.text != '{}') {
            log('navigator true');
            navigatorFunction();
          }
        };
      }
    };

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn,
    });
    _localStream!.getTracks().forEach((track) {
      creatorConnection!.addTrack(track, _localStream!);
      _localRTCVideoRenderer.srcObject = _localStream;
      setState(() {});
    });

    await creatorConnection!.setRemoteDescription(
      RTCSessionDescription(
        meetingModelSend!.localPeerOffer?.sdp ?? "",
        meetingModelSend!.localPeerOffer?.type ?? '',
      ),
    );

    RTCSessionDescription peerAnswer = await creatorConnection!.createAnswer();
    await creatorConnection!.setLocalDescription(
      RTCSessionDescription(
        peerAnswer.sdp,
        peerAnswer.type,
      ),
    );

    await dioAnswer.post(
      "http://79.142.54.85:3000/post_answer",
      data: {
        'id': meetingModelSend?.id ?? '',
        'id_room': meetingModelSend?.idRoom ?? '',
        "answer": peerAnswer.toMap(),
      },
    );
    for (Map candidteInner in meetingHive.get('ice_candidates')) {
      try {
        RTCIceCandidate candidate = RTCIceCandidate(
          candidteInner['candidate'],
          candidteInner['sdpMid'],
          candidteInner['sdpMLineIndex'],
        );
        await creatorConnection!.addCandidate(candidate);
      } catch (error) {
        // Handle error, this will be rejected very often
      }
    }
    // if (creatorConnection != null) {
    //   creatorConnection!.onIceConnectionState = (state) {
    //     log(creatorConnection!.iceConnectionState.toString());

    //     switch (state) {
    //       case RTCIceConnectionState.RTCIceConnectionStateChecking:
    //         break;

    //       case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
    //         break;

    //       case RTCIceConnectionState.RTCIceConnectionStateConnected:
    //         break;

    //       default:
    //         break;
    //     }
    //   };
    // }
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  int count = 0;
  String? language;

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: callPageView,
          children: [
            Stack(
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/logo.svg'),
                            const Spacer(),
                            SizedBox(
                              width: 250,
                              height: 40,
                              child: Selector<LocaleProvider, Locale>(
                                selector: (context, provider) =>
                                    provider.locale,
                                builder: (context, currentLocale, _) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: AllLocales.all.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Locale choice = AllLocales.all[index];
                                      bool isSelected =
                                          index == selectedLanguage;

                                      return InkWell(
                                        onTap: () {
                                          Provider.of<LocaleProvider>(context,
                                                  listen: false)
                                              .setLocale(choice);
                                          setState(() {
                                            selectedLanguage = index;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isSelected
                                                ? AppColors.orange
                                                : colorLanguage,
                                            border: Border.all(
                                              color: AppColors.grey2,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 5),
                                          child: Text(
                                            choice.countryCode!,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 120),
                            child: Text(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 169),
                            child: Text(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  _swiperController.move(count - 1);
                                },
                                child:
                                    SvgPicture.asset('assets/left_button.svg'),
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
                                child:
                                    SvgPicture.asset('assets/right_button.svg'),
                              ),
                              const Spacer(),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Form(
                                  key: _formKey,
                                  child: Padding(
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
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
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
                                              validator: (password) {
                                                if (password == null ||
                                                    password.trim().isEmpty) {
                                                  return 'Поле должно быть заполнено';
                                                } else {
                                                  // bool isValid = password.trim().length >= 8;
                                                  // return isValid ? null : 'Пароль слишком короткий';
                                                }
                                                return null;
                                              },
                                              controller: controllerNumber,
                                              placeholder: '+_ (___) ___-__-__',
                                              inputFormatters: [maskFormatter],
                                              hintStyle: TextStyles.body
                                                  .copyWith(
                                                      color: AppColors.grey3
                                                          .withOpacity(0.5)),
                                              textInputType: const TextInputType
                                                  .numberWithOptions(),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            BrTextField(
                                              // validator: (password) {
                                              //   if (password == null ||
                                              //       password.trim().isEmpty) {
                                              //     return 'Поле должно быть заполнено';
                                              //   } else {
                                              //     // bool isValid = password.trim().length >= 8;
                                              //     // return isValid ? null : 'Пароль слишком короткий';
                                              //   }
                                              //   return null;
                                              // },
                                              controller: controllerName,
                                              placeholder: 'Имя',
                                              hintStyle: TextStyles.body
                                                  .copyWith(
                                                      color: AppColors.grey3
                                                          .withOpacity(0.5)),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '   *Необязательно',
                                              style: TextStyles.description
                                                  .copyWith(
                                                      color: AppColors.orange1,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 36,
                                            ),
                                            Text(
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
                                                      Navigator.pop(context);
                                                      controllerNumber.clear();
                                                      controllerName.clear();
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .modal_button_close,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 60,
                                                ),
                                                BlocConsumer<CallCubit,
                                                    CallState>(
                                                  listener: (context, state) {
                                                    if (state is CallLoaded) {
                                                      callPageView
                                                          .animateToPage(
                                                        1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        curve: Curves.ease,
                                                      );
                                                      Navigator.pop(context);
                                                      controllerNumber.clear();
                                                      controllerName.clear();
                                                    } else if (state
                                                        is CallFailed) {
                                                      showCupertinoModalPopup(
                                                        context: context,
                                                        builder: (context) {
                                                          return CupertinoAlertDialog(
                                                            title: const Text(
                                                                'Ошибка'),
                                                            content: Text(
                                                                state.message),
                                                            actions: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 15,
                                                                ),
                                                                child: BrButton(
                                                                  label: 'Ok',
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return Expanded(
                                                      child: BrButton(
                                                        onPressed:
                                                            state is CallLoading
                                                                ? null
                                                                : () {
                                                                    FormState?
                                                                        formState =
                                                                        _formKey.currentState
                                                                            as FormState;
                                                                    if (formState
                                                                        .validate()) {
                                                                      context
                                                                          .read<
                                                                              CallCubit>()
                                                                          .startCall(
                                                                            controllerNumber.text.trim(),
                                                                            meetingModelSend?.idRoom ??
                                                                                'null',
                                                                            controllerName.text,
                                                                          );
                                                                      context
                                                                          .read<
                                                                              ConnectCubit>()
                                                                          .connect(
                                                                            controllerNumber.text.trim(),
                                                                            meetingModelSend?.idRoom ??
                                                                                'null',
                                                                          );
                                                                    }
                                                                  },
                                                        label: AppLocalizations
                                                                .of(context)!
                                                            .modal_button_send,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerNumber.clear();

    super.dispose();
  }
}
