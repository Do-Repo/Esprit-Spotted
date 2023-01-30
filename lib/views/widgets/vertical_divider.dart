import 'package:flutter/material.dart';

class VerticalDiv extends StatelessWidget {
  const VerticalDiv({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: height,
      width: 3,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(5))),
    );
  }
}
