import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:floss_manager/widgets/add_transaction.dart';
import 'package:floss_manager/widgets/transaction_list.dart';
import 'package:floss_manager/widgets/chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _bottomSheet = GlobalKey<ScaffoldState>();
  bool _showChert = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Floos Manager"),
            trailing: CupertinoButton(
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  return showAddTransactionSheet(context);
                }),
          )
        : AppBar(
            title: Text("Floos Manager"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    return showAddTransactionSheet(context);
                  })
            ],
          );
    // height is device size subtracted by height of appbar and system notification bar
    final double height = (size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Show mode"),
                        Switch.adaptive(
                          value: _showChert,
                          onChanged: (value) {
                            setState(() {
                              _showChert = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  (_showChert)
                      ? Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: height * 0.5,
                                width: size.width * 0.48,
                                alignment: Alignment.center,
                                child: Chart(),
                              ),
                              Container(
                                width: size.width * 0.5,
                                height: height * 0.85,
                                child: TransactionList(),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: height * 0.85,
                          child: TransactionList(),
                        ),
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: height * 0.3,
                    child: Chart(),
                  ),
                  Container(
                    height: height * 0.7,
                    child: TransactionList(),
                  ),
                ],
              ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            key: this._bottomSheet,
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            key: this._bottomSheet,
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
                tooltip: "Add New",
                child: Icon(Icons.add),
                onPressed: () {
                  return showAddTransactionSheet(context);
                }),
          );
  }

  void showAddTransactionSheet(ct) {
    this._bottomSheet.currentState.showBottomSheet((ctx) => AddTransaction());
  }
}
