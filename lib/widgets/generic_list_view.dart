import 'package:flutter/material.dart';

class GenericListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;

  const GenericListView({
    @required this.items,
    @required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (_, __) => const Divider(height: 0.5),
      itemCount: items.length,
    );
  }
}
