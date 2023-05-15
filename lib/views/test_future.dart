import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestFuture extends StatefulWidget {
  const TestFuture({super.key});

  @override
  State<TestFuture> createState() => _TestFutureState();
}

class _TestFutureState extends State<TestFuture> {
  String text = 'sinhronno ishtedi';
  String? textAsync;

  @override
  void initState() {
    getText();
    super.initState();
  }

  Future<String> getText() async {
    try {
      return await Future.delayed(Duration(seconds: 6), () {
        setState(() {});
        return textAsync = 'keldi';
      });
    } catch (kata) {
      throw Exception(kata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 35),
            ),
            Text(
              textAsync ?? 'emi kelet',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'salam',
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }
}
