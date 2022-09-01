// import 'package:flutter/material.dart';
// import 'package:flutter2_app/widgets/transcation_list.dart';

// import '../model/transaction.dart';
// import 'new_transaction.dart';

// class UserTransaction extends StatefulWidget {
//   UserTransaction({Key? key}) : super(key: key);

//   @override
//   State<UserTransaction> createState() => _UserTransactionState();
// }

// class _UserTransactionState extends State<UserTransaction> {
//   //function that adds more userinput to the list

//   void _addNewTranscation(String txTitle, double txAmount) {
//     final newTx = Transaction(
//         amount: txAmount,
//         title: txTitle,
//         date: DateTime.now(),
//         id: DateTime.now().toString());

//     setState(() {
//       _transactions.add(newTx);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       NewTransaction(addTx: _addNewTranscation),
//       TransactionList(
//         transactions: _transactions,
//       ),
//     ]);
//   }
// }
