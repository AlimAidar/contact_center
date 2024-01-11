import 'dart:async';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/src/common/blocks/cubit/cubit/update_id_cubit.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:contact_center/src/common/widgets/br_button.dart';
import 'package:contact_center/src/common/widgets/br_text_field.dart';
import 'package:contact_center/src/common/widgets/gradient_selected_tabs.dart';
import 'package:contact_center/src/screens/review/widgets/review_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    required this.creatorConnection,
    required this.idRoom,
    required this.managerData,
  }) : super(key: key);
  final PageController pageViewController;
  final RTCVideoRenderer localRTCVideoRenderer;
  final RTCPeerConnection? creatorConnection;
  final String idRoom;
  final Map managerData;
  // videoRenderer for remotePeer
  final RTCVideoRenderer remoteRTCVideoRenderer;
  final RTCVideoRenderer remoteRTCVideoRendererScreen;

  @override
  State<ExpectationScreen> createState() => _ExpectationScreenState();
}

closeExpaction(
  BuildContext context,
  final RTCPeerConnection creatorConnection,
  String idRoom,
) async {
  await context
      .read<UpdateIdCubit>()
      .updateSocket(SignallingService.instance.socket?.id ?? '', idRoom);
  RTCDataChannel closeCallChannel;

  RTCDataChannelInit dataChannelOptions = RTCDataChannelInit();
  closeCallChannel = await creatorConnection.createDataChannel(
      "CloseCall", dataChannelOptions);

  closeCallChannel.onMessage = (RTCDataChannelMessage event) {
    String data = event.text;
    log('CloseCall channel received msg $data');
  };

  closeCallChannel.send(
    RTCDataChannelMessage("Hello, CloseCall!"),
  );
}

int textType = 0;

class _ExpectationScreenState extends State<ExpectationScreen> {
  Dio dioCreate = Dio();

  List<Map> imagesMaterial = [
    {
      'image': 'assets/materials/black_mramor.png',
      'article': 'Темный гранит',
    },
    {
      'image': 'assets/materials/dark_wood.png',
      'article': 'Капучино KP  ',
    },
    {
      'image': 'assets/materials/mutniy_granit.png',
      'article': 'Дымчато голубой DG  ',
    },
    {
      'image': 'assets/materials/white_mramor.png',
      'article': 'Хромикс белый HBE  ',
    },
  ];
  List<Map> imagesMaterial2 = [
    {
      'image': 'assets/materials/black_mramor.png',
      'article': 'Темный гранит ',
    },
    {
      'image': 'assets/materials/black_mramor.png',
      'article': 'Темный гранит PT',
    },
    {
      'image': 'assets/materials/dark_wood.png',
      'article': 'Капучино KP  ',
    },
    {
      'image': 'assets/materials/black_mramor.png',
      'article': 'Темный гранит PT ',
    },
    {
      'image': 'assets/materials/mutniy_granit.png',
      'article': 'Дымчато голубой DG  ',
    },
    {
      'image': 'assets/materials/white_mramor.png',
      'article': 'Хромикс белый HBE  ',
    },
  ];
  List<Map> imagesMaterial3 = [
    {
      'image': 'assets/materials/dark_wood.png',
      'article': 'Капучино KP  ',
    },
    {
      'image': 'assets/materials/black_mramor.png',
      'article': 'Темный гранит PT',
    },
    {
      'image': 'assets/materials/white_mramor.png',
      'article': 'Хромикс белый HBE  ',
    },
    {
      'image': 'assets/materials/mutniy_granit.png',
      'article': 'Дымчато голубой DG  ',
    },
  ];

  final PageController pageViewController2 = PageController();
  static const _timerDuration = 5;
  final StreamController _timerStream = StreamController<int>();
  int? timerCounter;
  Timer? _resendCodeTimer;
  final FocusNode _focusNode = FocusNode();
  int selectedIndex = 0;
  bool isAudio = true;

