import 'package:contact_center/src/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

class BrDivider extends Divider {
  const BrDivider({
    Key? key,
    Color color = AppColors.grey2,
    double thickness = 1,
  }) : super(
          key: key,
          color: color,
          thickness: thickness,
          height: 1,
        );
}

class IcVerticalDivider extends VerticalDivider {
  const IcVerticalDivider({
    Key? key,
    Color color = Colors.grey,
    double thickness = 1,
    bool isVertical = false,
  }) : super(
          key: key,
          color: color,
          thickness: thickness,
          width: 1,
        );
}
