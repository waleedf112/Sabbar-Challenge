import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedAppBar extends StatelessWidget {
  final String selectedLocation;

  ExpandedAppBar({this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 30, 3, 32),
                child: Row(
                  children: [
                    _ExpandedAppBarLogo(),
                    _ExpandedAppBarTitle(),
                    Spacer(),
                    if (selectedLocation != null) _ExpandedAppBarLocation(selectedLocation),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpandedAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Find Jobs',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _ExpandedAppBarLocation extends StatelessWidget {
  final String selectedLocation;
  _ExpandedAppBarLocation(this.selectedLocation);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2, bottom: 2),
            child: Icon(
              CupertinoIcons.location,
              color: Colors.white,
              size: 18,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              this.selectedLocation,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandedAppBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset('assets/logo/white_logo.png', height: 25),
    );
  }
}

