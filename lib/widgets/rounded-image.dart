import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage(
      {Key? key, required this.imagePath, this.width = 50, this.height = 50})
      : super(key: key);
  final String imagePath;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.fill),
      ),
    );
  }
}
