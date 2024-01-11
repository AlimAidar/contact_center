import 'package:contact_center/src/common/widgets/br_button.dart';
import 'package:contact_center/src/common/widgets/br_text_field.dart';
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
  final PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Map> items = [
      {
        'image': 'assets/emoji/bad.png',
        'name': AppLocalizations.of(context)!.review_very_bad,
        'on_pressed': () {
          pageViewController.animateToPage(
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
          pageViewController.animateToPage(
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
          Navigator.pop(context);
        }
      },
      {
        'image': 'assets/emoji/good.png',
        'name': AppLocalizations.of(context)!.review_good,
        'on_pressed': () {
          Navigator.pop(context);
        }
      },
      {
        'image': 'assets/emoji/good2.png',
        'name': AppLocalizations.of(context)!.review_very_good,
        'on_pressed': () {
                    Navigator.pop(context);

        }
      },
    ];
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageViewController,
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
                      Navigator.pop(context);
                    },
                    label: AppLocalizations.of(context)!.review_very_bad_send,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
