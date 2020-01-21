import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stateless_platform_widget.dart';

class PlatformAlertDialogAction extends StatelessPlatformWidget {
  final Widget child;
  final bool isDefaultAction;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({
    @required this.child,
    this.isDefaultAction = false,
    @required this.onPressed,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      isDefaultAction: isDefaultAction,
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
