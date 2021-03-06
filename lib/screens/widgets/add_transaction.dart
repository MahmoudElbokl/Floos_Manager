import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:floss_manager/model/transaction_model.dart';
import 'package:floss_manager/providers/transaction_provider.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String label = "amount";
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  addTransaction() {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      final transaction = TransactionModel(
          id: provider.newId.toString(),
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          data: provider.dataSelected ?? DateTime.now());
      Navigator.pop(context);
      provider.addTransaction(transaction);
    }
  }

  void _datePick() async {
    final DateTime datePicked = Platform.isIOS
        ? CupertinoDatePicker(onDateTimeChanged: null)
        : await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 730)),
            lastDate: DateTime.now().add(Duration(days: 730)),
          );
    if (datePicked == null)
      return null;
    else {
      Provider.of<TransactionProvider>(context, listen: false)
          .setData(datePicked);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Container(
      height: 400,
      padding: const EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // transaction title and amount
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title is Required";
                    }
                    return null;
                  },
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Title", hintText: _titleController.text),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Amount is required";
                    } else {
                      if (double.tryParse(value) == null) {
                        return "Amount is Not valid";
                      }
                      return null;
                    }
                  },
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Amount", hintText: _amountController.text),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // date picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                (provider.dataSelected == null)
                    ? "Picked date:${DateFormat("d-M-y").format(DateTime.now())}"
                    : "Picked date: ${DateFormat.yMd().format(provider.dataSelected)}",
              ),
              FlatButton(
                onPressed: () {
                  _datePick();
                },
                child: Text("Change Date"),
              ),
            ],
          ),
          Platform.isIOS
              ? Column(
                  children: <Widget>[
                    CupertinoButton(
                      child: Text("Add Transaction"),
                      onPressed: () {
                        addTransaction();
                      },
                    ),
                    CupertinoButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context)),
                  ],
                )
              : Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        addTransaction();
                      },
                      child: Text("Add Transaction"),
                    ),
                    RaisedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .setSelect(false);
                          Navigator.pop(context);
                        }),
                  ],
                )
        ],
      ),
    );
  }
}
