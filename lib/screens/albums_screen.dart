import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../models/albums_model.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<AlbumsModel>albumsList=[];
  Future<List<AlbumsModel>>getAlbums()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
      for(Map<String,dynamic> i in data){
        albumsList.add(AlbumsModel.fromJson(i));
      }
      return albumsList;
    }
    return albumsList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_ios_new),),
        title: const Text('Albums Screen'),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: getAlbums(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }
            return ListView.separated(itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal,
                    child: Text(albumsList[index].id.toString()),),
                  title: Text(albumsList[index].title.toString())),
              );
            },
              separatorBuilder: (context,index){
              return const Divider();
            }, itemCount: albumsList.length,
            );
          },
        ),
      ),
    );
  }
}
