import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:polosystest/Core/sharedPrefs.dart';
import 'package:polosystest/view/widgets/AlertBox.dart';
import 'package:polosystest/viewstate/db_viewstate.dart';
import 'package:polosystest/viewstate/mainstate.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class IndexScreen extends StatefulWidget {
  IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  late MainState mainState;
  late DBViewState dbViewState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      
    });
  }

  @override
  Widget build(BuildContext context) {
    mainState = Provider.of<MainState>(context);
    dbViewState = Provider.of<DBViewState>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await dbViewState.gettttt(
                      folderName: 'MyFolder', dbName: 'MasterDB.db');
                  // await dbViewState.gettttt(
                  //     folderName: 'MyFolder', dbName: 'Accounts.db');
                },
                child: const Text("Create Default DBs")),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => CustomAlertBox(),
                  );
                },
                child: const Text("New Db Creation")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black),
                onPressed: () async {
                  await mainState.getAllDatabase();
                },
                child: const Text("Count Check")),
            mainState.accModel.isNotEmpty
                ? Column(
                    children: List.generate(mainState.accModel.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    mainState.accModel[index].isDefault == 1
                                        ? Color.fromARGB(255, 75, 152, 188)
                                        : Colors.black,
                                foregroundColor: Colors.yellow),
                            onPressed: () async {
                              bool isUpdated =
                                  await mainState.setAsDefaultAccount(
                                      mainState.accModel[index]);
                              if (isUpdated) {
                                log("YH");
                                await mainState.createDbIfNotExist(
                                    mainState.accModel[index]);
                              } else {
                                log("Not Updated");
                              }
                            },
                            child: Text(
                                '----------------------\n${mainState.accModel[index].businessName}\n----------------------')),
                      );
                    }),
                  )
                : Container(),

            ElevatedButton(
                onPressed: () {
                  mainState.accModel.clear();
                  mainState.notifyListeners();
                },
                child: Text("Clear Listtt")),

            ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => CustomAlertBox(fromInsert: true),
                  );
                },
                child: const Text("Insert Into Selected Database"))

            // Text(mainState.testModel.);
          ],
        ),
      ),
    );
  }
}
