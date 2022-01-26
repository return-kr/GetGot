import 'package:cowealth/user/helpline.dart';
import 'package:cowealth/user/motivation.dart';
import 'package:cowealth/user/tracker.dart';
import 'package:cowealth/user/usercontact.dart';
import 'package:cowealth/user/userservice.dart';
import 'package:cowealth/user/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import '../main.dart';

// ignore: must_be_immutable
class DashUser extends StatefulWidget {
  final String umail;
  DashUser({required this.umail});
  @override
  _DashUserState createState() => _DashUserState(mail: umail);
}

class _DashUserState extends State<DashUser> {
  final String mail;
  _DashUserState({required this.mail});

  Future<bool> _willPopScope() async {
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
      onWillPop: () => _willPopScope(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Image.asset('images/logo.jpeg'),
              ),
              ListTile(
                leading: Icon(Icons.home_filled),
                title: Text('Home'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => DashUser(umail: mail),
                      ),
                      (route) => false),
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_rounded),
                title: Text('Vaccine'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Vaccine(
                        umail: mail.toString(),
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.accessibility_new_outlined),
                title: Text('Motivation'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Motivation(
                        umail: mail.toString(),
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined),
                title: Text('Services'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserService(umail: mail),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Helplines'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpLine(umail: mail),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.track_changes_outlined),
                title: Text('COVID-19 Tracker'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Tracker(umail: mail),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_phone_outlined),
                title: Text('Contact Us'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserContact(umail: mail),
                    ),
                  ),
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              ListTile(
                title: Text('$mail'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/logo.jpeg'),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'About COVID-19',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Container(
                  color: Colors.amber,
                  child: Text(
                    'Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus.\nMost people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'How It Spreads',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Container(
                  color: Colors.amber,
                  child: Text(
                    'The virus that causes COVID-19 is mainly transmitted through droplets generated when an infected person coughs, sneezes, or exhales. These droplets are too heavy to hang in the air, and quickly fall on floors or surfaces.\nYou can be infected by breathing in the virus if you are within close proximity of someone who has COVID-19, or by touching a contaminated surface and then your eyes, nose or mouth.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Preventions Of COVID-19',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Container(
                  color: Colors.amber,
                  child: Text(
                    'Clean your hands often. Use soap and water, or an alcohol-based hand rub.\n\nMaintain a safe distance from anyone who is coughing or sneezing.\n\nWear a mask when physical distancing is not possible.\n\nDon’t touch your eyes, nose or mouth.\n\nCover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.\n\nStay home if you feel unwell.\n\nIf you have a fever, cough and difficulty breathing, seek medical attention.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
