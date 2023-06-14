import 'package:flutter/material.dart';

import '../../domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({super.key, required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      numberTrivia.number.toString(),
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Text(
                numberTrivia.text,
                style: TextStyle(fontSize: 27),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}