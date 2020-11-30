import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

class LocationPermissionCubit extends Cubit<bool> {
  LocationPermissionCubit() : super(null);

  Future<void> requestLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) _permissionGranted = await location.requestPermission();
    if (!_serviceEnabled || _permissionGranted == PermissionStatus.denied)
      emit(false);
    else
      emit(true);
  }

  Future<void> initState() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    if (!_serviceEnabled || _permissionGranted == PermissionStatus.denied)
      emit(false);
    else
      emit(true);
  }
}
