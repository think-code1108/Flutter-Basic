import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/signin_page.dart';

import '../services/auth_service.dart';
import '../widgets/pesan_info.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  bool isSignup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4E4E4),
      appBar: AppBar(
        title: Text("Signup Form"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
                height: 16,
              ),
              TextField(
                controller: rePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Re-Type Password",
                    hintText: "Re-Type Password"),
              ),
              SizedBox(
                height: 30,
              ),
              (isSignup)
                  ? SizedBox(
                      child: CircularProgressIndicator(),
                      height: 50,
                      width: 50,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            //--> Cek email dan password
                            if (!EmailValidator.validate(
                                emailController.text)) {
                              ShowPesan.Warning(
                                  "Email is not valid, please try again.");
                              return;
                            }
                            if (passwordController.text.length < 6) {
                              ShowPesan.Warning(
                                  "Password is not valid, please try again.");
                              return;
                            }
                            if (passwordController.text !=
                                rePasswordController.text) {
                              ShowPesan.Warning(
                                  "Password is not not equal with re-type Password, please try again");
                              return;
                            }

                            //--> Loading Screen
                            setState(() {
                              isSignup = true;
                            });

                            SignInSignUpResult responLogin =
                                await AuthServices.signUp(emailController.text,
                                    passwordController.text);

                            if (responLogin.user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninPage(),
                                ),
                              );
                            } else {
                              //--> Hide Loading Screen
                              setState(() {
                                isSignup = false;
                              });

                              ShowPesan.Error(responLogin.message!);
                            }
                          },
                          icon: Icon(Icons.logout),
                          label: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Signup",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel),
                          label: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber[600]),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
