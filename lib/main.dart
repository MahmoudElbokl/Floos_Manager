import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floss_manager/providers/transaction_provider.dart';
import 'screens/home_screen.dart';

void main() {
  return runApp(FloosManager());
}

class FloosManager extends StatefulWidget {
  @override
  _FloosManagerState createState() => _FloosManagerState();
}

class _FloosManagerState extends State<FloosManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Floos Manager",
      theme: ThemeData(
        buttonColor: Colors.blue,
        primarySwatch: Colors.blue,
        fontFamily: "OpenSans",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline2: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider.value(
        value: TransactionProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
