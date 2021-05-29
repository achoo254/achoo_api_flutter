import 'package:achoo_api/app/theme/vertical_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Logo extends StatelessWidget {
  String title;
  final Widget logo = Image.asset(
    'assets/logo/logo.png',
    width: 200,
  );

  Logo(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 300.0),
                  child: VerticalText(title)),
              logo,
            ],
          ),
        ],
      ),
    );
  }
}
