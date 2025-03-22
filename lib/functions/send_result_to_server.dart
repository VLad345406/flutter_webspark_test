import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/elements/snack_bar.dart';
import 'package:flutter_webspark_test/screens/first_task/first_task_display_ways.dart';
import 'package:http/http.dart' as http;

Future<void> sendResultToServer(
  BuildContext context,
  List<Map<String, dynamic>> paths,
  String serverUrl,
) async {
  List<Map<String, dynamic>> formattedPaths =
      paths.map((pathItem) {
        List<Map<String, String>> steps = [];
        for (var step in pathItem['path']) {
          steps.add({"x": step.key.toString(), "y": step.value.toString()});
        }

        return {
          "id": pathItem["id"],
          "result": {"steps": steps, "path": pathItem["result"]},
        };
      }).toList();

  String jsonData = jsonEncode(formattedPaths);
  final Uri url = Uri.parse(serverUrl);
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FirstTaskDisplayWays()),
        (Route<dynamic> route) => false,
      );
      snackBar(context, 'Success!');
    } else {
      snackBar(context, 'Error, status code: ${response.statusCode}');
    }
  } catch (e) {
    snackBar(context, 'Error: $e');
  }
}
