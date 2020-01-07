import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:floss_manager/providers/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactionList = [];

  List<TransactionModel> get transactions {
    return [..._transactionList];
  }

  addTransaction(TransactionModel transaction) {
    _transactionList.add(transaction);
    notifyListeners();
  }

  removeTransaction(index) {
    _transactionList.removeAt(index);
    notifyListeners();
  }

  List<TransactionModel> get recentWeekTransactions {
    if (_transactionList.isNotEmpty || _transactionList != null) {
      return _transactionList.where((tx) {
        return tx.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
    } else {
      return [];
    }
  }

  int get newId {
    int id = 0;
    _transactionList.forEach((transaction) {
      id = id + 1;
    });
    return id;
  }

  List<Map<String, Object>> get groupedTransactionsAmountPerDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentWeekTransactions.length; i++) {
        if (recentWeekTransactions[i].data.day == weekDay.day) {
          totalSum += recentWeekTransactions[i].amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsAmountPerDay.fold(0.0, (init, sum) {
      return init + sum["amount"];
    });
  }
}
