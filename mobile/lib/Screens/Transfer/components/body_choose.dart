import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/circle_profile_icon.dart';
import 'package:cakrawala_mobile/components/enter_amount_input.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/components/user_profile_container.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import "package:flutter/material.dart";

class BodyChoose extends StatelessWidget {
  const BodyChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column (
      children: <Widget>[
        SearchBox(
          hintText: "Search account",
          onChanged: (value) {}
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/250?image=9',
                width: 45,
                height: 45,
              ),
            ),
            SizedBox(width: 0.05 * size.width),
            Text(
              'Nama',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.white
              ),
            ),
            SizedBox(width: 0.1 * size.width),
            Text(
              '0812345678',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
            SizedBox(width: 0.1 * size.width),
            Text(
              '16.000',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/250?image=9',
                width: 45,
                height: 45,
              ),
            ),
            SizedBox(width: 0.05 * size.width),
            Text(
              'Nama SAYAA',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white
              ),
            ),
            SizedBox(width: 0.1 * size.width),
            Text(
              '0812345678',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
            SizedBox(width: 0.1 * size.width),
            Text(
              '16.000',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white
              ),
            ),
          ],
        ),
        ButtonConfirmButton(
          text: "Continue to Transfer",
          press: () {}
        )
      ],
    );
  }
}