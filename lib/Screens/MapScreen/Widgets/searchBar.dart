import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../Classes/places.dart';
import '../Classes/searchBar.dart';
import '../Functionalities/googleMapCubit.dart';
import '../Functionalities/searchCubit.dart';

class SearchBar extends StatelessWidget {
  final List<FloatingSearchBarAction> actions = [
    FloatingSearchBarAction(
      showIfOpened: false,
      child: CircularButton(
        icon: const Icon(Icons.search),
        onPressed: null,
      ),
    ),
    FloatingSearchBarAction.searchToClear(
      showIfClosed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchBarCubit>(
      builder: (BuildContext context, SearchBarCubit cubit) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 78, horizontal: 20),
        child: FloatingSearchBar(
          controller: BlocProvider.of<SearchCubit>(context).controller,

          // Text:
          hint: 'Search location',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.6)),
          queryStyle: TextStyle(color: Colors.black54, fontSize: 12),

          // Colors:
          backdropColor: Colors.transparent,
          iconColor: Colors.grey.withOpacity(0.6),

          // Style:
          elevation: 12,
          margins: EdgeInsets.all(0),
          openAxisAlignment: 0.0,
          maxWidth: 500,
          transition: CircularFloatingSearchBarTransition(),
          scrollPadding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(2),

          // Animations:
          transitionDuration: const Duration(milliseconds: 500),
          transitionCurve: Curves.easeInOutCubic,
          physics: const ScrollPhysics(),
          debounceDelay: const Duration(milliseconds: 500),

          // Other
          body: Container(),
          leadingActions: actions,
          actions: <Widget>[],
          progress: cubit.isLoading,
          onQueryChanged: BlocProvider.of<SearchCubit>(context).onQueryChanged,
          builder: (context, _) => _SearchBarResultBody(cubit.suggestions),
        ),
      ),
    );
  }
}

class _SearchBarResultItem extends StatelessWidget {
  final Place place;

  const _SearchBarResultItem(this.place);

  void _selectOnMap(BuildContext context) {
    FloatingSearchBar.of(context).close();
    BlocProvider.of<GoogleMapCubit>(context).selectOnMap(place.placeId);
  }

  Widget _icon() => SizedBox(
        width: 36,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: const Icon(
            CupertinoIcons.location,
            color: Colors.grey,
            key: Key('place'),
          ),
        ),
      );

  Widget _text(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 2),
          Text(
            place.address,
            style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<GoogleMapCubit, Set<Marker>>(
          builder: (context, _) => InkWell(
            onTap: () => _selectOnMap(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _icon(),
                  const SizedBox(width: 16),
                  _text(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBarResultBody extends StatelessWidget {
  final List<Place> places;

  const _SearchBarResultBody(this.places);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4.0,
      child: ImplicitlyAnimatedList<Place>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        items: places?.take(6)?.toList() ?? [],
        areItemsTheSame: (firstItem, secondItem) => firstItem == secondItem,
        itemBuilder: (_, animation, place, i) => SizeFadeTransition(
          animation: animation,
          child: _SearchBarResultItem(place),
        ),
        updateItemBuilder: (_, animation, place) => FadeTransition(
          opacity: animation,
          child: _SearchBarResultItem(place),
        ),
      ),
    );
  }
}
