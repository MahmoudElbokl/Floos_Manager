import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:floss_manager/providers/transaction_provider.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: (provider.transactions.isEmpty)
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(
                          "assets/images/pocket.png",
                          height: size.height * 0.2,
                          width: size.width * 0.5,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.075,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Press the Add button to start add transaction",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: size.width > 450
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text("delete"),
                              onPressed: () {
                                provider.removeTransaction(index);
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                provider.removeTransaction(index);
                              }),
                      title: Text(
                        provider.transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          "${DateFormat("MMM/d").format(
                              provider.transactions[index].data)}"),
                      leading: Container(
                        height: 40,
                        width: 75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                        ),
                        child: Center(
                          child: Text(
                              "${provider.transactions[index].amount.toStringAsFixed(2)} \$"),
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
