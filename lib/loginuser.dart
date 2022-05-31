import 'package:cowealth/custom_widgets/logo.dart';
import 'package:cowealth/custom_widgets/regular_text.dart';
import 'package:cowealth/forgot.dart';
import 'package:cowealth/strings/strings.dart';
import 'package:cowealth/user/dashuser.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUser extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _mailController = TextEditingController();
  final _passController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void login(context) async {
    String mail = _mailController.text.toString().trim();
    String pass = _passController.text.toString().trim();
    if (mail.isEmpty || pass.isEmpty) {
      _key.currentState!.showSnackBar(
          new SnackBar(content: new Text('All fields must be filled')));
      return;
    }
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      _key.currentState!
          .showSnackBar(new SnackBar(content: new Text('Login successful')));
      String email = userCredential.user!.email.toString();
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DashUser(umail: email)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _key.currentState!
            .showSnackBar(new SnackBar(content: new Text('No user found')));
      } else if (e.code == 'wrong-password') {
        _key.currentState!.showSnackBar(
            new SnackBar(content: new Text('Invalid credentials')));
      } else {
        _key.currentState!.showSnackBar(
            new SnackBar(content: new Text('Something went wrong')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Align(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'User login',
                      textStyle: const TextStyle(
                        fontFamily: 'LatoBlack',
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Registered email address',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _passController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.password,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                  onPressed: () => login(context),
                  icon: Icon(Icons.login),
                  label: RegularText(Strings.tap_to_login),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue),
                  ),
                ),
                RegularText(Strings.or),
                ElevatedButton.icon(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    ),
                  },
                  icon: Icon(Icons.password),
                  label: RegularText(Strings.forgot_password),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                AppLogo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
