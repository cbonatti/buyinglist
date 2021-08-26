import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingBouncingGrid.square(
          borderColor: Colors.teal,
          borderSize: 3.0,
          size: 30.0,
          backgroundColor: Colors.tealAccent,
        ),
        Text("Carregando"),
      ],
    );
  }
}
