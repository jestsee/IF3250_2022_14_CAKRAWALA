import 'dart:developer';
import 'package:cakrawala_mobile/Screens/Payment/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:flutter/material.dart';

// global variable
User currentMerchant = User.fromJson(
    {
      "id_merchant": -1,
      "nama_merchant": "Unknown",
      "no_rekening": -1,
    }
);

class User {
  int id;
  String name;
  String phone;
  int exp;
  String address;
  String email;
  bool selected = false;

  User(this.id, this.name, this.phone, this.exp, this.address, this.email);
  factory User.fromJson(dynamic json) {
    return User(
        json['id'] as int,
        json['name'] as String,
        json['phone'] as String,
        json['exp'] as int,
        json['address'] as String,
        json['email'] as String)
    ;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.phone}, ${this.exp}, ${this.address}, ${this.email}}';
  }

  static User getSelectedUser() {
    log('selected:${currentMerchant.name}');
    return currentMerchant;
  }
}

class Merchant {
  int id;
  String name;
  int no_rek;

  Merchant(this.id, this.name, this.no_rek);
  factory Merchant.fromJson(dynamic json) {
    return Merchant(
      json['id_merchant'] as int,
      json['nama_merchant'] as String,
      json['no_rekening'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.no_rek}}';
  }
}

class ChooseMerchantTable extends StatefulWidget {
  ChooseMerchantTable({Key? key}) : super(key: key);

  @override
  State<ChooseMerchantTable> createState() => _ChooseMerchantTableState();
}

class _ChooseMerchantTableState extends State<ChooseMerchantTable> {
  List<Merchant> merchants = dummyData().data.map((e) =>
      Merchant.fromJson(e)).toList();
  List<Merchant> merchantsFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    merchantsFiltered = merchants;
  }

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Container (
      height: .7 * size.height,
      width: .9 * size.width,
      child: Column(
        children: [
          SearchBox(
              hintText: 'Search merchant',
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  merchantsFiltered = merchants.where((merchant) =>
                  (merchant.name.toLowerCase().contains(_searchResult))).toList();
                });
              }
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: merchantsFiltered.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular(10)
                ),
                // key: ValueKey(merchantsFiltered[index].id),
                color: Colors.white,
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                    Image.network(
                      'https://picsum.photos/250?image=$index',
                      height: 0.095 * size.width,
                      width: 0.095 * size.width,
                    ),
                  ),
                  title: Text(
                      merchantsFiltered[index].name,
                    style: TextStyle (
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  )
                  // subtitle: Text(
                  //     '${_foundUsers[index]["age"].toString()} years old'),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}