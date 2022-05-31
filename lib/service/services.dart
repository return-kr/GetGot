import 'package:cowealth/main.dart';
import 'package:cowealth/service/serviceview.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'dashservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services extends StatefulWidget {
  final String umail;
  Services({required this.umail});

  @override
  _ServicesState createState() => _ServicesState(mail: umail);
}

class _ServicesState extends State<Services> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late String _chosenValue = "Select Service Category";
  final String mail;
  _ServicesState({required this.mail});

  void post() async {
    String name = _nameController.text.toString().trim();
    String phone = _phoneController.text.toString().trim();
    String pin = _pinController.text.toString().trim();
    String content = _contentController.text.toString().trim();
    try {
      FirebaseFirestore.instance.collection(mail + '_service').add({
        'name': name,
        'mail': mail,
        'category': _chosenValue,
        'phone': phone,
        'pin': pin,
        'content': content
      });
      FirebaseFirestore.instance.collection('allservices').add({
        'name': name,
        'mail': mail,
        'category': _chosenValue,
        'phone': phone,
        'pin': pin,
        'content': content
      });
      _key.currentState!
          .showSnackBar(SnackBar(content: Text('Posted successfully')));
    } catch (e) {
      _key.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString().trim())));
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
                child: Image.asset('images/logo.png'),
              ),
              ListTile(
                leading: Icon(Icons.home_filled),
                title: Text('Home'),
                onTap: () => {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => DashService(umail: mail)),
                  ),
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined),
                title: Text('Services'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Services(umail: mail)),
                      (route) => false),
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
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Post Your Service',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter full name',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Enter running phone number',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.phone_android,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: _pinController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'PIN Code',
                      hintText: 'Enter area PIN code',
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: TextFormField(
                      controller: _contentController,
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Write about your service',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton.icon(
                  onPressed: () => post(),
                  icon: Icon(Icons.medical_services),
                  label: Text('Tap to post'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceView(umail: mail)),
                    );
                  },
                  icon: Icon(Icons.all_inbox_outlined),
                  label: Text('View your posts'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
