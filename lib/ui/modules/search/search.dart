import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcom to Search Screen'),
      ),
      body: Container(child: const Text('Welcom to Search screen')),
    );
  }
}
