import 'package:cowealth/user/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../main.dart';

class WebViewContainer extends StatefulWidget {
  final String umail;
  WebViewContainer({required this.umail});

  @override
  _WebViewContainerState createState() => _WebViewContainerState(mail : umail);
}

class _WebViewContainerState extends State<WebViewContainer> {
  final String mail;
  _WebViewContainerState({required this.mail});
  late WebViewController _controller;
  Logger logger = Logger();

  double progress = 0;
  late InAppWebViewController webView;
  // ignore: non_constant_identifier_names
  var URL = "https://cowin.gov.in/";
  // ignore: non_constant_identifier_names
  var LISTENINGURL = "https://google.com/";

  Future<bool> _onBack() async {
    bool goBack = true;
    var value = await webView.canGoBack();
    if (value) {
      webView.goBack();
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to exit?'),
          actions: [
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
      if (goBack == true) Navigator.pop(context);
      return goBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Co-win portal',
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
        body: Container(
          child: Column(
            children: [
              (progress != 1.0)
                  ? LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.lightBlue))
                  : Text(''),
              Expanded(
                child: Container(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(URL),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, url) {
                      if (url.toString() == LISTENINGURL) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Vaccine(umail: mail,)),
                        );
                      }
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
            // ignore: unnecessary_null_comparison
            ].where((Object o) => o != null).toList(),
          ),
        ),
      ),
    );
  }
}
