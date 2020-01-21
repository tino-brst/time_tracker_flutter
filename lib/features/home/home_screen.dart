import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/tab_scaffold.dart';
import 'account/account_screen.dart';
import 'entries/entries_screen.dart';
import 'jobs/jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      tabs: [
        TabData(
          title: 'Jobs',
          iconData: Icons.work,
          builder: (_) => JobsScreen(),
        ),
        TabData(
          title: 'Entries',
          iconData: Icons.view_headline,
          builder: (_) => EntriesScreen(),
        ),
        TabData(
          title: 'Account',
          iconData: Icons.person,
          builder: (_) => AccountScreen(),
        )
      ],
    );
  }
}
