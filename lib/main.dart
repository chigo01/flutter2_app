import 'package:flutter/material.dart';
import 'package:flutter2_app/model/transaction.dart';
import 'package:flutter2_app/widgets/chart.dart';
import 'package:flutter2_app/widgets/new_transaction.dart';
import 'package:flutter2_app/widgets/transcation_list.dart';
import 'package:flutter2_app/widgets/user_transaction.dart';

void main() => runApp(const MyApp());

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
  // void _startAddNewTransaction(BuildContext context) {
  //   showBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return NewTransaction(
  //           addTx: _addNewTranscation,
  //         );
  //       });
  // }

  // String? titleInput;

  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoe',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 18.99,
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),
              TransactionList(
                transactions: _transactions,
                deleteTx:  _deleteTransaction
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          child: const Icon(Icons.add),
        ));
  }
}
