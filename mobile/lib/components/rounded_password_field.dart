import 'package:cakrawala_mobile/components/text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: primaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
