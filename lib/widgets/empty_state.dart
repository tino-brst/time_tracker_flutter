import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyState({
    @required this.title,
    @required this.subtitle,
  })  : assert(title != null),
        assert(subtitle != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 32, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(fontSize: 18, color: Colors.black45),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
