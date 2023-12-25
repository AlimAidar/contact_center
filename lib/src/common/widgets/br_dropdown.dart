import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:contact_center/src/common/constants/text_styles.dart';
import 'package:contact_center/src/common/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BrDropdown extends StatefulWidget {
  BrDropdown({
    Key? key,
    required this.content,
    this.width = 150,
    this.menuWidth,
    this.readonly = true,
    this.unmutable = false,
    this.defaultValue = 'Нажмите',
    this.buttonPadding = const EdgeInsets.all(20),
    this.contentPadding = const EdgeInsets.all(20),
    this.childrenNodes = const <FocusNode>[],
    required this.focusNode,
    this.fillColor,
    this.valueColor,
    this.icon,
    this.controller,
    this.onTextChanged,
    this.decoration,
    this.borderColor,
    this.isRightAligned = false,
    this.dropDownTextStyle,
    this.borderRadius,
    this.hoverColor,
    this.hintTextStyle,
    this.iconPadding,
    this.enableBottomModal = false,
    this.menuHeight,
    this.height,
  })  : _type = IcDropdownType.standart,
        super(key: key);

  BrDropdown.inner({
    Key? key,
    required this.content,
    this.width = 150,
    this.menuWidth,
    this.readonly = true,
    this.unmutable = false,
    this.defaultValue = 'Нажмите',
    this.buttonPadding = const EdgeInsets.all(20),
    this.contentPadding = const EdgeInsets.all(20),
    this.childrenNodes = const <FocusNode>[],
    required this.focusNode,
    this.fillColor,
    this.valueColor,
    this.icon,
    this.controller,
    this.decoration,
    this.borderColor,
    this.hoverColor,
    this.onTextChanged,
    this.isRightAligned = false,
    this.dropDownTextStyle,
    this.borderRadius,
    this.hintTextStyle,
    this.iconPadding,
    this.enableBottomModal = false,
    this.menuHeight,
    this.height,
  })  : _type = IcDropdownType.inner,
        super(key: key);

  final InputDecoration? decoration;
  final double? iconPadding;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hoverColor;
  final Color? valueColor;
  final Widget? icon;
  final Widget content;
  final LayerLink layerLink = LayerLink();
  final double? width;
  final double? height;
  final double? menuWidth;
  final double? menuHeight;
  final bool readonly;
  final bool unmutable;
  final String defaultValue;
  final EdgeInsets buttonPadding;
  final EdgeInsets contentPadding;
  final List<FocusNode> childrenNodes;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final Function(String)? onTextChanged;
  final bool isRightAligned;
  final TextStyle? dropDownTextStyle;
  final TextStyle? hintTextStyle;
  final BorderRadius? borderRadius;
  final bool enableBottomModal;

  final IcDropdownType _type;

  @override
  State<BrDropdown> createState() => _BrDropdownState();
}

class _BrDropdownState extends State<BrDropdown> {
  OverlayEntry? _overlayEntry;
  bool isDropped = false;

  void childrenListener() {
    if (mounted) {
      bool isChild = widget.childrenNodes.any((element) => element.hasFocus);
      if (!isChild) {
        _overlayEntry?.remove();
        setState(() {
          isDropped = false;
        });
      }
    }
  }

  void dropdownListener() {
    if (mounted) {
      if (widget.focusNode.hasFocus &&
          !widget.unmutable &&
          (ResponsiveWidget.isSmallScreen(context) ||
              !widget.enableBottomModal)) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Size size = renderBox.size;
        _overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: -50,
            width: widget.menuWidth ?? size.width,
            height: widget.menuHeight,
            child: CompositedTransformFollower(
              showWhenUnlinked: false,
              targetAnchor: widget.isRightAligned
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              offset:
                  Offset(widget.isRightAligned ? -widget.menuWidth! : 0, 10),
              link: widget.layerLink,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: widget.contentPadding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(.1),
                        blurRadius: 50,
                        spreadRadius: 0,
                        offset: const Offset(-30, 30),
                      ),
                    ],
                  ),
                  child: widget.content,
                ),
              ),
            ),
          ),
        );
        Overlay.of(context).insert(_overlayEntry!);
        setState(() {
          isDropped = true;
        });
      } else {
        bool isChild = widget.childrenNodes.any((element) => element.hasFocus);
        if (!isChild) {
          _overlayEntry?.remove();
          setState(() {
            isDropped = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    widget.focusNode.canRequestFocus = false;
    for (var node in widget.childrenNodes) {
      node.addListener(childrenListener);
    }
    widget.focusNode.addListener(dropdownListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.defaultValue),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction <= 0.1) widget.focusNode.unfocus();
      },
      child: CompositedTransformTarget(
        link: widget.layerLink,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextField(
            onChanged: widget.onTextChanged,
            mouseCursor: SystemMouseCursors.click,
            onTap: widget._type == IcDropdownType.inner
                ? () {
                    if (widget.focusNode.hasFocus) {
                      widget.focusNode.previousFocus();
                      setState(() {
                        isDropped = false;
                      });
                    }
                  }
                : () {
                    if (!ResponsiveWidget.isLargeScreen(context) &&
                        !widget.unmutable) {
                      showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => PopScope(
                          onPopInvoked: (a) async {
                            setState(() {
                              isDropped = false;
                            });
                            return ;
                          },
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: widget.contentPadding,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(.1),
                                    blurRadius: 50,
                                    spreadRadius: 0,
                                    offset: const Offset(-30, 30),
                                  ),
                                ],
                              ),
                              child: widget.content,
                            ),
                          ),
                        ),
                      );
                    }
                    if (isDropped) widget.focusNode.unfocus();
                  },
            focusNode: widget.focusNode,
            readOnly: widget.readonly,
            style: widget.dropDownTextStyle ?? TextStyles.body,
            decoration: widget.decoration ??
                InputDecoration(
                  hoverColor: widget.hoverColor,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                      right: widget.iconPadding ?? 25,
                    ),
                    child: widget.icon ??
                        Icon(
                          isDropped
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: widget.hintTextStyle != null
                              ? widget.hintTextStyle!.color
                              : isDropped
                                  ? AppColors.grey3
                                  : AppColors.grey3,
                        ),
                  ),
                  contentPadding: widget.buttonPadding.copyWith(
                    left: widget.buttonPadding.left,
                    top: widget.buttonPadding.top,
                    bottom: widget.buttonPadding.bottom,
                    right: 0,
                  ),
                  fillColor: widget.fillColor ?? Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.borderColor ?? AppColors.grey3,
                    ),
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.grey3,
                    ),
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.black,
                    ),
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(50),
                  ),
                  hintText: widget.defaultValue,
                  hintStyle: widget.hintTextStyle ??
                      TextStyles.body1.copyWith(
                        color: isDropped ? Colors.black : Colors.grey,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}

enum IcDropdownType { standart, inner }
