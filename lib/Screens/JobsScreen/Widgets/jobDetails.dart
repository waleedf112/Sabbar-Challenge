import 'package:flutter/material.dart';

class JobDetails extends StatelessWidget {
  final List<String> details;
  JobDetails(this.details);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        spacing: 10,
        runSpacing: 7,
        children: <Widget>[
          for (String item in this.details)
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.teal.withOpacity(0.4)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 10),
                ),
              ),
            )
        ],
      ),
    );
  }
}
