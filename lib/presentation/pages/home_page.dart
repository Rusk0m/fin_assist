import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [const Text('Hello'), Text('Имя')]),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/settings_page');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}
