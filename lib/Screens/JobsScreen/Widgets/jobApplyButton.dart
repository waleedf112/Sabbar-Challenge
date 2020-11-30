import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Color.fromRGBO(2, 206, 88, 1),
              size: 30,
            ),
            SizedBox(height: 5),
            Text(
              'Applied',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Color.fromRGBO(2, 206, 88, 1),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
