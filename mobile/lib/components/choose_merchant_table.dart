import 'dart:developer';
import 'package:cakrawala_mobile/Screens/Payment/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:flutter/material.dart';

// global variable
Merchant currentMerchant = Merchant.fromJson(
    {
      "id_merchant": -1,
      "nama_merchant": "Unknown",
      "alamat": "Unknown",
      "no_rekening": -1,
    }
);

class Merchant {
  int id;
  String name;
  String alamat;
  int no_rek;

  Merchant(this.id, this.name, this.alamat, this.no_rek);
  factory Merchant.fromJson(dynamic json) {
    return Merchant(
      json['id_merchant'] as int,
      json['nama_merchant'] as String,
      json['alamat'] as String,
      json['no_rekening'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.no_rek}}';
  }

  static Merchant getSelectedMerchant() {
    log('selected:${currentMerchant.name}');
    return currentMerchant;
  }
}

class ChooseMerchantTable extends StatefulWidget {
  ChooseMerchantTable({Key? key}) : super(key: key);

  @override
  State<ChooseMerchantTable> createState() => _ChooseMerchantTableState();
}

class _ChooseMerchantTableState extends State<ChooseMerchantTable> {
  List<Merchant> merchants = dummyDataMerchant().data.map((e) =>
      Merchant.fromJson(e)).toList();
  List<Merchant> merchantsFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int selectedIndex = -1;

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
      width: .9 * size.width,
      height: .7 * size.height,
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
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: handleOverflow(context)
              ),
              child: ListView.builder(
                itemCount: merchantsFiltered.length,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: selectedIndex == index? const Color(0xFFD6D6D6): Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                      Image.network(
                        // TODO penyimpanan picture-nya nanti gimana ya?
                        'https://picsum.photos/250?image=${merchantsFiltered[index].id}',
                        height: 0.095 * size.width,
                        width: 0.095 * size.width,
                      ),
                    ),
                    title: Text(
                        merchantsFiltered[index].name,
                      style: const TextStyle (
                        fontSize: 16,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        currentMerchant = merchantsFiltered[index];
                        log("selected merchant: $currentMerchant");
                      });
                    },
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}