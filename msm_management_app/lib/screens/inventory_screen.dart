import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_products[index]['name']),
                  subtitle: Text('Price: KES ${_products[index]['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _products.removeAt(index);
                      });
                    },
                  ),
                  onTap: () {
                    _editProduct(context, index); // Function to edit product
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _addProduct(context, value); // Add product function
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addProduct(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String price = '';
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the price for $productName'),
              TextField(
                onChanged: (value) {
                  price = value;
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (price.isNotEmpty) {
                  setState(() {
                    _products.add({"name": productName, "price": price});
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editProduct(BuildContext context, int index) {
    String updatedPrice = _products[index]['price'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Product: ${_products[index]['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Update price:'),
              TextField(
                onChanged: (value) {
                  updatedPrice = value;
                },
                controller:
                    TextEditingController(text: _products[index]['price']),
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (updatedPrice.isNotEmpty) {
                  setState(() {
                    _products[index]['price'] = updatedPrice;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
