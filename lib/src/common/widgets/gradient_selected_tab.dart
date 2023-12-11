import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

class GradientSelectorTab extends StatefulWidget {
  const GradientSelectorTab({
    Key? key,
    required this.onSelected,
    required this.selectedIndex,
    required this.tabs,
    required this.index,
    this.textColorIndex,
    this.textColor,
    this.color,
    this.indexColor,
    this.borderindexColor,
    this.borderColor,
    this.gradientColor,
  }) : super(key: key);

  final Function(int selectedIndex) onSelected;
  final int selectedIndex;
  final String tabs;
  final int index;
  final Color? textColorIndex;
  final Color? textColor;
  final Color? color;
  final Color? indexColor;
  final Color? borderindexColor;
  final Color? borderColor;
  final List<Color>? gradientColor;

  @override
  State<GradientSelectorTab> createState() => _BrSelectorTab();
}

class _BrSelectorTab extends State<GradientSelectorTab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(widget.index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: widget.selectedIndex == widget.index
                  ? widget.gradientColor ??
                      [AppColors.orange2, AppColors.orange1]
                  : [
                      AppColors.grey2,
                      AppColors.grey2,
                    ]),
          border: Border.all(
            color: widget.selectedIndex == widget.index
                ? widget.borderindexColor ?? Colors.white
                : widget.borderColor ?? Colors.white,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            widget.tabs,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyles.body.copyWith(
              color: widget.selectedIndex == widget.index
                  ? widget.textColorIndex ?? Colors.white
                  : widget.textColor ?? AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