  activeCounter() {
    _resendCodeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_timerDuration - timer.tick > 0) {
          _timerStream.sink.add(_timerDuration - timer.tick);
        } else {
          _timerStream.sink.add(0);
          _resendCodeTimer!.cancel();
        }
      },
    );
    Timer.periodic(
      const Duration(seconds: 6),
      (timer) {
        Navigator.pop(context);
      },
    );
  }

  void muteAudio() {
    setState(() {
      isAudio = !isAudio;
    });
    widget.localRTCVideoRenderer.srcObject!.getAudioTracks().forEach((track) {
      track.enabled = !track.enabled;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  closeKeyboard() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> items = [
      {
        'image': 'assets/emoji/bad.png',
        'name': AppLocalizations.of(context)!.review_very_bad,
        'on_pressed': () {
          setState(() {
            textType = 1;
          });
          pageViewController2.animateToPage(
            1,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
      {
        'image': 'assets/emoji/bad2.png',
        'name': AppLocalizations.of(context)!.review_bad,
        'on_pressed': () {
          setState(() {
            textType = 1;
          });
          pageViewController2.animateToPage(
            1,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
      {
        'image': 'assets/emoji/normal.png',
        'name': AppLocalizations.of(context)!.review_normal,
        'on_pressed': () {
          activeCounter();
          setState(() {
            textType = 0;
          });
          pageViewController2.animateToPage(
            2,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
      {
        'image': 'assets/emoji/good.png',
        'name': AppLocalizations.of(context)!.review_good,
        'on_pressed': () {
          activeCounter();
          setState(() {
            textType = 0;
          });
          pageViewController2.animateToPage(
            2,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
      {
        'image': 'assets/emoji/good2.png',
        'name': AppLocalizations.of(context)!.review_very_good,
        'on_pressed': () {
          activeCounter();
          setState(() {
            textType = 0;
          });
          pageViewController2.animateToPage(
            2,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        }
      },
    ];
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 25),
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
                              widget.managerData['photo'] != null
                                  ? Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            widget.managerData['photo'],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        image: const DecorationImage(
                                          image:
                                              AssetImage('assets/no_photo.png'),
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
                              Text(
                                widget.managerData['username'] ?? 'Нет данных',
                                style: const TextStyle(
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
                          BlocListener<UpdateIdCubit, UpdateIdState>(
                            listener: (context, state) {
                              if (state is UpdateIdLoaded) {
                                widget.pageViewController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: Positioned(
                              left: 398,
                              bottom: 65,
                              child: InkWell(
                                onTap: () async {
                                  await closeExpaction(context,
                                      widget.creatorConnection!, widget.idRoom);
                                },
                                child: SvgPicture.asset(
                                    'assets/icon/end_call_button.svg'),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 540,
                            bottom: 65,
                            child: InkWell(
                              onTap: () {
                                muteAudio();
                              },
                              child: isAudio
                                  ? SvgPicture.asset(
                                      'assets/icon/turn_on_micro.svg')
                                  : SvgPicture.asset(
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
                                height: 300,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 250,
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
                                height: 300,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                imagesMaterial2[index]['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          imagesMaterial2[index]['article'],
                                        )
                                      ],
                                    );
                                  },
                                  scale: 1,
                                  viewportFraction: 0.2,
                                  autoplay: true,
                                  itemCount: imagesMaterial2.length,
                                ),
                              )
                            : const Offstage(),
                        selectedIndex == 2
                            ? Container(
                                height: 300,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Swiper(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                imagesMaterial3[index]['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          imagesMaterial3[index]['article'],
                                        )
                                      ],
                                    );
                                  },
                                  scale: 1,
                                  viewportFraction: 0.2,
                                  autoplay: true,
                                  itemCount: imagesMaterial3.length,
                                ),
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Scaffold(
              body: PageView(
                controller: pageViewController2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/dotted_texture.png'),
                      ),
                    ),
                    child: Column(
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
                        Text(
                          // 'Как все прошло? Поделитесь с нами впечатлениями, это важно для нас',
                          AppLocalizations.of(context)!.review_main,

                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 165,
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                onPressed: items[index]['on_pressed'],
                                image: items[index]['image'],
                                name: items[index]['name'],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 30,
                              );
                            },
                            itemCount: items.length,
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/emoji/bad.png'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          AppLocalizations.of(context)!.review_very_bad_title,
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 300),
                          child: BrTextField(
                            focusNode: _focusNode,
                            placeholder: AppLocalizations.of(context)!
                                .review_very_bad_text_field,
                            isExpanded: true,
                            enableBorderColor: Colors.transparent,
                            borderColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        BrButton(
                          onPressed: () {
                            activeCounter();
                            closeKeyboard();
                            pageViewController2.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease,
                            );
                          },
                          label: AppLocalizations.of(context)!
                              .review_very_bad_send,
                        )
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                          ),
                          child: textType != 0
                              ? const Text(
                                  'Благодарим за Ваш отзыв. Мы доверяем мнению наших клиентов и внимательно следим за обратной связью.',
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : const Text(
                                  'Благодарим за Ваш отзыв! ',
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        StreamBuilder(
                          stream: _timerStream.stream,
                          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                            return BrButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              labelWidget: Text(
                                'Закрыть (${snapshot.hasData ? snapshot.data.toString() : 5})',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                        // BrButton(
                        //   onPressed: () {
                        //     Timer.periodic(const Duration(seconds: 5), (timer) {
                        //       Navigator.pop(context);
                        //     });
                        //   },
                        //   label: AppLocalizations.of(context)!
                        //       .review_very_bad_send,
                        // )
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
