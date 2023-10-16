import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../models/todos_model.dart';

class ToDosScreen extends StatefulWidget {
  const ToDosScreen({super.key});

  @override
  State<ToDosScreen> createState() => _ToDosScreenState();
}

class _ToDosScreenState extends State<ToDosScreen> {
  List<TodosModel>todosList =[];
  Future<List<TodosModel>> getTodos()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
      for(Map<String,dynamic> i in data){
        todosList.add(TodosModel.fromJson(i));
      }
      return todosList;
    }
    return todosList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos screen"),
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_ios_new),),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: getTodos(),
          builder: (context,snapshot){
           if(!snapshot.hasData){
             return const Center(child: CircularProgressIndicator(),);
           }
           return ListView.separated(
             itemBuilder: (context,index) {
               return Card(
                 child:ListTile(
                   leading: CircleAvatar(backgroundColor: Colors.teal,
                       radius: 70,
                       child: Text(todosList[index].id.toString(),style: const TextStyle(color: Colors.white),)),
                   title:Text(todosList[index].title.toString()),
                 ),
               );
             },
             separatorBuilder: (context,index){
               return const Divider();
             },
             itemCount: todosList.length,
           );
        },),
      ),
    );
  }
}
