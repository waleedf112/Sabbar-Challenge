import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../MapScreen/Functionalities/googleMapCubit.dart';
import '../MapScreen/Functionalities/locationPermission.dart';
import '../MapScreen/Functionalities/searchCubit.dart';
import '../MapScreen/Widgets/searchBar.dart';
import '../MapScreen/screen.dart';
import 'Widgets/expandedAppBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MapScreen(),
          ExpandedAppBar(),
          BlocBuilder<LocationPermissionCubit, bool>(
            builder: (_, isReady) {
              if (isReady == null) {
                BlocProvider.of<LocationPermissionCubit>(context).initState();
                return Center(child: CircularProgressIndicator());
              }
              if (!isReady)
                return Container();
              else
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
                    BlocProvider<GoogleMapCubit>(create: (_) => GoogleMapCubit()),
                  ],
                  child: SearchBar(),
                );
            },
          ),
        ],
      ),
    );
  }
}
