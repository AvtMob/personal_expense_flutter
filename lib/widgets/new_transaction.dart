import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  late final Function adTx;

  NewTransaction(this.adTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.adTx(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        this._selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              Text(
                'Add New Transaction',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                onSubmitted: (val) => _submitData,
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(hintText: 'Amount'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (val) => _submitData,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Transaction Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        primary: Colors.transparent,
                        onPrimary: Theme.of(context).primaryColor,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: Text(
                    'Add Transaction',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
