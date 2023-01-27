import 'package:flutter/material.dart';
import 'package:polosystest/viewstate/mainstate.dart';
import 'package:provider/provider.dart';

class CustomAlertBox extends StatelessWidget {
  bool? fromInsert=false;
  CustomAlertBox({Key? key, this.fromInsert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainState>(context);
    return AlertDialog(
      elevation: 10,
      backgroundColor: Colors.white,
      title: const Text("DB Creation"),
      actions: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mainState.txtbusinessName,
                focusNode: mainState.fcsbusinessName,
                decoration: const InputDecoration(
                  hintText: "Business Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 107, 218), width: 4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mainState.txtproductSerial,
                focusNode: mainState.fcsproductSerial,
                decoration: const InputDecoration(
                  hintText: "Product Serial",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 107, 218), width: 4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mainState.txtcontactEmail,
                focusNode: mainState.fcscontactEmail,
                decoration: const InputDecoration(
                  hintText: "Contact Email",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 107, 218), width: 4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: mainState.txtdatabaseName,
                focusNode: mainState.fcsdatabaseName,
                decoration: const InputDecoration(
                  hintText: "DB Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 107, 218), width: 4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(179, 0, 0, 0),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (fromInsert!) {
                    bool isTrue = await mainState.insertUserToDefaultDatabase();
                    if (isTrue) {
                      Navigator.pop(context);
                    }
                  } else {
                    bool isTrue = await mainState.insertNewDatas();
                    if (isTrue) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text("Save New DB"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
