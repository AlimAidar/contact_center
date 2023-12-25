import 'dart:developer';

import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/blocks/bloc/login_bloc.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/dependencies/bramf_hive.dart';
import 'package:contact_center/src/common/dependencies/injection_container.dart';
import 'package:contact_center/src/common/local/function/soket_connect.dart';
import 'package:contact_center/src/common/models/meeting/meeting_model.dart';
import 'package:contact_center/src/common/router/router.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:contact_center/src/screens/call_screen/call_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHive();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

String route = RoutingConst.call;

class _MyAppState extends State<MyApp> {
  dynamic offer;
  String? callerId;
  String? calleeId;
  final socket = SignallingService.instance.socket;

  final RTCVideoRenderer _localRTCVideoRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRTCVideoRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRTCVideoRendererScreen = RTCVideoRenderer();

  MediaStream? _localStream;

  String? managerSocketId;
  int? managerID;
  Map streamLabels = {};

  // media status
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  dynamic incomingSDPOffer;
  PageController pageViewController = PageController(initialPage: 0);
  Dio dioCreate = Dio();
  Dio dioIcecandidate = Dio();
  Dio dioAnswer = Dio();
  final Box meetingHive = Hive.box('meeting_model');
  MeetingModel? meetingModelSend;
  RTCDataChannel? _dataChannel;
  @override
  void initState() {
    socetConnect();

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

  creator() async {
    Response responceCreate = await dioCreate.post(
      'http://192.168.0.200:3000/create_meeting',
    );
    print(responceCreate);
    MeetingModel meetingModel = MeetingModel.fromJson(responceCreate.data);
    meetingModelSend = meetingModel;
    await meetingHive.put('id', meetingModel.id);
    await meetingHive.put('id_room', meetingModel.idRoom);
    log('${meetingModel.idRoom}    ID ROOM');
    await meetingHive.put('sdp', meetingModel.localPeerOffer?.sdp ?? '');
    await meetingHive.put('type', meetingModel.localPeerOffer?.type ?? '');
    await meetingHive.put('ice_candidates', meetingModel.iceCandidates);
    RTCPeerConnection creatorConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': "turn:77.243.80.210:3478",
          'credential': "123",
          'username': "admin",
        },
      ],
    });

    creatorConnection.onIceCandidate = (event) async {
      await dioIcecandidate.post(
        'http://192.168.0.200:3000/post_icecandidate',
        data: {
          'id': meetingModelSend?.id ?? '',
          'id_room': meetingModelSend?.idRoom ?? '',
          'candidate': event.toMap(),
        },
      );
    };

    creatorConnection.onTrack = (event) {
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {});

      log('${event.track} Incoming Track');
    };

    creatorConnection.onDataChannel = (RTCDataChannel channel) {
      if (channel.label == 'ping-pong') {
        setState(() {
          _dataChannel = channel;
          _dataChannel!.onMessage = (RTCDataChannelMessage message) {
            if (message.text == 'pong') {
              log('received pong');
              pageViewController.animateToPage(
                1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            }
          };
        });
      }
    };

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn,
    });
    _localStream!.getTracks().forEach((track) {
      log('$track Local Track');

      creatorConnection.addTrack(track, _localStream!);
      _localRTCVideoRenderer.srcObject = _localStream;
      setState(() {});
    });

    await creatorConnection.setRemoteDescription(
      RTCSessionDescription(
        meetingModelSend!.localPeerOffer?.sdp ?? "",
        meetingModelSend!.localPeerOffer?.type ?? '',
      ),
    );

    RTCSessionDescription peerAnswer = await creatorConnection.createAnswer();
    await creatorConnection.setLocalDescription(
      RTCSessionDescription(
        peerAnswer.sdp,
        peerAnswer.type,
      ),
    );

    await dioAnswer.post(
      "http://192.168.0.200:3000/post_answer",
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
        await creatorConnection.addCandidate(candidate);
      } catch (error) {
        // Handle error, this will be rejected very often
        log('${error}Errorrrr');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(
              //   create: (context) => CreateMeetingCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => PostAnswerCubit(),
              // ),
              // BlocProvider(
              //   create: (context) => PostIceCandidateCubit(),
              // ),
              BlocProvider(
                create: (context) => LoginBloc(authService: getIt()),
              ),
              BlocProvider(
                create: (context) => CallCubit(service: getIt()),
              ),
              BlocProvider(
                create: (context) => ConnectCubit(service: getIt()),
              ),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.yellow,
                ),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Provider.of<LocaleProvider>(context).locale,
                home: CallScreen(
                  remoteRTCVideoRenderer: _remoteRTCVideoRenderer,
                  localRTCVideoRenderer: _localRTCVideoRenderer,
                  remoteRTCVideoRendererScreen: _remoteRTCVideoRendererScreen,
                  model: meetingModelSend ?? MeetingModel(),
                  pageViewController: pageViewController,
                ),
                onGenerateRoute: MetaRouter.onGenerateRoute,
                ),
          );
        });
  }
}
