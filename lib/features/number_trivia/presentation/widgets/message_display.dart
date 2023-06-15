import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Text(
              '$message',
              style: const TextStyle(fontSize: 27),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ]),
    );
  }
}