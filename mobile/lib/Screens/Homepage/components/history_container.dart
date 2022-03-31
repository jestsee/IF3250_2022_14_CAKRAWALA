import 'package:flutter/material.dart';

class HistoryContainer extends StatelessWidget {
  final Widget child;
  const HistoryContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Center(
      child: Container(
        height: 220,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: size.width * 0.9,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 52, 146, 223),
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
