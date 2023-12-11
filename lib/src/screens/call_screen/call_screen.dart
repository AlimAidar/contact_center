import 'package:card_swiper/card_swiper.dart';
import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/blocks/bloc/login_bloc.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/constants/text_styles.dart';
import 'package:contact_center/src/common/local/function/soket_connect.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/common/services/signalling.service.dart';
import 'package:contact_center/src/common/widgets/br_button.dart';
import 'package:contact_center/src/common/widgets/br_divider.dart';
import 'package:contact_center/src/common/widgets/br_text_field.dart';
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
  bool numberModal = false;
  TextEditingController controller = TextEditingController();

// generate callerID of local user
  @override
  void initState() {
    context.read<LoginBloc>().add(
          LoginPressed(
            email: 'touchpoint',
            password: '670894439',
          ),
        );

    super.initState();
  }

  // }

  var maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  int count = 0;
  String? language;
  String languageImage = 'assets/russia.png';

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
                          offset: const Offset(-80, 70),
                          onSelected: (value) {
                            if (value.countryCode == 'Русский') {
                              setState(() {
                                languageImage = 'assets/russia.png';
                              });
                            } else if (value.countryCode == 'Казакша') {
                              setState(() {
                                languageImage = 'assets/kazakh.png';
                              });
                            } else if (value.countryCode == "English") {
                              setState(() {
                                languageImage = 'assets/english.png';
                              });
                            }
                            setState(() {
                              language = value.countryCode;
                            });
                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(value);
                          },
                          itemBuilder: (BuildContext context) {
                            return AllLocales.all.map((Locale choice) {
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                        languageImage,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                const Text(
                                  'Язык: ',
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  language ?? 'Русский',
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
                          socetConnect();
                          setState(() {
                            numberModal = true;
                          });
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
            numberModal
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 68, vertical: 60),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            // 'Укажите  ваш номер телефона',
                            AppLocalizations.of(context)!.modal_appbar,
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
                            AppLocalizations.of(context)!.modal_description,

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
                            labelStyle:
                                TextStyles.body.copyWith(color: AppColors.grey),
                            textInputType:
                                const TextInputType.numberWithOptions(),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Text(
                            // 'Согласен на обработку персональных данных',
                            AppLocalizations.of(context)!.modal_contract,

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
                                    SignallingService.instance.disconnect();

                                    setState(() {
                                      numberModal = false;
                                    });
                                  },
                                  label: AppLocalizations.of(context)!
                                      .modal_button_close,
                                ),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Expanded(
                                child: BrButton(
                                  onPressed: () async {
                                    setState(() {
                                      numberModal = false;
                                    });
                                    context.read<CallCubit>().startCall(
                                          controller.text.trim(),
                                          SignallingService
                                                  .instance.socket!.id ??
                                              '',
                                        );
                                    context.read<ConnectCubit>().connect(
                                          controller.text.trim(),
                                          SignallingService
                                                  .instance.socket!.id ??
                                              '',
                                        );
                                    Navigator.pushNamed(
                                      context,
                                      RoutingConst.expectation,
                                    );
                                  },
                                  label: AppLocalizations.of(context)!
                                      .modal_button_send,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const Offstage(),
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
