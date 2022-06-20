import 'package:cowealth/custom_widgets/medium_text.dart';
import 'package:cowealth/custom_widgets/regular_text.dart';
import 'package:cowealth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SessionExpired extends StatelessWidget {
  const SessionExpired({Key? key}) : super(key: key);

  Future<bool> _willPopScope(context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do you want you exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopScope(context),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MediumText("Session expired"),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                  child: RegularText('Main menu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
