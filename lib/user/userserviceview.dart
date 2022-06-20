import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class UserServiceView extends StatefulWidget {
  final pin, chosenValue;
  UserServiceView({this.pin, this.chosenValue});

  @override
  _UserServiceViewState createState() =>
      _UserServiceViewState(pin: pin, chosenValue: chosenValue);
}

class _UserServiceViewState extends State<UserServiceView> {
  final pin, chosenValue;
  _UserServiceViewState({this.chosenValue, this.pin});

  void call(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('allservices')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return Expanded(
                  child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: documents
                          .map(
                            (doc) => Card(
                              child: (pin == doc['pin'] &&
                                      chosenValue == doc['category'])
                                  ? ListTile(
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
                                                onPressed: () => call(doc['phone']),
                                                icon: Icon(
                                                  Icons.call,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          )
                          .toList()),
                );
              } else if (snapshot.hasError) {
                return Text('Error!');
              } else {
                return Text('Something went wrong');
              }
            },
          ),
        ],
      ),
    );
  }
}
