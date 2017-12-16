import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentPage extends StatelessWidget {
  final List rawData;

  AssignmentPage(this.rawData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: rawData.length,
        itemBuilder: (_, int index) {
          return new _AssCard(rawData[index]);
        });
  }
}

class _AssCard extends StatelessWidget {
  final Map assData;

  _AssCard(this.assData);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      assData["fullname"],
                      style: Theme
                          .of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                  new Column(
                    children: (assData["assignments"] as List)
                        .map((var e) => new MaterialButton(
                              onPressed: () {
                                launch(
                                    "https://l.xmu.edu.my/mod/assign/view.php?id=" +
                                        e["id"].toString());
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    e["name"],
                                  ),
                                  new Text("DeadLine : " + e["duedate"]),
                                  new Divider(
                                    height: 5.0,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
