import 'package:flutter/material.dart';

class IncomeExpenseScreen extends StatefulWidget {
  @override
  _IncomeExpenseScreenState createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  final List<Map<String, dynamic>> _transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income & Expense Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${_transactions[index]["type"]}: ${_transactions[index]["amount"]}'),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      _transactions.add({"type": "Income", "amount": value});
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Income',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      _transactions.add({"type": "Expense", "amount": value});
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Expense',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
