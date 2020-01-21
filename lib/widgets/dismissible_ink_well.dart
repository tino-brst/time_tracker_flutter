import 'package:flutter/material.dart';

class DismissibleInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final Widget child;

  const DismissibleInkWell({
    @required Key key,
    this.child,
    this.onTap,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (_) => onDismissed(),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
