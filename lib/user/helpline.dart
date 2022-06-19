import 'package:cowealth/strings/strings.dart';
import 'package:cowealth/user/dashuser.dart';
import 'package:cowealth/user/motivation.dart';
import 'package:cowealth/user/tracker.dart';
import 'package:cowealth/user/usercontact.dart';
import 'package:cowealth/user/userservice.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class HelpLine extends StatelessWidget {
  final List<String> states = <String>[
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'Uttar Pradesh',
    'West Bengal',
    'Andaman & Nicobar Islands',
    'Chandigarh',
    'Dadra & Nagar Haveli',
    'Daman & Diu',
    'Delhi',
    'Jammu',
    'Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry'
  ];
  final List<String> stcontact = <String>[
    '0866-2410978',
    '9436055743',
    '6913347770',
    '104',
    '077122-35091',
    '104',
    '104',
    '8558893911',
    '104',
    '104',
    '104',
    '0471-2552056',
    '0755-2527177',
    '020-26127394',
    '03852411668',
    '108',
    '102',
    '7005539653',
    '9439994859',
    '104',
    '0141-2225624',
    '104',
    '044-29510500',
    '104',
    '0381-2315879',
    '104',
    '18001805145',
    '03323412600',
    '03192-232102',
    '9779558282',
    '104',
    '104',
    '011-22307145',
    '01912520982',
    '01942440283',
    '01982256462',
    '104',
    '104'
  ];
  final String umail;
  HelpLine({required this.umail});

  void call(String number) async {
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Helplines',
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
                        userMail: umail.toString(),
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
                        umail: umail.toString(),
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
                        umail: umail.toString(),
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Helplines'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HelpLine(
                          umail: umail,
                        ),
                      ),
                      (route) => false),
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
                        umail: umail.toString(),
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Customer care numbers',
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
                height: 5.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: states.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.green.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${states[index]}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19.0),
                          ),
                          Text(
                            '${stcontact[index].substring(4, stcontact[index].length)}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          IconButton(
                            onPressed: () => call(stcontact[index]
                                .substring(4, stcontact[index].length)),
                            icon: Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
