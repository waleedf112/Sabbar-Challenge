import 'package:flutter/material.dart';

import '../Classes/job.dart';

class JobAvatar extends StatelessWidget {
  final Job job;
  JobAvatar(this.job);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(.3),
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FutureBuilder(
          future: job.getPhoto(),
          builder: (context, snapshot) {
            bool isLoaded = snapshot.connectionState == ConnectionState.done;
            AssetImage placeHolderImage = AssetImage('assets/placeHolder.png');
            MemoryImage image;
            if (isLoaded) image = MemoryImage(snapshot.data);
            return AnimatedCrossFade(
              firstChild: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: placeHolderImage,
                onBackgroundImageError: (_, __) {},
              ),
              secondChild: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: snapshot != null && image != null ? image : placeHolderImage,
                onBackgroundImageError: (_, __) {},
              ),
              crossFadeState: isLoaded && image != null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 500),
            );
          },
        ),
      ),
    );
  }
}
