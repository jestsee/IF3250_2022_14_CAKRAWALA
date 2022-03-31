
import 'dart:convert';

import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/Screens/RedeemGift/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/rounded_payment_detail_field.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/user_info_text.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class InvoiceHadiahText extends StatelessWidget {
  final String text;
  const InvoiceHadiahText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextAccountTemplate(
        text: text,
        align: TextAlign.right,
        weight: FontWeight.w400,
        size: 14,
        color: black,
      ),
    );
  }
}

class WhiteInvoiceContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const WhiteInvoiceContainer({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteFieldContainer(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                InvoiceHadiahText(text: title),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align (
                    alignment: FractionalOffset.bottomRight,
                    child: InvoiceHadiahText(text: subtitle),
                  )
                )
              ],
            )
          ],
        )
    );
  }
}

class ProductsDetail extends StatelessWidget {
  final String productName;
  final double price;
  const ProductsDetail({
    Key? key,
    required this.productName,
    required this.price
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InvoiceHadiahText(text: productName),
          InvoiceHadiahText(text: "Rp ${price.toString()}"),
        ],
      ),
    );
  }
}

class Product {
  String productName;
  int price;
  
  Product(this.productName, this.price);
  factory Product.fromJson(dynamic json) {
    return Product(
        json["product_name"] as String,
        json["price"] as int);
  }
}

class BodyInvoice extends StatelessWidget {
  final int nominal;
  final int points;
  final String namaGift;
  final String time;
  const BodyInvoice({
    Key? key,
    required this.nominal,
    required this.points,
    required this.namaGift,
    required this.time,
  }) : super(key: key);
  
//  List<Widget> showProduct() {
//     List<Product> list = DummyDataHadiah().data.map((e) =>
//       Product.fromJson(e)).toList();
//     List<Widget> widgets = List.generate(list.length, (index) =>
//         ProductsDetail(
//           productName: list[index].productName,
//           price: list[index].price.toDouble(),
//         ));
//     widgets.insert(0, Row(
//       children: const <Widget>[
//         InvoiceText(text: "Products"),
//       ],
//     ));
//     return widgets;
//   }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width,),
        RoundedPaymentDetail(
            nama: "AMOUNT",
            nominal: nominal,
            points: points,
            amount: true,
        ),
        SizedBox(height: .05 * size.width),
        WhiteInvoiceContainer(title: "Gift", subtitle: namaGift),
        WhiteInvoiceContainer(title: "Invoice ID", subtitle: "123456"), // TODO id invoice
        WhiteInvoiceContainer(title: "Time", subtitle: time), // TODO waktu transaksi
        ButtonConfirmButton(text: "Back To Home", press: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()));
        })
      ],
    );
  }
}
