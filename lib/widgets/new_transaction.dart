import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addTx}) : super(key: key);

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleTextEditingController = TextEditingController();

  final _amountTextEditingController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if(_amountTextEditingController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleTextEditingController.text;
    final enteredAmount = double.parse(_amountTextEditingController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    // widget.addTx(enteredTitle, enteredAmount);
    //is used for parsing parameters for the function of the stateful class
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            firstDate: DateTime(2022),
            initialDate: DateTime.now(),
            context: context,
            lastDate: DateTime(
                2023)) // it returns a future, so the then method is used to
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
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
              controller: _titleTextEditingController,
              onSubmitted: (_) => _submitData,
              // onChanged: (val) {
              //   // titleInput = val;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
              // onChanged: (val) {
              //   // amountInput = val
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date chosen '
                          : 'picked Date ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(),
              onPressed: () {
                // print(titleInput);
                // print(amountInput);
                _submitData();
              },
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
