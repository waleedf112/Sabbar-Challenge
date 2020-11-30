import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class JobCategories extends StatelessWidget {
  final Map<String, String> categories = {
    'Drivers &\nCouriers': 'drivers.jpg',
    'Events\nOrganizers': 'event.jpg',
    'Baristas &\nWaiting': 'baristas.jpg',
    'Customers\'\nService': 'customer service.jpg',
    'Cooking': 'cooking.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  AutoSizeText(
                    'Jobs Categories',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ))
          ],
        ),
        Container(
          height: 110,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _JobCategory(
                  title: categories.keys.elementAt(index),
                  image: categories.values.elementAt(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _JobCategory extends StatelessWidget {
  final String title;
  final String image;

  const _JobCategory({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/job categories/$image'),
          fit: BoxFit.fitHeight,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
