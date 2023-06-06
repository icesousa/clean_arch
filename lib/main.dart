import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Number Trivia')),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '123',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '123 is the atomic number of the yet-to-be-discovered element unbitrium.',
                  style: TextStyle(fontSize: 27),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Input a Number', border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                        width: 120,
                        child: Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    style: ButtonStyle(),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Get Random Trivia',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
