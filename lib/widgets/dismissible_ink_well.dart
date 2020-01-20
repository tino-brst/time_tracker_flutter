import 'package:flutter/material.dart';

class DismissibleInkWell extends StatelessWidget {
  final Key key;
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final Widget child;

  const DismissibleInkWell({
    @required this.key,
    this.child,
    this.onTap,
    this.onDismissed,
  });

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
