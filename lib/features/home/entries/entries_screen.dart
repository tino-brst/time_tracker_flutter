import 'dart:io';

import 'package:flutter/material.dart';

class EntriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appBarTitle = Text('Entries');

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: Platform.isIOS,
        elevation: 0,
      ),
    );
  }
}
