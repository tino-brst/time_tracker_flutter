import 'package:flutter/material.dart';

class CustomListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;

  CustomListView({
    @required this.items,
    @required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (_, __) => Divider(height: 0.5),
      itemCount: items.length,
    );
  }
}
