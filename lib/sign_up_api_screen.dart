import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpApiScreen extends StatefulWidget {
  const SignUpApiScreen({super.key});

  @override
  State<SignUpApiScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignUpApiScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),

        body: {"email": email, "password": password},

        headers: {'x-api-key': 'reqres-free-v1'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Drawer content goes here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'User Profile',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.black),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xffE4E7FB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xffE4E7FB)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xffE4E7FB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xffE4E7FB)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () {
                signUp(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}