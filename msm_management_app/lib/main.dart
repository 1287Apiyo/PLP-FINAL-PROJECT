 import 'package:flutter/material.dart';
import 'screens/inventory_screen.dart';
import 'screens/income_expense_screen.dart';
import 'screens/BusinessAnalyticsScreen.dart';

void main() {
  runApp(MSMManagementApp());
}

class MSMManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSME Management',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MSME Management Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Inventory Management Section
              buildFeatureButton(
                  context, 'Manage Inventory', InventoryScreen()),

              SizedBox(height: 20), // Spacing between buttons

              // Income & Expense Tracking Section
              buildFeatureButton(
                  context, 'Track Income & Expenses', IncomeExpenseScreen()),

              SizedBox(height: 20), // Spacing between buttons

              // Business Analytics Section (Placeholder for Future Feature)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessAnalyticsScreen()),
                  );
                },
                child: Text('Business Analytics'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create feature buttons
  ElevatedButton buildFeatureButton(
      BuildContext context, String title, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60), // Makes the button fill width
        textStyle: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(title),
    );
  }
}
