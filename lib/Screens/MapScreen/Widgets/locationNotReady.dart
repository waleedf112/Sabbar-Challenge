import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../UIWidgets/Buttons/ColorfulButton.dart';
import '../Functionalities/locationPermission.dart';

class LocationNotReady extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          'Find jobs near you',
          style: Theme.of(context).textTheme.headline5,
        ),
        Image.asset('assets/toAccessLocationImage.png', scale: 1.5),
        BlocBuilder<LocationPermissionCubit, bool>(
          builder: (_, __) => ColorfulButton(
            text: 'Enable Location',
            onPressed: () async => await BlocProvider.of<LocationPermissionCubit>(context).requestLocation(),
          ),
        ),
      ],
    );
  }
}
