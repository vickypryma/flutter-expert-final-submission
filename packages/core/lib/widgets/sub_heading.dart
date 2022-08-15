import 'package:flutter/material.dart';

import '../../styles/text_styles.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final Function() onTap;

  const SubHeading({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kHeading6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ],
      ),
    );
  }
}
