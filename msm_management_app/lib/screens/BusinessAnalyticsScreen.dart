import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package

class BusinessAnalyticsScreen extends StatefulWidget {
  @override
  _BusinessAnalyticsScreenState createState() =>
      _BusinessAnalyticsScreenState();
}

class _BusinessAnalyticsScreenState extends State<BusinessAnalyticsScreen> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double netProfit = 0.0;

  final List<Map<String, dynamic>> _transactions = [
    {"type": "Income", "amount": 5000.0, "date": DateTime.now()},
    {
      "type": "Expense",
      "amount": 2000.0,
      "date": DateTime.now().subtract(Duration(days: 3))
    },
    {
      "type": "Income",
      "amount": 3000.0,
      "date": DateTime.now().subtract(Duration(days: 7))
    },
    {
      "type": "Expense",
      "amount": 1500.0,
      "date": DateTime.now().subtract(Duration(days: 10))
    },
  ];

  @override
  void initState() {
    super.initState();
    _calculateAnalytics();
  }

  void _calculateAnalytics() {
    totalIncome = 0.0;
    totalExpense = 0.0;

    for (var transaction in _transactions) {
      if (transaction['type'] == "Income") {
        totalIncome += transaction['amount'];
      } else if (transaction['type'] == "Expense") {
        totalExpense += transaction['amount'];
      }
    }

    netProfit = totalIncome - totalExpense;
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Total Income: KES $totalIncome',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              'Total Expenses: KES $totalExpense',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 8),
            Text(
              'Net Profit: KES $netProfit',
              style: TextStyle(
                fontSize: 18,
                color: netProfit >= 0 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Transaction Breakdown',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Chart for visual representation
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 5000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _transactions.asMap().entries.map((entry) {
                        int index = entry.key;
                        var transaction = entry.value;
                        return FlSpot(index.toDouble(), transaction['amount']);
                      }).toList(),
                      isCurved: true,
                      colors: [Colors.blue],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  var transaction = _transactions[index];
                  return ListTile(
                    title: Text(
                      '${transaction["type"]}: KES ${transaction["amount"]}',
                      style: TextStyle(
                        color: transaction['type'] == "Income"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    subtitle: Text(_formatDate(transaction['date'])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
