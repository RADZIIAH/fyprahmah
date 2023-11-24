import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, String> userData = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('View Data'),
        ),
        body: ViewButton(userData),
      ),
    );
  }
}

class ViewButton extends StatelessWidget {
  final Map<String, String> userData;

  ViewButton(this.userData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          viewAllData(context, userData);
        },
        child: Text('View All Data'),
      ),
    );
  }

  void viewAllData(BuildContext context, Map<String, String> userData) {
    if (userData.isEmpty) {
      showMessage(context, "Error", "No user data found");
      return;
    }


    StringBuffer buffer = StringBuffer();
    userData.forEach((key, value) {
      buffer.write("$key: $value\n");
    });

    showMessage(context, "User Data", buffer.toString());
  }

  void showMessage(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
