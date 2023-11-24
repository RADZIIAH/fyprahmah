//file login & register

import 'package:flutter/material.dart';
import 'package:fyprahmah/restaurant.dart';
import 'package:http/http.dart' as http ;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN | SIGNUP',
      home: LoginPage(),
      routes: {
        '/registration': (context) =>RegistrationForm(),
        '/Restaurant App': (context) => RestaurantListScreen(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN | SIGN UP'),
        centerTitle: true,
        backgroundColor: const Color(0xff607d8b),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black87),
                  ),
                  child: ClipOval(
                    child: Image.asset('assets/images/logomain.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          labelText: 'Username',
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          } else if (!RegExp(r'[#!@$%^&*-]').hasMatch(value)) {
                            return 'Password must contain a special character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black87,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,

                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String username = _usernameController.text;
                              String password = _passwordController.text;

                              print('Username: $username, Password: $password');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestaurantListScreen()),
                              );
                            }
                          },
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context) => RegistrationForm()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'NEW? REGISTER HERE!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FoodCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: RegistrationForm(),
      initialRoute: '/',
      routes: {
        '/registration': (context) => RegistrationForm(),
        '/Restaurant App': (context) => RestaurantListScreen(),
      },
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isRegistered = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isRegistered
            ? _buildRegistrationSuccess()
            : _buildRegistrationForm(),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter username';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Implement registration logic here
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Put username, and password for registration
                print('Username: $username, Password: $password');

                // After registration, navigate to the restaurant
                Navigator.of(context).pushNamed('/Restaurant App');

                // Show a dialog message after successful registration
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Registration Successful'),
                      content: Text('You have successfully registered.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog

                            Navigator.of(context).pop; //navigate back to the login page
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Register'),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Navigate back to the previous page when the "Back to Login" button is clicked
              Navigator.of(context).pop();
            },
            child: Text('Back to Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Registration Successful!'),
          ElevatedButton(
            onPressed: () {
              // Navigate to another screen or perform any other action
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}

