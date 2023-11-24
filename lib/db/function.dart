import 'dart:convert';

import 'package:flutter/cupertino.dart';

Future<void> senddata() async {
  var usernameController;
  var passwordController;
  var http;

  final response = await http.post("http://fyprahmah/insertdata.php", body: {
    "username": usernameController.text,
    "password": passwordController.text,
  });

  var userData = json.decode(response.body);
  // Process userData as needed
  print(userData);
}
