import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testapp/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _mail;
  late final TextEditingController _pass;
  @override
  void initState() {
    _mail = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mail.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _mail,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Enter email here'),
                    ),
                    TextField(
                      controller: _pass,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Enter password here'),
                    ),
                    TextButton(
                        onPressed: () async {
                          final email = _mail.text;
                          final password = _pass.text;
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              print(e.code);
                            } else if (e.code == 'weak-password') {
                              print(e.code);
                            } else if (e.code == 'invalid-email') {
                              print(e.code);
                            }
                          }
                        },
                        child: const Text('Register')),
                  ],
                );
              default:
                return const Text('Loading');
            }
          }),
    );
  }
}
