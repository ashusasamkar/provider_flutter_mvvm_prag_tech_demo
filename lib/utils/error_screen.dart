import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String msg;

  ErrorScreen({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
      ),
    );
  }
}
