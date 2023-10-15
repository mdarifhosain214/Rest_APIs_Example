import 'package:flutter/material.dart';
import 'package:rest_api_example/screens/post_screen.dart';

import 'comments_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text('Rest API',style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
            }, child: const Text('Posts Model show',style: TextStyle(color: Colors.white),)),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CommentsScreen()));
            }, child: const Text('Comments Model show',style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
