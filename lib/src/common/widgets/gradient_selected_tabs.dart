import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gradient_selected_tab.dart';

class GradientSelectorTabs extends StatefulWidget {
  const GradientSelectorTabs({
    Key? key,
    required this.onSelected,
    required this.tabs,
    this.readOnly = false,
    this.textColorIndex,
    this.textColor,
    this.color,
    this.step,
    this.indexColor,
    this.borderindexColor,
    this.borderColor,
    this.selectedIndex,
    this.height,
    this.reverse = false,
  }) : super(key: key);

  final Function(int selectedIndex) onSelected;
  final List<String> tabs;
  final bool readOnly;
  final bool reverse;
  final int? selectedIndex;
  final Color? textColorIndex;
  final Color? textColor;
  final Color? color;
  final Color? indexColor;
  final Color? borderindexColor;
  final Color? borderColor;
  final List<int>? step;
  final double? height;

  @override
  State<GradientSelectorTabs> createState() => _BrSelectorTabs();
}

class _BrSelectorTabs extends State<GradientSelectorTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return GradientSelectorTab(
            borderColor: widget.borderColor,
            borderindexColor: widget.borderindexColor,
            textColor: widget.textColor,
            color: widget.color,
            indexColor: widget.indexColor,
            textColorIndex: widget.textColorIndex,
            index: index,
            onSelected: (int index) {
              if (!widget.readOnly) {
                widget.onSelected(index);
                setState(() {
                  selectedIndex = index;
                });
              }
            },
            selectedIndex: widget.selectedIndex ?? selectedIndex,
            tabs: widget.tabs[index],
          );
        }),
        separatorBuilder: (context, index) {
          return const Offstage();
        },
        itemCount: widget.tabs.length,
      ),
    );
  }
}
