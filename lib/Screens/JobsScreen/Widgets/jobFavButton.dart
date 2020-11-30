import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.star,
        size: 28,
        color: Colors.grey.withOpacity(.7),
      ),
      onPressed: () {},
    );
  }
}
