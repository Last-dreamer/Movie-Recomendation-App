import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FailureBody(message: message),
    );
  }
}

class FailureBody extends StatelessWidget {
  const FailureBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
