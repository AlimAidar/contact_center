import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

class TwSelectorTab extends StatefulWidget {
  const TwSelectorTab({
    Key? key,
    required this.onSelected,
    required this.selectedIndex,
    required this.tabs,
    required this.index,
    this.textColorIndex,
    this.step,
    this.textColor,
    this.color,
    this.indexColor,
    this.borderindexColor,
    this.borderColor,
    this.gradientColor,
  }) : super(key: key);

  final Function(int selectedIndex) onSelected;
  final int selectedIndex;
  final List<String> tabs;
  final int index;
  final Color? textColorIndex;
  final Color? textColor;
  final Color? color;
  final Color? indexColor;
  final Color? borderindexColor;
  final Color? borderColor;
  final List<Color>? gradientColor;
  final List<int>? step;

  @override
  State<TwSelectorTab> createState() => _BrSelectorTab();
}

class _BrSelectorTab extends State<TwSelectorTab> {
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            disabledElevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: widget.selectedIndex == widget.index
                    ? widget.borderindexColor ?? Colors.white
                    : widget.borderColor ?? Colors.white,
              ),
              borderRadius: BorderRadius.only(
                topLeft: widget.index == 0
                    ? const Radius.circular(100)
                    : Radius.zero,
                bottomLeft: widget.index == 0
                    ? const Radius.circular(100)
                    : Radius.zero,
                topRight: widget.index + 1 == widget.tabs.length
                    ? const Radius.circular(100)
                    : Radius.zero,
                bottomRight: widget.index + 1 == widget.tabs.length
                    ? const Radius.circular(100)
                    : Radius.zero,
              ),
            ),
            color: widget.selectedIndex == widget.index
                ? widget.indexColor ?? AppColors.black
                : widget.color ?? Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.step == null
                      ? const Offstage()
                      : Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 1),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [AppColors.orange2, AppColors.orange1]),
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Text(
                            '${widget.step![widget.index]}',
                            style: TextStyles.heading
                                .copyWith(color: Colors.white),
                          ),
                        ),
                  Text(
                    widget.tabs[widget.index],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyles.body.copyWith(
                      color: widget.selectedIndex == widget.index
                          ? widget.textColorIndex ?? Colors.white
                          : widget.textColor ?? AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              widget.onSelected(widget.index);
            },
          );
  }
}
