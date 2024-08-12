import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week_three/features/authentication/register_page.dart';
import 'package:week_three/features/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Please enter your login credentials',
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Please enter your email",
                prefixIcon: Icon(Icons.person),
                hintStyle: TextStyle(
                  fontSize: 10,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              // maxLength: 10,
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Please enter your password",
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.visibility),
                hintStyle: TextStyle(
                  fontSize: 10,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You have logged in successfully"),
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                    );
                  } catch (ex) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(ex.toString())));
                  }
                },
                child: Text("Login")),
            SizedBox(
              height: 24,
            ),
            TextButton(
                onPressed: () {
                  print("hello world");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return RegisterPage();
                      },
                    ),
                  );
                },
                child: Text("Don't have an account? Register Here")),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
