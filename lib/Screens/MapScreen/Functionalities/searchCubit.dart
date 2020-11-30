import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../Classes/places.dart';
import '../Classes/searchBar.dart';

class SearchCubit extends Cubit<SearchBarCubit> {
  SearchCubit() : super(SearchBarCubit());

  final FloatingSearchBarController controller = FloatingSearchBarController();
  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;
    _query = query;
    SearchBarCubit newState;
    newState = state.clone()..isLoading = true;
    emit(newState);
    final response = await http.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=GOOGLE_MAPS_API_KEY_HERE&region=sa');
    final body = json.decode(utf8.decode(response.bodyBytes));
    final features = body['predictions'] as List;
    newState = state.clone()
      ..suggestions = features.map((e) => Place.fromJson(e)).toSet().toList()
      ..isLoading = false;
    emit(newState);
  }
}
