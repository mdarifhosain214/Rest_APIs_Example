import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_example/models/photos_model.dart';
import 'package:http/http.dart'as http;
class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<PhotosModel>photosList =[];
  Future<List<PhotosModel>>getPhotos()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body);
    if(response.statusCode==200)
      {
        for(Map<String,dynamic> i in data){
          photosList.add(PhotosModel.fromJson(i));
        }
        return photosList;
      }
    return photosList;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos Screen'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: (){Navigator.pop(context);},),
      ),
      body: Expanded(
        child:FutureBuilder(
          future:getPhotos() ,
          builder: (context,snapshot){
            return ListView.separated(itemBuilder: (context,index){
                return Card(
                child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
    backgroundImage: NetworkImage(photosList[index].url.toString()),
    radius: 50,
                 // child: Image.network(photosList[index].url.toString(),height: 50,width: 50,),
    ),
                title: Text(photosList[index].title.toString()),
                )
                );
              }, separatorBuilder: (context,index){
              return const Divider();
    }, itemCount: photosList.length);

          },

      ),)
    );
  }
}
