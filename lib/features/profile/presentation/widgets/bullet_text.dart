import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  const BulletText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
