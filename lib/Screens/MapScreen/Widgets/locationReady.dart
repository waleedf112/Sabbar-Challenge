import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Functionalities/googleMapCubit.dart';
import '../screen.dart';

class LocationReady extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BlocProvider(
          create: (context) => GoogleMapCubit(),
          child: MapView(),
        ),
      ],
    );
  }
}
