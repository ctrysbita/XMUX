import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/mainapp/calendar/calendar_handler.dart';
import 'package:xmux/mainapp/calendar/sign_in_button.dart';
import 'package:xmux/translations/translation.dart';

class TimeTablePage extends StatelessWidget {
  final List classes;

  TimeTablePage(this.classes);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: CalendarHandler.acUpdate,
        child: ListView.builder(
            itemCount: classes.length + 1,
            itemBuilder: (_, int index) {
              if (index == classes.length)
                return Center(
                    child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          MainLocalizations
                                  .of(context)
                                  .get("Calendar/LastUpdate") +
                              DateFormat
                                  .yMMMd(Localizations
                                      .localeOf(context)
                                      .languageCode)
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      mainAppStore.state.acState.timestamp)) +
                              " " +
                              DateFormat
                                  .Hms(Localizations
                                      .localeOf(context)
                                      .languageCode)
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      mainAppStore.state.acState.timestamp)),
                          style: Theme.of(context).textTheme.caption,
                        )));
              else
                return _ClassCard(classes[index]);
            }),
      );
}

class _ClassCard extends StatelessWidget {
  // Colors from monday to friday.
  static final List<Color> dayColor = [
    Colors.pink[200],
    Colors.orange[300],
    Colors.green[200],
    Colors.blue[200],
    Colors.purple[300],
  ];

  // Single class object.
  final Map<String, dynamic> theClass;

  _ClassCard(this.theClass);

  // Convert string to TimeOfDay.
  static TimeOfDay _getTimeOfDay(String originTime) => TimeOfDay(
      hour: int.parse(originTime.split(":")[0]),
      minute: int.parse(originTime.split(":")[1]));

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(5.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    MainLocalizations.of(context).get("Weekdays/" +
                            (theClass["dayOfWeek"] + 1).toString()) +
                        " " +
                        _getTimeOfDay(theClass["startTimeOfDay"])
                            .format(context) +
                        " - " +
                        _getTimeOfDay(theClass["endTimeOfDay"])
                            .format(context) +
                        " " +
                        theClass["classRoom"],
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                color: dayColor[theClass["dayOfWeek"]],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        theClass["courseName"],
                        style: Theme
                            .of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.black54),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(theClass["courseCode"]),
                              Text(theClass["lecturer"]),
                            ],
                          ),
                        ),
                        SignInButton(theClass),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
