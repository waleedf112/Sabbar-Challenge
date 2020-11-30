import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../UIWidgets/Buttons/ColorfulButton.dart';
import '../JobsScreen/Functionalities/jobsOnMapRadius.dart';
import '../JobsScreen/screen.dart';
import 'Classes/places.dart';
import 'Functionalities/googleMapCubit.dart';
import 'Functionalities/locationPermission.dart';
import 'Widgets/locationNotReady.dart';
import 'Widgets/locationReady.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPermissionCubit, bool>(
      builder: (context, isReady) {
        if (isReady == null) {
                BlocProvider.of<LocationPermissionCubit>(context).initState();
                return Center(child: CircularProgressIndicator());
              }
        if (isReady)
          return LocationReady();
        else
          return LocationNotReady();
      },
    );
  }
}

class MapView extends StatelessWidget {
  Widget _buildMapView({
    @required BuildContext context,
    @required LocationData currentLocation,
    @required Set<Marker> markers,
  }) {
    CameraPosition initialCamera = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 12,
    );
    return GoogleMap(
      mapType: MapType.normal,
      indoorViewEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      initialCameraPosition: initialCamera,
      markers: markers,
      onLongPress: BlocProvider.of<GoogleMapCubit>(context).changeMarker,
      onMapCreated: BlocProvider.of<GoogleMapCubit>(context).initController,
    );
  }

  Widget _buildCurrentLocationButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: () async => await BlocProvider.of<GoogleMapCubit>(context).moveCameraToCurrentLocation(),
          padding: EdgeInsets.all(0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: CircleBorder(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Transform.rotate(
              angle: 45 * pi / 180,
              alignment: Alignment(0.2, 0.2),
              child: Icon(
                CupertinoIcons.location_north_fill,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSaveButton({@required BuildContext context, @required Set<Marker> markers}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 10),
      child: ColorfulButton(
        text: 'Save',
        onPressed: () async {
          if (markers.isNotEmpty) {
            String address = await getAddressFromLatLng(markers.first.position);
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => JobsOnMapRadiusCubit(
                  address: address,
                  latLng: markers.first.position,
                ),
                child: JobsScreen(),
              ),
            );
            Navigator.push(context, route);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapCubit, Set<Marker>>(
      builder: (context, state) => Expanded(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: BlocProvider.of<GoogleMapCubit>(context).getCurrentLocation(),
              builder: (context, AsyncSnapshot<LocationData> currentLocation) {
                if (!currentLocation.hasData) return Center(child: CircularProgressIndicator());
                return _buildMapView(
                  context: context,
                  currentLocation: currentLocation.data,
                  markers: state,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildCurrentLocationButton(context),
                  _buildSaveButton(context: context, markers: state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
