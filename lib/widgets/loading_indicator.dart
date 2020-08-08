import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: SpinKitCircle(
            itemBuilder: (context, index) => CircleAvatar(
              backgroundColor: Colors.grey[800],
            ),
          ),
        ),
      );
  }
}