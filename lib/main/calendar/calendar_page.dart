import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.dart';
import '../../redux/state/state.dart';
import '../../util/avatar.dart';
import '../../util/platform.dart';
import '../../util/screen.dart';
import '../../util/tab.dart';
import '../../util/tracker.dart';
import '../main_page.dart';
import 'assignment.dart';
import 'exam.dart';
import 'moodle_notification.dart';
import 'timetable.dart';
import 'upcoming_event.dart';

class CalendarPage extends StatefulWidget implements TopLevelPage {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  String get path => 'Calendar';

  @override
  String get label => LocaleKeys.Calendar_Calendar.tr();

  @override
  Widget get icon => const Icon(Icons.calendar_today_outlined);

  @override
  Widget get activeIcon => const Icon(Icons.calendar_today);

  static const tabs = <TabEntry>[
    TimetablePage(),
    ExamPage(),
    AssignmentPage(),
    UpcomingEventPage(),
    MoodleNotificationPage(),
  ];

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late final TabController _controller;
  var currentIndex = -1;

  String get currentTabScreenName =>
      '/Calendar/${CalendarPage.tabs[currentIndex].path}';

  void _onTabChanged() {
    if (_controller.index == currentIndex) return;
    currentIndex = _controller.index;
    // Track tab screen.
    setCurrentScreen(screenName: currentTabScreenName);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Restore tab screen.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setCurrentScreen(screenName: currentTabScreenName),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => routeObserver.subscribe(this, ModalRoute.of(context)!),
    );

    _controller = TabController(length: CalendarPage.tabs.length, vsync: this)
      ..addListener(_onTabChanged);
    _onTabChanged(); // Initial tab.

    super.initState();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Material(
            elevation: 1,
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                if (context.isBetween(Breakpoint.extraSmall))
                  StoreConnector<AppState, String>(
                    distinct: true,
                    converter: (s) => store.state.user.profile.avatar.isNotEmpty
                        ? store.state.user.profile.avatar
                        : remoteConfigs.staticResources.defaultAvatar,
                    builder: (_, url) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: CircleAvatar(
                        foregroundImage: ExtendedNetworkImageProvider(
                          url.toGravatarCdn,
                          cache: true,
                        ),
                      ),
                      iconSize: 30,
                    ),
                  ),
                Expanded(
                  child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    tabs: CalendarPage.tabs
                        .map((e) => Tab(text: e.label))
                        .toList(),
                  ),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.calendarAlt),
                  tooltip: LocaleKeys.Calendar_Academic.tr(),
                  onPressed: () {
                    if (isWeb) {
                      launch('http://www.xmu.edu.my/14702/list.htm');
                    } else {
                      context.go('/Calendar/AcademicCalendar');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: CalendarPage.tabs,
        ),
      ),
    );
  }
}
