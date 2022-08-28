import 'package:flutter/material.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionsList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No transactions added yet!!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final tx = transactions[index];
                //return getCustomListItem(context, tx);
                return getDefaultListItem(context, tx);
              },
              itemCount: transactions.length,
            ),
    );
  }

  Widget getCustomListItem(BuildContext context, Transaction tx) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(220, 220, 220, 1),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Text('\$${tx.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headline6),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tx.title, style: Theme.of(context).textTheme.headline6),
              Text(
                DateFormat.yMMMd().format(tx.date),
                //DateFormat('dd/MM/yy').format(tx.date),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getDefaultListItem(BuildContext context, Transaction tx) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${tx.amount}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(tx.id),
        ),
      ),
    );
  }
}
