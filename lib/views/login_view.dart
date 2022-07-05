import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testapp/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login Screen')),
        body: FutureBuilder(
            future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    children: [
                      TextField(
                        controller: _email,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration(hintText: 'Enter email here'),
                      ),
                      TextField(
                        controller: _email,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: 'Enter password here'),
                      ),
                      TextButton(
                          onPressed: () async {
                            final A = _email.text;
                            final B = _password.text;
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: A, password: B);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'wrong-password') {
                                print('WrongPassword');
                              } else
                                print('something wrong here');
                            }
                          },
                          child: const Text('Login')),
                    ],
                  );
                default:
                  return const Text('Loading');
              }
            }));
  }
}
