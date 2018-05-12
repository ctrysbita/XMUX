import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xmux/globals.dart';

class AcademicHandler {
  static Future<List> getCourses({BuildContext context}) async {
    print("AcademicHandler: Updating courses.");

    // Get courses from backend.
    var response =
        await BackendApiHandler.post(context: context, api: "/course", body: {
      "id": mainAppStore.state.personalInfoState.uid,
      "pass": mainAppStore.state.personalInfoState.password,
    });

    // Check error.
    if (response.statusCode >= 400) return [response.reasonPhrase];

    // Decode and remove lab.
    var coursesData = jsonDecode(response.body)["data"];
    coursesData = coursesData
        .map((e) => e["Course Name (by group)"].contains("(Lab)") ? null : e)
        .toList();
    while (coursesData.contains(null)) coursesData.remove(null);

    return coursesData;
  }
}
