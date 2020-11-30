import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../Classes/job.dart';

class TitleAndDescription extends StatelessWidget {
  final Job job;
  TitleAndDescription(this.job);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              job.type.toString(),
              style: Theme.of(context).textTheme.subtitle1.apply(fontSizeFactor: 2),
            ),
            SizedBox(height: 6),
            AutoSizeText(
              job.company.toString(),
              style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.black.withOpacity(.3)),
            ),
          ],
        ),
      ),
    );
  }
}
