import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../models/comments_model.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}
List<CommentsModel>listComments=[];
Future<List<CommentsModel>>getComments()async{
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
  var data = jsonDecode(response.body);
  if(response.statusCode==200){
    for(Map<String,dynamic> i in data){
      listComments.add(CommentsModel.fromJson(i));
    }
    return listComments;
  }
  return listComments;
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Comments Screen'),
      ),
      body: FutureBuilder(
        future: getComments(),
        builder: (context,snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView.separated(itemBuilder: (context,index){
          return Card(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(listComments[index].name.toString()),
                Text(listComments[index].email.toString()),
                Text(listComments[index].body.toString()),
              ],
            ) ,
          );
        }, separatorBuilder: (context,index){
          return const Divider();
        }, itemCount: listComments.length);
        },
      ),
    );
  }
}
