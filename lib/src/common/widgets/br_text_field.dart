import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrTextField extends StatelessWidget {
  const BrTextField({
    Key? key,
    this.placeholder,
    this.labelText,
    this.suffixIcon,
    this.iconPressed,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.borderColor,
    this.enableBorderColor,
    this.labelStyle,
    this.inputFormatters,
    this.textInputType,
    this.prefixIcon,
    this.isExpanded = false,
    this.focusNode,
  }) : super(key: key);

  final String? placeholder;
  final String? labelText;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Function()? iconPressed;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final Color? borderColor;
  final Color? enableBorderColor;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isExpanded ? 500 : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        scrollPadding: EdgeInsets.zero,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          enabledBorder: OutlineInputBorder(
            gapPadding: 2,
            borderSide: BorderSide(
              color: enableBorderColor ?? Colors.grey,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            gapPadding: 2,
            borderSide: BorderSide(color: borderColor ?? Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
          focusColor: Colors.orange,
          iconColor: Colors.orange,
          hoverColor: Colors.orange,
          labelText: labelText,
          labelStyle: labelStyle ?? const TextStyle(color: Colors.black),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            gapPadding: 2,
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.orange,
          hintText: placeholder,
        ),
      ),
    );
  }
}
