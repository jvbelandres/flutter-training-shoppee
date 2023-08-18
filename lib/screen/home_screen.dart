import 'package:flutter/material.dart';
import 'package:shoppee/models/grocery_item.dart';

import '../data/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoppee"),
        actions: [
          IconButton(
            onPressed: () async {
              var newItem = await Navigator.pushNamed(context, addItemScreen);
              if (newItem != null) {
                setState(() {
                  addedGroceryItems.add(newItem as GroceryItem);
                });
              }
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                addedGroceryItems = [];
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Emptied Grocery Cart'),
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: addedGroceryItems.isEmpty
            ? const Center(
                child: Text("No items added yet"),
              )
            : ListView.builder(
                itemCount: addedGroceryItems.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentItem = addedGroceryItems[index];
                  return Dismissible(
                    key: Key(currentItem.id),
                    onDismissed: (direction) {
                      setState(() {
                        addedGroceryItems.removeAt(index);
                      });
                    },
                    child: ListTile(
                      leading: ColorBox(
                        color: currentItem.category.color,
                        size: 24.0,
                      ),
                      trailing: TextTile(
                        attribute: '${currentItem.quantity}',
                      ),
                      title: TextTile(
                        attribute: currentItem.name,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  const ColorBox({super.key, required this.color, required this.size});

  final color;
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
      ),
    );
  }
}

class TextTile extends StatelessWidget {
  const TextTile({
    super.key,
    required this.attribute,
  });

  final String attribute;

  @override
  Widget build(BuildContext context) {
    return Text(
      attribute,
      style: const TextStyle(fontSize: 20),
    );
  }
}
