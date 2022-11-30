// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First app',
      routes: {
        '/firstroute': (context) => const FirstRoute(),
        '/secondroute': (context) => const SecondRoute(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First app'),
        ),
        body: Column(children: <Widget>[
          Expanded(child: MyListView()),
          const MyButton(),
          const Text('Made by Gorm')
        ]),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  const MyButton({
    Key? key,
  }) : super(key: key);

  @override
  State<MyButton> createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  int buttonColor = 900;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          buttonColor = buttonColor - 200;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FirstRoute()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.amber[buttonColor],
        ),
        child: const Text('Double Click to Open Route'),
      ),
    );
  }
}

class MyListViewState extends State<MyListView> {
  TextEditingController noteController = TextEditingController();

  void addItemToList() {
    setState(() {
      widget.entries.insert(0, noteController.text);
      noteController.text = '';
    });
  }

  void removeItemFromList(value) {
    setState(() {
      widget.entries.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(children: <Widget>[
        TextField(
          controller: noteController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Note',
          ),
        ),
        ElevatedButton(
          child: Text('Add Note'),
          onPressed: () {
            addItemToList();
          },
        ),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: widget.entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(4),
                      color: Color.fromRGBO(
                          57, 197, 243, 0.95 - (index % 2 * 0.5)),
                      child: Row(children: <Widget>[
                        Expanded(child: Text(widget.entries[index])),
                        Container(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  removeItemFromList(widget.entries[index]);
                                },
                                child: const Text('X')))
                      ]),
                    )),
                  ]);
                }))
      ]),
    );
  }
}

class MyListView extends StatefulWidget {
  final List<String> entries = <String>[
    'Homework',
    'Workout',
    'Dinner',
    'Read'
  ];
  final int colorCode = 57;
  MyListView({super.key});

  @override
  State<MyListView> createState() => MyListViewState();
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
            child: const Text('Open route'),
            // Within the `FirstRoute` widget
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            }),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondRoute widget
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
