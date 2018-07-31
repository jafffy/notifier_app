import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchTodayInformation() async {
  final response = await http.get('http://10.0.1.5:8080/today');

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load today\'s information');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notifier',
      home: Scaffold(
        appBar: AppBar(
          title: Text('notifier'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchTodayInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            })
        ),
      ),
    );
  }
}