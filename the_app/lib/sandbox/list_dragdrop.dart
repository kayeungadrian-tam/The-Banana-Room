import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate dummy data for the list view
  final List<String> _products =
      List.generate(20, (index) => "Product ${index.toString()}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: ReorderableListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final String productName = _products[index];
            return Card(
              key: ValueKey(productName),
              color: Colors.amberAccent,
              elevation: 1,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(25),
                title: Text(
                  productName,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: const Icon(Icons.drag_handle),
                onTap: () {/* Do something else */},
              ),
            );
          },
          // The reorder function
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }
              final element = _products.removeAt(oldIndex);
              _products.insert(newIndex, element);
            });
          }),
    );
  }
}
