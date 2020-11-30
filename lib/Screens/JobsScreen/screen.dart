import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../HomeScreen/Widgets/expandedAppBar.dart';
import 'Classes/job.dart';
import 'Functionalities/jobsOnMapRadius.dart';
import 'Widgets/jobApplyButton.dart';
import 'Widgets/jobAvatar.dart';
import 'Widgets/jobCreationDate.dart';
import 'Widgets/jobDetails.dart';
import 'Widgets/jobDistanceFromUser.dart';
import 'Widgets/jobFavButton.dart';
import 'Widgets/jobTitleAndDescription.dart';
import 'Widgets/jobsCategories.dart';

class JobsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BlocBuilder<JobsOnMapRadiusCubit, LatLng>(
            builder: (context, state) => ExpandedAppBar(
              selectedLocation: BlocProvider.of<JobsOnMapRadiusCubit>(context).address,
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                JobCategories(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                  child: Divider(color: Colors.black.withOpacity(.6), thickness: 2),
                ),
                _ListOfAvailableJobs(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListOfAvailableJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              AutoSizeText(
                'Jobs you may be interested in',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: BlocProvider.of<JobsOnMapRadiusCubit>(context).getJobs(),
          builder: (context, AsyncSnapshot<List<Job>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _JobOffer(snapshot.data[index]);
              },
            );
          },
        ),
      ],
    );
  }
}

class _JobOffer extends StatelessWidget {
  final Job job;

  _JobOffer(this.job);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      shadowColor: Colors.blueGrey.withOpacity(.3),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      JobAvatar(job),
                      TitleAndDescription(job),
                    ],
                  ),
                ),
                FavButton(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: <Widget>[
                JobDetails(job.details),
                ApplyButton(),
              ],
            ),
          ),
          Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                JobDistanceFromUser(job),
                JobCreationDate(job.creationDate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
