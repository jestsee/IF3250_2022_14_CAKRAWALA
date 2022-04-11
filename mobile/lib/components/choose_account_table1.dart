import 'dart:developer';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/utils/user-api.dart';
import 'package:flutter/material.dart';

import 'choose_account_table.dart';

// global variable
UserAPI gAPI = UserAPI();
User currentUser = User.fromJson(
    {
      "id": -1,
      "name": "Unknown",
      "phone": "-1",
      "exp": 0,
      "email" : "Unknown"
    }
);

class ChooseAccountTable extends StatefulWidget {
  ChooseAccountTable({Key? key}) : super(key: key);

  @override
  State<ChooseAccountTable> createState() => _ChooseAccountTableState();
}

class _ChooseAccountTableState extends State<ChooseAccountTable> {
  late Future<List<User>> _users;
  List<User> users = [];
  List<User> usersFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _users = loadData();
    log("users initState $users");
  }

  Future<List<User>> loadData() async {
    List<User> data = await gAPI.fetchUser(123);
    setState(() {
      users = data;
      usersFiltered = data;
    });
    return data;
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
              hintText: 'Search users',
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  usersFiltered = usersFiltered.where((gift) =>
                  (gift.name.toLowerCase().contains(_searchResult))).toList();
                });
              }
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<User>>(
              future: _users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: handleOverflow(context)
                        ),
                        child: ListView.builder(
                          itemCount: usersFiltered.length,
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
                                  // TODO
                                  'https://picsum.photos/250?image=${usersFiltered[index].id}',
                                  height: 0.095 * size.width,
                                  width: 0.095 * size.width,
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    usersFiltered[index].name,
                                    style: const TextStyle (
                                        fontSize: 16,
                                        letterSpacing: 0.1,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    "${usersFiltered[index].phone.toString()} points",
                                    style: const TextStyle (
                                        fontSize: 16,
                                        letterSpacing: 0.1,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  currentUser = usersFiltered[index];
                                  log("selected user: $currentUser");
                                });
                              },
                            ),
                          ),
                        ),
                      )
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }
          )

        ],
      ),
    );
  }
}