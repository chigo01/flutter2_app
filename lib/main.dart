import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2_app/model/transaction.dart';
import 'package:flutter2_app/widgets/chart.dart';
import 'package:flutter2_app/widgets/new_transaction.dart';
import 'package:flutter2_app/widgets/transcation_list.dart';
import 'package:flutter2_app/widgets/user_transaction.dart';
import 'dart:io';

void main() {
  //disabling of landscape
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleMedium: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                ),
              )
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleMedium: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                ),
              )
              .headline6,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  // String? titleInput;

  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        amount: txAmount,
        title: txTitle,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: _addNewTransaction),
        );
      },
    );
  }

  // we normally delete things using an id
  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //rendering widget base on screen orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        )
      ],
    );

    final txListWidget = Container(
      //added the calculation to prevent scrollable
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7, //70
      child: TransactionList(
          transactions: _transactions, deleteTx: _deleteTransaction),
    );

    final chartWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3, //30%
      child: Chart(_recentTransactions),
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //u don't use curly braces for if statement inside a widget
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (bool value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape) chartWidget,

          if (!isLandscape) txListWidget,
          if (isLandscape) _showChart ? chartWidget : txListWidget,
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
