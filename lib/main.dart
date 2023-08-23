import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppee/models/grocery_cart.dart';
import 'package:shoppee/screen/home_screen.dart';
import 'package:shoppee/screen/new_item_screen.dart';

import 'data/constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GroceryCart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shoppee',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      initialRoute: homeScreen,
      routes: {
        homeScreen: (context) => const HomeScreen(),
        addItemScreen: (context) => const NewItem(),
      },
    );
  }
}
