import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class StatelessPlatformWidget extends StatelessWidget {
  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return buildMaterialWidget(context);
    } else {
      return buildCupertinoWidget(context);
    }
  }
}
