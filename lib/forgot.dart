import 'package:cowealth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ForgotPassword extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _mailController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void forgot(context) async {
    String mail = _mailController.text.toString().trim();
    if (mail.isEmpty){
      _key.currentState!.showSnackBar(new SnackBar(content: new Text('Please provide email')));
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: mail);
      _key.currentState!.showSnackBar(new SnackBar(content: new Text('Link has been sent')));
      await Future.delayed(const Duration(seconds: 2), (){});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()),);
    } catch (e) {
      _key.currentState!.showSnackBar(new SnackBar(content: new Text(e.toString())));
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
                      'Reset password',
                      textStyle: const TextStyle(
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
                  child: Text(
                    'Enter your registered email address to get the password reset link',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _mailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Registered email',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                  onPressed: () => forgot(context),
                  icon: Icon(Icons.forward_to_inbox),
                  label: Text('Get link'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Image.asset(
                  'images/logo.jpeg',
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
