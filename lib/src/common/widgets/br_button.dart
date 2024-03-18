import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrButton extends StatelessWidget {
  const BrButton({
    Key? key,
    this.label = 'Нажмите',
    this.labelWidget,
    required this.onPressed,
    this.textColor = Colors.white,
    this.textStyle,
    this.padding,
    this.borderRadius = 15,
    this.color = Colors.orange,
    this.borderColor,
    this.icon = '',
    this.suffixIcon,
    this.preffixIcon,
  })  : isFilled = true,
        size = 0,
        iconColor = null,
        iconSize = 0,
        super(key: key);

  const BrButton.text({
    Key? key,
    this.label = 'Нажмите',
    this.labelWidget,
    required this.onPressed,
    this.textColor = Colors.black,
    this.textStyle,
    this.borderColor,
    this.suffixIcon,
    this.preffixIcon,
  })  : color = Colors.transparent,
        isFilled = false,
        padding = EdgeInsets.zero,
        iconColor = null,
        borderRadius = 0,
        icon = '',
        size = 0,
        iconSize = 0,
        super(key: key);

  const BrButton.icon({
    Key? key,
    this.label = 'Нажмите',
    this.labelWidget,
    required this.onPressed,
    this.textColor = Colors.black,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 15,
    this.color = Colors.white,
    this.borderColor,
    this.iconColor,
    required this.icon,
    this.size = 40,
    this.iconSize = 14,
    this.suffixIcon,
    this.preffixIcon,
  })  : isFilled = true,
        super(key: key);

  final String icon;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final Color? iconColor;
  final String label;
  final Widget? labelWidget;
  final Color color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final bool isFilled;
  final double size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    if (icon.isNotEmpty) {
      return IconButton(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledColor: Colors.transparent,
        iconSize: size,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        color: color,
        icon: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius),
            color: color,
          ),
          child: SvgPicture.asset(
            icon,
            width: iconSize,
            height: iconSize,
          ),
        ),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          padding ??
              const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          onPressed != null ? color : Colors.grey,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: labelWidget ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon ?? const Offstage(),
              const SizedBox(
                width: 12,
              ),
              Text(
                label,
                maxLines: 1,
                style: onPressed != null
                    ? textStyle ??
                        TextStyle(
                            fontSize: 24,
                            color: textColor,
                            fontWeight: FontWeight.w600)
                    : const TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                textAlign: isFilled ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(
                width: 12,
              ),
              preffixIcon ?? const Offstage(),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
    );
  }
}
