import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/signin_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE4E4E4),
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Home !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  AuthServices.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    ),
                  );
                },
                icon: Icon(Icons.logout_rounded),
                label: Text("Logout"),
              ),
            ],
          ),
        ));
  }
}
