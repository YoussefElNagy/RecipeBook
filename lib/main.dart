import 'package:flutter/material.dart';
import './components/Home.dart';
import './components/IngredientList.dart';
import './components/RecipeList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context)=> HomePage(title: "Home"),
        '/recipes': (context)=> RecipeList(),
        '/ingredients': (context)=> IngredientList(),
      },
    );
  }
}



