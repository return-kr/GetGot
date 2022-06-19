import 'package:flutter/material.dart';

import '../strings/strings.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Image.asset(
        Strings.logo_image_path,
        height: 200,
      ),
    );
  }
}
