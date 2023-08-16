import 'package:flutter/material.dart';
import 'package:shoppee/models/grocery_item.dart';

import '../data/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final itemsToBeDisplayed = addedGroceryItems
      .map(
        (e) => DropdownMenuItem(
          value: e,
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: e.category.color,
                ),
              ),
              Text(e.category.title),
            ],
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoppee"),
        actions: [
          TextButton(
            onPressed: () async {
              var newItem = await Navigator.pushNamed(context, addItemScreen);
              if (newItem != null) {
                setState(() {
                  addedGroceryItems.add(newItem as GroceryItem);
                });
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
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
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: currentItem.category.color,
                                  ),
                                ),
                                const SizedBox(width: 8.0,),
                                TextTile(
                                  attribute: currentItem.name,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextTile(
                              attribute: '${currentItem.quantity}',
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
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
