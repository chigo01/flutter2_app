import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addTx}) : super(key: key);

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextEditingController = TextEditingController();

  final amountTextEditingController = TextEditingController();

  void submitData() {
    final enteredTitle = titleTextEditingController.text;
    final enteredAmount = double.parse(amountTextEditingController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleTextEditingController,
              onSubmitted: (_) => submitData,
              // onChanged: (val) {
              //   // titleInput = val;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountTextEditingController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              // onChanged: (val) {
              //   // amountInput = val
              // },
            ),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {
                // print(titleInput);
                // print(amountInput);
                submitData();
              },
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
