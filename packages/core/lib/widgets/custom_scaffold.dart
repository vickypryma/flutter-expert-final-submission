import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const CustomScaffold({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, key: Key('drawer_button')),
        title: Text(title),
        actions: [
          IconButton(
            key: const Key('search_button'),
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: body,
    );
  }
}
