import 'package:flutter/material.dart';

class IncomeExpenseScreen extends StatefulWidget {
  @override
  _IncomeExpenseScreenState createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  final List<Map<String, dynamic>> _transactions = [];
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income & Expense Tracker'),
      ),
      body: Column(
        children: [
          // Display total balance at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Income: KES $totalIncome',
                    style: TextStyle(fontSize: 18)),
                Text('Total Expense: KES $totalExpense',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${_transactions[index]["type"]}: KES ${_transactions[index]["amount"]}'),
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
                      double income = double.parse(value);
                      _transactions.add({"type": "Income", "amount": income});
                      totalIncome += income;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Income',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      double expense = double.parse(value);
                      _transactions.add({"type": "Expense", "amount": expense});
                      totalExpense += expense;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Expense',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
