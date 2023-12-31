import 'package:flutter/material.dart';
import 'package:rest_api_example/screens/home_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest API',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
              backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(color: Colors.white),
          foregroundColor: Colors.white
        )
      ),
      home: const HomeScreen(),
    );
  }
}


