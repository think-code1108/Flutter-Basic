import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/home_page.dart';
import 'package:flutter_auth/pages/signup_page.dart';

import 'package:flutter_auth/services/auth_service.dart';
import 'package:flutter_auth/widgets/pesan_info.dart';
import 'package:email_validator/email_validator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSignin = false;
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4E4E4),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        child: Icon(
                          Icons.key_outlined,
                          size: 80.0,
                          color: Colors.amber[600],
                        ),
                      ),
                      Text(
                        "Login Page",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Email Address",
                    hintText: "Email Address"),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Password",
                    hintText: "Password"),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Center(
                  child: (isSignin)
                      ? SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        )
                      : FloatingActionButton.extended(
                          elevation: 0,
                          label: Text(
                            "Sign in",
                            style: TextStyle(
                              color: Color(0xFFBEBEBE),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Color(0xFFBEBEBE),
                          ),
                          backgroundColor: Colors.purple[900],
                          onPressed: () async {

                            //--> Cek email dan password 
                            if (!EmailValidator.validate(emailController.text)) {
                              ShowPesan.Warning("Email is not valid, please try again.");
                              return;
                            }
                            if (passwordController.text.length < 6) {
                              ShowPesan.Warning("Password is not valid, please try again.");
                              return;
                            }

                            //--> Munculkan loading screen
                            setState(() {
                              isSignin = true;
                            });

                            //--> Cek Login ke Firebase Auth
                            SignInSignUpResult responLogin =
                                await AuthServices.signIn(emailController.text,
                                    passwordController.text);

                            if (responLogin.user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              //--> hilangkan loading screen
                              setState(() {
                                isSignin = false;
                              });

                              ShowPesan.Error(responLogin.message!);
                            }
                          },
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have account already? ",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.purple[900],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
