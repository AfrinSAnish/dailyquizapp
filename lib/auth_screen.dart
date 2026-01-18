import 'package:flutter/material.dart';

//stateless Widget is widget that doesnt change the data
// the AuhScreen is inheriting statelessWidget
class AuthScreen extends StatelessWidget {
  //every widget has a key, used to track the widgets
  //every widget constructor has this
  const AuthScreen({super.key});

  @override
  //we are overriding a method from StatelessWidget here the build method template
  Widget build(BuildContext context) {
    //build tells what to draw The BuildContext context :where this exists in app
    //every screen should have one build in function
    return Scaffold(
      //scaffold is a basic screen structure every screen usually starts with it
      body: Center(
        //body is the main area and centre is a widget that centres its child
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

      ),
    );
  }
}
