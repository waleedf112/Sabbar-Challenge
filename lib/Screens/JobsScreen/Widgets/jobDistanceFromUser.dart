import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../Classes/job.dart';
import '../Functionalities/jobsOnMapRadius.dart';

class JobDistanceFromUser extends StatelessWidget {
  final Job job;

  const JobDistanceFromUser(this.job);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            CupertinoIcons.location,
            color: Colors.grey,
            size: 20,
          ),
          FutureBuilder(
            future: job.calculateDistance(context),
            builder: (context, snapshot) {
              bool isLoaded = snapshot.connectionState != ConnectionState.done;
              return AnimatedCrossFade(
                firstChild: Shimmer.fromColors(
                  highlightColor: Colors.grey.withOpacity(.3),
                  baseColor: Colors.grey.withOpacity(.05),
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      '------------------------------------------------------',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                secondChild: Container(
                  width: 200,
                  child: Text(
                    '${job.distance} km away - ${BlocProvider.of<JobsOnMapRadiusCubit>(context).address}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                crossFadeState: isLoaded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}
