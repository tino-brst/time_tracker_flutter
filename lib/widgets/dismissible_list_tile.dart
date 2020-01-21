import 'package:flutter/material.dart';

class DismissibleListTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final String title;

  const DismissibleListTile({
    @required Key key,
    this.onTap,
    this.onDismissed,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleWidget = title == null ? null : Text(title);
    final trailingIcon = Icon(Icons.chevron_right);

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (_) => onDismissed(),
      child: ListTile(
        title: titleWidget,
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 16, right: 10),
        trailing: trailingIcon,
      ),
    );
  }
}
