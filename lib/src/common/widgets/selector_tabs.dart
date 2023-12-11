import 'package:contact_center/src/common/widgets/selector_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwSelectorTabs extends StatefulWidget {
  const TwSelectorTabs({
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
  State<TwSelectorTabs> createState() => _BrSelectorTabs();
}

class _BrSelectorTabs extends State<TwSelectorTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 45,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        reverse: widget.reverse,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              index == 0
                  ? const SizedBox(
                      width: 12,
                    )
                  : const Offstage(),
              TwSelectorTab(
                step: widget.step,
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
                tabs: widget.tabs,
              ),
              index.isOdd
                  ? const SizedBox(
                      width: 12,
                    )
                  : const Offstage(),
            ],
          );
        },
      ),
    );
  }
}
