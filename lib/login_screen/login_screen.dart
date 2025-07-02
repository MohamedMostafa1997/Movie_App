import 'package:flutter/material.dart';
import 'package:movie_app/login_screen/login_error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String username = usernameController.text.trim().toLowerCase();
    final String password = passwordController.text.trim();

    if (username == 'mohamed.mostafa' && password == '1234') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (!mounted) return;
      Navigator.popAndPushNamed(context, '/homescreen');
    } else {
      showDialog(
        context: context,
        builder: (_) => LoginErrorDialog(message: "Wrong username or password"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          SizedBox(height: 80),
          Center(
            child: Text(
              "Movie APP ▶️",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(
            " Welcome Back",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Please enter your details',
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text("Login", style: TextStyle(color: Colors.amber[900])),
          ),
        ],
      ),
    );
  }
}
