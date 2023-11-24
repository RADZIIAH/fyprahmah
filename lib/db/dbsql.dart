import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with MYSQL',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> senddata() async {
    final response = await http.post("http://localhost/new/register.php" as Uri, body: {
      "username": usernameController.text,
      "password": passwordController.text,
    });

    var data = response.body;
    // Process data as needed
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username", style: TextStyle(fontSize: 18.0)),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: 'username'),
              ),
              Text("Password", style: TextStyle(fontSize: 18.0)),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'password'),
                obscureText: true,
              ),
              ElevatedButton(
                child: Text("Register"),
                onPressed: () {
                  senddata();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
