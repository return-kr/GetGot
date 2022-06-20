import 'package:cowealth/strings/strings.dart';
import 'package:cowealth/user/dashuser.dart';
import 'package:cowealth/user/helpline.dart';
import 'package:cowealth/user/motivation.dart';
import 'package:cowealth/user/tracker.dart';
import 'package:cowealth/user/usercontact.dart';
import 'package:cowealth/user/userserviceview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class UserService extends StatefulWidget {
  final String umail;
  UserService({required this.umail});

  @override
  _UserServiceState createState() => _UserServiceState(mail: umail);
}

class _UserServiceState extends State<UserService> {
  final String mail;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _pinController = TextEditingController();
  late String _chosenValue = "Select Service Category";
  _UserServiceState({required this.mail});

  void _search() {
    String pin = _pinController.text.toString().trim();
    if (_chosenValue == "Select Service Category" || pin.isEmpty) {
      _key.currentState!.showSnackBar(
        new SnackBar(
          content: new Text('Both field should be chosen'),
          backgroundColor: Colors.blueGrey,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UserServiceView(pin: pin, chosenValue: _chosenValue)),
    );
    _pinController.clear();
  }

  Future<void> call(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        key: _key,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Services',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
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
                child: Image.asset(Strings.logo_image_path),
              ),
              ListTile(
                leading: Icon(Icons.home_filled),
                title: Text('Home'),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashUser(
                        userMail: mail,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.accessibility_new_outlined),
                title: Text(Strings.feedback),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Motivation(
                        umail: mail,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined),
                title: Text('Services'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => UserService(
                          umail: mail,
                        ),
                      ),
                      (route) => false),
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
                        umail: mail,
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
                      builder: (context) => Tracker(umail: mail),
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
                        umail: mail,
                      ),
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Area PIN',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                child: TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'PIN',
                    hintText: 'Enter your PIN code',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.pin_drop_outlined,
                    ),
                  ),
                ),
              ),
              DropdownButton<String>(
                style: TextStyle(color: Colors.blue, fontSize: 18.0),
                hint: Text('$_chosenValue'),
                items: <String>[
                  'Oxygen',
                  'Home Delivery',
                  'Medical Support',
                  'Transport',
                  'TO-LET',
                  'Rental/PG',
                  'Room Service',
                  'Emergency Services',
                  'Others'
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _chosenValue = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () => _search(),
                icon: Icon(Icons.search_rounded),
                label: Text('Search'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'All services:',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('allservices')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return Expanded(
                      child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: documents
                              .map(
                                (doc) => Card(
                                  child: ListTile(
                                    title: Text(doc['content']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(doc['name']),
                                        Text(doc['phone']),
                                        Text(doc['category']),
                                        Text(doc['mail']),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () =>
                                                  call(doc['phone']),
                                              icon: Icon(
                                                Icons.call,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error!');
                  } else {
                    return Text('');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
