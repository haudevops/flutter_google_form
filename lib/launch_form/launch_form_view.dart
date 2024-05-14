import 'package:flutter/material.dart';
import 'package:flutter_google_form/utils/screen_argument.dart';

class LaunchFormView extends StatefulWidget {
  const LaunchFormView({super.key, required this.data});
  final ScreenArguments data;

  @override
  State<LaunchFormView> createState() => _LaunchFormViewState();
}

class _LaunchFormViewState extends State<LaunchFormView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
      ),
    );
  }
}
