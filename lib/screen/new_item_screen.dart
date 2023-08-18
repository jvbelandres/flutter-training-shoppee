import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppee/data/categories.dart';
import 'package:shoppee/models/category.dart';
import 'package:shoppee/screen/home_screen.dart';
import 'package:uuid/uuid.dart';

import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int quantity = 0;
  Category category = categories.values.first;

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      String uuid = const Uuid().v4();
      GroceryItem item = GroceryItem(
          id: uuid, name: name, quantity: quantity, category: category);

      Navigator.pop(context, item);
    }
  }

  void onReset() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final categoryItems = categories.entries
        .map(
          (e) => DropdownMenuItem(
            value: e.value,
            child: Row(
              children: [
                ColorBox(
                  color: e.value.color,
                  size: 16.0,
                ),
                Text(e.value.title),
              ],
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value) {
                    String? itemName = value?.trim();
                    if (itemName != null && itemName.isNotEmpty) {
                      name = itemName;
                      return null;
                    }
                    return "Invalid name";
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: quantity.toString(),
                        decoration: const InputDecoration(
                          label: Text("Quantity"),
                        ),
                        validator: (value) {
                          if (value != null) {
                            int? itemQuantity = int.tryParse(value);
                            if (itemQuantity != null && itemQuantity > 0) {
                              quantity = itemQuantity;
                              return null;
                            }
                          }
                          return "Invalid quantity";
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: categoryItems.first.value,
                        items: categoryItems,
                        onChanged: (value) {
                          var categoryValue = categories.entries
                              .firstWhere((element) => element.value == value);
                          category = categoryValue.value;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtons(
                      onPress: onReset,
                      buttonText: "Reset",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ActionButtons(
                      onPress: onSubmit,
                      buttonText: "Add Item",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.onPress,
    required this.buttonText,
  });

  final VoidCallback onPress;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(buttonText),
    );
  }
}
