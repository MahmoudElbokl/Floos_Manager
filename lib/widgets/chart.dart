import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:floss_manager/providers/transaction_provider.dart';
import 'package:floss_manager/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: provider.groupedTransactionsAmountPerDay.map((data) {
            return ChartBar(
              data["day"],
              data["amount"],
              (provider.totalSpending == null || provider.totalSpending == 0)
                  ? 0.0
                  : (data["amount"] as double) / provider.totalSpending,
            );
          }).toList(),
        ),
      ),
    );
  }
}
