import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:xmux/components/empty_error_button.dart';
import 'package:xmux/components/empty_error_page.dart';
import 'package:xmux/components/floating_card.dart';
import 'package:xmux/components/spannable_grid.dart';
import 'package:xmux/config.dart';
import 'package:xmux/generated/i18n.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/mainapp/calendar/attendance.dart';
import 'package:xmux/mainapp/calendar/sign_in_button.dart';
import 'package:xmux/modules/algorithms/edit_distance.dart';
import 'package:xmux/modules/api/xmux_api.dart'
    show GetTimetableResp, TimetableClass;
import 'package:xmux/modules/attendance/attendance.dart';
import 'package:xmux/modules/common/translation_mapper.dart' show weekdays;
import 'package:xmux/redux/redux.dart';

part 'timetable_grid.dart';

class TimeTablePage extends StatelessWidget {
  final List<TimetableClass> timetable;
  final DateTime recentUpdate;

  TimeTablePage(GetTimetableResp resp)
      : this.timetable = (resp == null || resp.timetable == null)
            ? null
            : sortTimetable(resp.timetable),
        this.recentUpdate = resp?.recentUpdate?.toLocal();

  Future<Null> _handleUpdate() async {
    var action = UpdateTimetableAction();
    store.dispatch(action);
    await action.future;
  }

  /// Sort timetable according to the end of class and now.
  static List<TimetableClass> sortTimetable(List<TimetableClass> timetable) {
    var now = DateTime.now();
    var nowMin = now.weekday * 1440 + now.hour * 60 + now.minute;

    int _getLessonMin(TimetableClass l) =>
        l.day * 1440 + l.end.hour * 60 + l.end.minute;

    var before = <TimetableClass>[];
    var after = <TimetableClass>[];

    timetable.sort((a, b) => _getLessonMin(a) - _getLessonMin(b));
    for (var i in timetable)
      _getLessonMin(i) < nowMin ? before.add(i) : after.add(i);

    return after..addAll(before);
  }

  @override
  Widget build(BuildContext context) {
    if (timetable == null) return EmptyErrorButton(onRefresh: _handleUpdate);
    if (timetable.isEmpty) return EmptyErrorPage();
    if (kIsWeb) return TimeTableGrid(timetable);

    var languageCode = Localizations.localeOf(context).languageCode;
    var lastUpdate = Center(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "${i18n('Calendar/LastUpdate', context)} "
          '${DateFormat.yMMMd(languageCode).format(recentUpdate)} '
          '${DateFormat.Hms(languageCode).format(recentUpdate)}',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );

    return RefreshIndicator(
      onRefresh: _handleUpdate,
      child: ListView.builder(
        itemCount: timetable.length + 1,
        itemBuilder: (_, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 250),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: index == timetable.length
                    ? lastUpdate
                    : LessonCard(timetable[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LessonCard extends StatefulWidget {
  /// Lesson information.
  final TimetableClass lesson;

  /// Whether the card is inside a TimetableGrid.
  final bool isInGrid;

  final attendanceApi = AttendanceApi(
    address: BackendApiConfig.attendanceAddress,
    uid: store.state.user.campusId,
  );

  LessonCard(this.lesson, {this.isInGrid = false});

  @override
  _LessonCardState createState() => _LessonCardState();

  // Colors from monday to friday.
  static const List<Color> dayColor = [
    const Color(0xFFF48FB1),
    const Color(0xFFFFCC80),
    const Color(0xFFA5D6A7),
    const Color(0xFF90CAF9),
    const Color(0xFFE1BEE7),
  ];

  int get lessonCredit {
    return store.state.acState.courses?.firstWhere(
        (c) => c.courseName.indexOf(lesson.name) != -1, orElse: () {
      var editDistances = store.state.acState.courses
          .map((c) => editDistance(c.courseName, lesson.name))
          .toList();
      return store.state.acState
          .courses[editDistances.indexOf(editDistances.reduce(min))];
    })?.credit;
  }
}

class _LessonCardState extends State<LessonCard> {
  Widget _buildDialogWidgets(BuildContext context) {
    var history = FutureBuilder<List<AttendanceRecord>>(
      future: widget.attendanceApi.getHistory(cid: widget.lesson.cid),
      builder: (ctx, snap) {
        switch (snap.connectionState) {
          case ConnectionState.done:
            if (!snap.hasError)
              return ListView(
                children: snap.data
                    .map((e) => Text(
                        '${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(e.timestamp)} '
                        '${DateFormat.Hms(Localizations.localeOf(context).languageCode).format(e.timestamp)} '
                        '${AttendanceHistoryItem.parseMessage(context, e)}'))
                    .toList(),
              );
            else
              return Center(child: CircularProgressIndicator());
            break;
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );

    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      title: Text(
        widget.lesson.name,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      children: <Widget>[
        Text(
            '${i18n('Calendar/ClassCard/Code', context)}: ${widget.lesson.cid}\n'
            '${i18n('Calendar/ClassCard/Credit', context)}: ${widget.lessonCredit}\n'
            '${i18n('Calendar/ClassCard/Time', context)}: ${weekdays(context, widget.lesson.day)} '
            '${widget.lesson.start.format(context)} - '
            '${widget.lesson.end.format(context)}\n'
            '${i18n('Calendar/ClassCard/Room', context)}: ${widget.lesson.room}\n'
            '${i18n('Calendar/ClassCard/Lecturer', context)}: ${widget.lesson.lecturer.split(',').join(', ')}'),
        Divider(),
        Text(S.of(context).Calendar_Attendance),
        SizedBox(
          height: min(MediaQuery.of(context).size.height / 3.5, 200),
          width: MediaQuery.of(context).size.width / 1.3,
          child: history,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var header = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : LessonCard.dayColor[widget.lesson.day - 1],
        borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
      ),
      child: Center(
        child: Text(
          widget.isInGrid
              ? '${widget.lesson.cid} ${widget.lesson.room}'
              : '${weekdays(context, widget.lesson.day)} '
                  '${widget.lesson.start.format(context)} - '
                  '${widget.lesson.end.format(context)} '
                  '${widget.lesson.room}',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );

    var body = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Text(
          widget.lesson.name,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
        Divider(height: 8, color: Colors.transparent),
        Row(
          children: <Widget>[
            Expanded(
              child: widget.isInGrid
                  ? Text(widget.lesson.lecturer)
                  : Text(
                      '${widget.lesson.cid} \n'
                      '${widget.lesson.lecturer}',
                    ),
            ),
            SignInButton(widget.lesson),
          ],
        ),
      ],
    );

    return FloatingCard(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: _buildDialogWidgets,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          header,
          if (widget.isInGrid) Expanded(child: body) else body,
        ],
      ),
    );
  }
}
