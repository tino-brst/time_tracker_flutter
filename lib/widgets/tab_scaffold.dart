import 'package:flutter/cupertino.dart';

class TabData {
  final String title;
  final IconData iconData;
  final WidgetBuilder builder;

  TabData({
    @required this.title,
    this.iconData,
    @required this.builder,
  })  : assert(title != null),
        assert(builder != null);
}

class TabScaffold extends StatefulWidget {
  final List<TabData> tabs;

  const TabScaffold({@required this.tabs});

  @override
  _TabScaffoldState createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    // TODO add WillPopScope wrapper to avoid exiting app with Androids back button
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: _setCurrentTab,
        currentIndex: _currentTab,
        items: [
          for (final tab in widget.tabs)
            BottomNavigationBarItem(
              title: Text(tab.title),
              icon: tab.iconData != null ? Icon(tab.iconData) : null,
            )
        ],
      ),
      tabBuilder: (_, index) {
        return CupertinoTabView(builder: widget.tabs[index].builder);
      },
    );
  }

  // TODO add pop-to-root behaviour when tapping an already active tab
  void _setCurrentTab(int value) {
    setState(() {
      _currentTab = value;
    });
  }
}
