//@dart=2.9
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      key: Key("skeleton"),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
      itemCount: 6,
      itemBuilder: (_, i) => Shimmer.fromColors(
        baseColor: theme.iconTheme.color.withOpacity(0.15),
        highlightColor: theme.iconTheme.color.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.grey,
              ),
              width: 150.0,
              height: 14.0,
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.grey,
              ),
              height: 14.0,
            ),
            SizedBox(height: 37.0)
          ],
        ),
      ),
    );
  }
}
