import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    //add only one permission in xml file and local_auth package 
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!authenticated) {
              final bool canAuthenticateWithBiometric =
                  await auth.canCheckBiometrics;
              if (canAuthenticateWithBiometric) {
               try {
                  final bool didAuthenticate = await auth.authenticate(
                  localizedReason:
                      'Please authentication to show accont balance ',
                  options: const AuthenticationOptions(biometricOnly: false),
                );
                setState(() {
                    authenticated=didAuthenticate;
                });
               } catch (e) {
                 print("object");
               }
              }
            } else {
              setState(() {
                authenticated = false;
              });
            }
          },
          child: Icon(
            authenticated ? Icons.lock_open_rounded : Icons.lock,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Account Balance ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              authenticated
                  ? const Text(
                      "\$130000",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      "********",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
