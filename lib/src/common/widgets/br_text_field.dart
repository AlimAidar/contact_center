import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrTextField extends StatefulWidget {
  const BrTextField({
    Key? key,
    this.placeholder,
    this.lableText,
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
    this.preffixIcon,
  }) : super(key: key);

  final String? placeholder;
  final String? lableText;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
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

  @override
  State<BrTextField> createState() => _BrTextFieldState();
}

class _BrTextFieldState extends State<BrTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        scrollPadding: EdgeInsets.zero,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          enabledBorder: OutlineInputBorder(
              gapPadding: 2,
              borderSide: BorderSide(
                color: widget.enableBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(15)),
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            gapPadding: 2,
            borderSide: BorderSide(color: widget.borderColor ?? Colors.orange),
            borderRadius: BorderRadius.circular(15),
          ),
          focusColor: Colors.orange,
          iconColor: Colors.orange,
          hoverColor: Colors.orange,
          labelText: widget.lableText,
          labelStyle: widget.labelStyle ?? const TextStyle(color: Colors.black),
          prefixIcon: widget.preffixIcon,
          suffixIcon: widget.suffixIcon,
          border: OutlineInputBorder(
            gapPadding: 2,
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          fillColor: Colors.orange,
          hintText: widget.placeholder,
        ),
      ),
    );
  }
}
