import 'package:flutter/material.dart';

// AuthScreen is a StatefulWidget because
// the screen will change based on user input (email, password)
class AuthScreen extends StatefulWidget {
// here the Auth Screen is inheriting the properties of Stateful Widget
  // Every widget has a constructor with a key
  // Flutter uses this to track widgets
  const AuthScreen({super.key});

  // This method connects the widget to its State
  // overriding means changing the behaviour of that class
  @override
  //when flutter asks AuthScreen, which state do u use, return _AuthScreenState
  State<AuthScreen> createState() => _AuthScreenState();
}

// This class holds the UI and the changing data
//State<AuthScreen> is a kind of object that createState() should return
//it is a type of constraintt
//_AuthScreenState is a State object that belongs to AuthScreen.
class _AuthScreenState extends State<AuthScreen> {
  //the final reference wont change, TextEditingController listens to text input
  //emailController.text gives you email
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
//The leading _ means its private to this file and its a flutter convention
  // build() tells Flutter what to draw on the screen
  // BuildContext tells where this widget exists in the app tree
  @override
  Widget build(BuildContext context) {

    // Scaffold gives a basic screen structure
    return Scaffold(
      body: Center(
        // Center places its child in the middle of the screen
        child: Column(
          // Column stacks widgets vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              //connects UI to the memory
              controller: emailController,
              //shows email keyboard
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                //the "Email" label
                labelText: 'Email',
                //clean input box
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true, //shows dots instead of the text
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
