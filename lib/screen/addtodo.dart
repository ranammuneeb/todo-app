import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class addtodolist extends StatefulWidget {
  final Map? todo;
  const addtodolist({super.key,
     this.todo});
  @override
  State<addtodolist> createState() => _addtodolistState();
}

class _addtodolistState extends State<addtodolist> {
  bool isedit = false;
  
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  @override
  void initState() {
    if (widget.todo!= null) {
      title.text = widget.todo?['title'];
      description.text = widget.todo?['description'];
      isedit = true;
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(isedit? "edit todo":"add todo "),
        centerTitle: true,
        shadowColor: Colors.blueAccent,
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Task  title',
              border: OutlineInputBorder(),
            ),
            controller: title,
            ),
            SizedBox(height: 20),
            
            TextField(
              minLines: 5,
              maxLines: 8,
              controller: description,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
              labelText: 'description',
              border: OutlineInputBorder(),
            ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:isedit?editdata: submitdata,
              child: Text(isedit?"update":"submit"),)
        ],
      ),
    );
  }
  void editdata() async{
    if(widget.todo==null)
    {
      showerror('Task not found');
      return;
    }
    final id= widget.todo?['_id'];
    final tit= title.text;
    final des= description.text;
    final body={
  "title":tit,
  "description": des,
  "is_completed": false
  };
  final url ="https://api.nstack.in/v1/todos/$id";
  final uri=Uri.parse(url);

  var response = await http.put(uri,body: jsonEncode(body),headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    showsucces('Task edited successfully');
   
  }
  else {
    showerror('Failed to edited task');
  }
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  }
  void submitdata() async 
  {
    final tit= title.text;
    final des= description.text;
    final body={
  "title":tit,
  "description": des,
  "is_completed": false
  };
  
  // here you can use your API to add the data to your database
  final url ="https://api.nstack.in/v1/todos";
  final uri=Uri.parse(url);

  var response = await http.post(uri,body: jsonEncode(body),headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 201) {
    showsucces('Task added successfully');
    title.clear();
    description.clear();
  }
  else {
    showerror('Failed to add task');
  }
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  }



  void showsucces(String body) {
    final snackbar= SnackBar(content:Text(body));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

  }



   void showerror(String body) {
    final snackbar= SnackBar(content:Text(body));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

  }
}