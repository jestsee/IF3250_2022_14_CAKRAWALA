import "package:flutter/material.dart";

class TextAccountTemplate extends StatelessWidget {
  final String text;
  final TextAlign align;
  final FontWeight weight;
  final double size;
  const TextAccountTemplate({Key? key,
    required this.text,
    required this.align,
    required this.weight,
    required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle (
          fontWeight: weight,
          fontSize: size,
          color: Colors.white
      ),
    );
  }
}
