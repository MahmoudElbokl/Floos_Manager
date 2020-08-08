import 'package:flutter/foundation.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime data;

  TransactionModel(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.data});
}
