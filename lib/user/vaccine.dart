import 'package:cowealth/user/dashuser.dart';
import 'package:cowealth/user/helpline.dart';
import 'package:cowealth/user/motivation.dart';
import 'package:cowealth/user/tracker.dart';
import 'package:cowealth/user/usercontact.dart';
import 'package:cowealth/user/userservice.dart';
import 'package:cowealth/user/webview.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class Vaccine extends StatelessWidget {
  final String umail;
  const Vaccine({Key? key, required this.umail}) : super(key: key);

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
                child: Text('No'),
              ),
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Vaccine',
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashUser(
                        umail: umail,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_rounded),
                title: Text('Vaccine'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Vaccine(
                          umail: umail,
                        ),
                      ),
                      (route) => false),
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
                        umail: umail,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined),
                title: Text('Services'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserService(
                        umail: umail,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Helplines'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpLine(
                        umail: umail,
                      ),
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
                      builder: (context) => Tracker(umail: umail),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_phone_outlined),
                title: Text('Contact Us'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserContact(
                        umail: umail,
                      ),
                    ),
                  ),
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              ListTile(
                title: Text('$umail'),
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
                    'About Vaccination',
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
                    'Vaccines save millions of lives each year. Vaccines work by training and preparing the body’s natural defences – the immune system – to recognize and fight off the viruses and bacteria they target. After vaccination, if the body is later exposed to those disease-causing germs, the body is immediately ready to destroy them, preventing illness.\n\nThere are several safe and effective vaccines that prevent people from getting seriously ill or dying from COVID-19. This is one part of managing COVID-19, in addition to the main preventive measures of staying at least 1 metre away from others, covering a cough or sneeze in your elbow, frequently cleaning your hands, wearing a mask and avoiding poorly ventilated rooms or opening a window.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewContainer(umail: umail)),
                  ),
                },
                icon: Icon(Icons.sticky_note_2_outlined),
                label: Text('Get vaccine'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
