import 'places.dart';

class SearchBarCubit {
  bool isLoading = false;
  List<Place> suggestions = [];
  SearchBarCubit({this.isLoading, this.suggestions});
  SearchBarCubit clone() => SearchBarCubit(isLoading: this.isLoading, suggestions: this.suggestions);
}
