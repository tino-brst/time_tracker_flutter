import 'package:flutter/widgets.dart';

/// Provides the [Directionality] widget ancestor often needed by Flutter built-in wigets
class DirectionalityWrapper extends StatelessWidget {
  final Widget child;

  const DirectionalityWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
