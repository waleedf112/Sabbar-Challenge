import 'package:flutter/material.dart';

class JobCreationDate extends StatelessWidget {
  final String creationDate;

  const JobCreationDate(this.creationDate);

  @override
  Widget build(BuildContext context) {
    return Text(
      creationDate.toString(),
      style: Theme.of(context).textTheme.caption,
    );
  }
}
