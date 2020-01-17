import 'package:flutter/material.dart';

class DismissibleListTile extends StatelessWidget {
  final Key key;
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final String title;

  const DismissibleListTile({
    this.key,
    this.onTap,
    this.onDismissed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = title == null ? null : Text(title);
    final trailingIcon = Icon(Icons.chevron_right);

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (_) => onDismissed,
      child: ListTile(
        title: titleWidget,
        onTap: onTap,
        contentPadding: EdgeInsets.only(left: 16, right: 10),
        trailing: trailingIcon,
      ),
    );
  }
}
