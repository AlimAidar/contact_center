import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/screens/review/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map> items = [
      {
        'image': 'assets/emoji/bad.png',
        'name': AppLocalizations.of(context)!.review_very_bad,
      },
      {
        'image': 'assets/emoji/bad2.png',
        'name': AppLocalizations.of(context)!.review_bad,
      },
      {
        'image': 'assets/emoji/normal.png',
        'name': AppLocalizations.of(context)!.review_normal,
      },
      {
        'image': 'assets/emoji/good.png',
        'name': AppLocalizations.of(context)!.review_good,
      },
      {
        'image': 'assets/emoji/good2.png',
        'name': AppLocalizations.of(context)!.review_very_good,
      },
    ];
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
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
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
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutingConst.call,
                          (route) => false,
                        );
                      },
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
      ),
    );
  }
}
