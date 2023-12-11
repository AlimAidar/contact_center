import 'package:contact_center/src/common/widgets/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class BrWrapper extends StatelessWidget {
  const BrWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: ResponsiveConsts.maxWidthScreen,
        ),
        child: child,
      ),
    );
  }
}
