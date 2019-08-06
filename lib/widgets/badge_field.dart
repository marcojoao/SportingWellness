import 'package:flutter/material.dart';

class BadgeField extends StatelessWidget {
  final String field;
  final Widget badge;

  BadgeField(this.field, this.badge);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white12,
          child: badge,
          radius: 14,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            field,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
