import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../models/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostModel> postList = [] ;

  Future<List<PostModel>> getPost ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')) ;
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList ;
    }else {
      return postList ;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text("Post Screen",style: TextStyle(color: Colors.white),),
      ),
      body: Expanded(child: FutureBuilder(
        future:getPost() ,
          builder: (context,snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }
        else{
          return ListView.separated(
              itemCount: postList.length,
              itemBuilder: (context,index){
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title :\n"+postList[index].title.toString()),
                      Text("Body :\n"+postList[index].body.toString()),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return Divider();
          },
              );
        }
      }),),
    );
  }
}
