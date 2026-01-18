import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';



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
  //The leading _ means its private to this file and its a flutter convention
  bool isLoginMode = true;

  //the final reference wont change, TextEditingController listens to text input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;


  Future<void> onLoginPressed() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      if (isLoginMode) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }


      // If success, we’ll go to next screen later
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = "${e.code}: ${e.message ?? "Auth failed"}";
      });
    }catch (e) {
      setState(() {
        errorMessage = "Something went wrong";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // build() tells Flutter what to draw on the screen
  // BuildContext tells where this widget exists in the app tree
  @override
  Widget build(BuildContext context) {

    // Scaffold gives a basic screen structure
    return Scaffold(
      body: Center(
        // Center places its child in the middle of the screen
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLoginMode ? 'Login' : 'Sign Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],

              ElevatedButton(
                onPressed: isLoading ? null : onLoginPressed,
                child: Text(
                  isLoading
                      ? "Please wait..."
                      : (isLoginMode ? "Login" : "Sign Up"),
                ),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    isLoginMode = !isLoginMode;
                    errorMessage = null;
                  });
                },
                child: Text(
                  isLoginMode
                      ? "New here? Create an account"
                      : "Already have an account? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
