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

// TODO make it a statefull widget that keeps track of the current tab internally?
class TabScaffold extends StatelessWidget {
  final List<TabData> tabs;
  final void Function(int) onTabChange;
  final int currentTab;

  const TabScaffold({
    @required this.tabs,
    @required this.onTabChange,
    this.currentTab = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: onTabChange,
        currentIndex: currentTab,
        items: [
          for (final tab in tabs)
            BottomNavigationBarItem(
              title: Text(tab.title),
              icon: tab.iconData != null ? Icon(tab.iconData) : null,
            )
        ],
      ),
      tabBuilder: (context, index) => tabs[index].builder(context),
    );
  }
}
