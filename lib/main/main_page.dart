import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '../global.dart';
import '../redux/state/state.dart';
import '../util/avatar.dart';
import '../util/screen.dart';
import '../util/tracker.dart';
import 'calendar/calendar_page.dart';
import 'campus/campus_page.dart';
import 'drawer.dart';
import 'forum/forum_page.dart';

const mainPages = <TopLevelPage>[
  CalendarPage(),
  ForumPage(),
  CampusPage(),
];

abstract class TopLevelPage implements Widget {
  String get path;

  String get label;

  Widget get icon;

  Widget get activeIcon;
}

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({Key? key, this.index = 0}) : super(key: key);

  factory MainPage.fromPage(String? page) =>
      MainPage(index: mainPages.indexWhere((e) => e.path == page));

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0;

  void navigateTo(int index) {
    if (!mounted || index == _index) return;
    context.go('/${mainPages[index].path}');
  }

  @override
  void initState() {
    _index = widget.index;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    if (_index != widget.index) {
      _index = widget.index;
      setCurrentScreen(screenName: '/${mainPages[_index].path}');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget? navigationRail;
    Widget? bottomNavigationBar;
    if (context.isBetween(Breakpoint.extraSmall)) {
      bottomNavigationBar = BottomNavigationBar(
        currentIndex: _index,
        onTap: navigateTo,
        enableFeedback: true,
        items: [
          for (var page in mainPages)
            BottomNavigationBarItem(
              icon: page.icon,
              activeIcon: page.activeIcon,
              label: page.label,
            ),
        ],
      );
    } else {
      navigationRail = NavigationRail(
        selectedIndex: _index,
        onDestinationSelected: navigateTo,
        extended: context.isBetween(Breakpoint.medium) ||
            context.isBetween(Breakpoint.large),
        labelType: context.isBetween(Breakpoint.small)
            ? NavigationRailLabelType.selected
            : NavigationRailLabelType.none,
        leading: StoreConnector<AppState, String>(
          distinct: true,
          converter: (s) => store.state.user.profile.avatar.isNotEmpty
              ? store.state.user.profile.avatar
              : remoteConfigs.staticResources.defaultAvatar,
          builder: (context, url) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: CircleAvatar(
              foregroundImage: ExtendedNetworkImageProvider(
                url.toGravatarCdn,
                cache: true,
              ),
            ),
            iconSize: 40,
          ),
        ),
        destinations: [
          for (var page in mainPages)
            NavigationRailDestination(
              icon: page.icon,
              selectedIcon: page.activeIcon,
              label: Text(page.label),
            ),
        ],
      );
    }

    return Scaffold(
      body: Row(
        children: [
          if (navigationRail != null) ...[
            SafeArea(child: navigationRail),
            const VerticalDivider(thickness: 1, width: 1),
          ],
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: mainPages[_index],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      drawer: const MainDrawer(),
    );
  }
}
