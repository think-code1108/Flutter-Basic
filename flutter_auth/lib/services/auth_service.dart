import 'package:firebase_auth/firebase_auth.dart' as auth;

//--> Class Helper For  Sign in or Sign up Result
class SignInSignUpResult {
  final auth.User? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}

class AuthServices {
  //--> Init Firebase Auth
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //--> Sign Up Function
  static Future<SignInSignUpResult> signUp(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return SignInSignUpResult(user: result.user);
    } on auth.FirebaseAuthException catch (e) {
      return SignInSignUpResult(message: e.message);
    }
  }

  //--> Sign In Function
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return SignInSignUpResult(user: result.user);
    } on auth.FirebaseAuthException catch (e) {
      return SignInSignUpResult(message: e.message);
    }
  }

  //--> Sign Out Function
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  //--> Stream user data
  static Stream<auth.User?> get userStream => _auth.authStateChanges();
}
