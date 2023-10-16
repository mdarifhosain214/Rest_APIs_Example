import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../models/users_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UsersModel>userList =[];
  Future<List<UsersModel>>getUser()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body);
    if(response.statusCode==200){
      for(Map<String,dynamic> i in data){
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    }
    return userList;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_ios_new),),
        title: const Text('Users Screen'),
      ),
      body: Expanded(
        flex: 1,
        child: FutureBuilder(
          future: getUser(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }
            return ListView.separated(
              itemCount: userList.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Text(userList[index].address!.city.toString()),
                  title: Text(userList[index].name.toString()),
                  subtitle: Text(userList[index].email.toString()),
                );
              },
              separatorBuilder: (context,index){
                return const Divider();
              },
            );
          },
        ),
      ),
    );
  }
}
