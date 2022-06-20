import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class ServiceView extends StatefulWidget {
  final String umail;
  ServiceView({required this.umail});

  @override
  _ServiceViewState createState() => _ServiceViewState(mail: umail);
}

class _ServiceViewState extends State<ServiceView> {
  final String mail;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  _ServiceViewState({required this.mail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Service Posts',
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your service list:',
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
                  .collection(mail + '_service')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              color: Colors.green.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            title: Text(ds['content']),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(ds['name']),
                                SizedBox(
                                  width: 10.0,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .runTransaction(
                                            (Transaction myTransaction) async {
                                      myTransaction.delete(
                                          snapshot.data!.docs[index].reference);
                                    });
                                    String str = ds['content'];
                                    FirebaseFirestore.instance
                                        .collection('allservices')
                                        .where('content', isEqualTo: str)
                                        .get()
                                        .then((snap) {
                                      for (DocumentSnapshot docSnap
                                          in snap.docs) {
                                        docSnap.reference.delete();
                                      }
                                    });
                                    _key.currentState!.showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                'Deleted successfully')));
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
    );
  }
}
