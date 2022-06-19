import 'package:cowealth/strings/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';

class Registration extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void register(context) async {
    String name = _nameController.text.toString().trim();
    String mail = _mailController.text.toString().trim();
    String phone = _phoneController.text.toString().trim();
    String pass = _passController.text.toString().trim();
    String cpass = _cpassController.text.toString().trim();
    if (name.isEmpty || mail.isEmpty || phone.isEmpty || pass.isEmpty || cpass.isEmpty) {
      _key.currentState!.showSnackBar(new SnackBar(content: new Text('All fields must be filled')));
      return;
    }
    if (pass != cpass) {
      _key.currentState!.showSnackBar(new SnackBar(content: new Text('Password didn\'t match')));
      return;
    }
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: mail,
          password: pass
      );
      _key.currentState!.showSnackBar(new SnackBar(content: new Text('Registration successful')));
      await Future.delayed(const Duration(seconds: 2), (){});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()),);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _key.currentState!.showSnackBar(new SnackBar(content: new Text('Choose strong password')));
      } else if (e.code == 'email-already-in-use') {
        _key.currentState!.showSnackBar(new SnackBar(content: new Text('Account already exists')));
      }
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
                      'Registration',
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
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline_outlined,
                      ),
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
                      hintText: 'Enter your email',
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
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Enter your number',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.phone,
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _cpassController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Re-enter your password',
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
                  onPressed: () => register(context),
                  icon: Icon(Icons.app_registration_rounded),
                  label: Text('Tap to register'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Image.asset(
                  Strings.logo_image_path,
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
