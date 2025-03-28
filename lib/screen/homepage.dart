import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screen/addtodo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List items =[];
  bool isloading=true;
  
  
  @override
  void initState() {
    super.initState();
    fetchdata();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Todo app "),
        centerTitle: true,
        shadowColor: Colors.blueAccent,
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        onRefresh: fetchdata,
        child: Visibility(
          visible: isloading,
          child: Center(child: CircularProgressIndicator(),),
          replacement: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item=items[index] as Map;
              return Slidable(
                endActionPane: ActionPane(motion: StretchMotion(),
                 extentRatio: 0.5,
                children: [
                  SlidableAction(
              // An action can be bigger than the others.
              //flex: 2,
                  onPressed:(context)=>deletebyid(item["_id"]),
                  backgroundColor: Color(0xFFFF0000),
                  foregroundColor: Colors.white,
                  //flex:10,
                  icon: Icons.delete,
                  //borderRadius: BorderRadius.a(),
                  borderRadius: BorderRadius.circular(15),
                  //flex: 10,
                  label: 'delete',
            ), SlidableAction(
              // An action can be bigger than the others.
              //flex: 2,
                  onPressed:(context)=>navigatetoeditpage(item),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_attributes_outlined,
                  borderRadius: BorderRadius.circular(15),
                  label: 'edit ',
            ),

                ]),
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8),
                  elevation: 50,
                  shadowColor: Colors.blueGrey,
                  
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index+1}"),),
                    title: Text(item["title"]),
                    subtitle: Text(item["description"]),
                  
                  ),
                ),
              );
            },),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigatetoaddpage, label: Text("add todo "),icon: Icon(Icons.add_box_rounded),hoverColor: const Color.fromARGB(56, 7, 210, 255),),
    );
  }

  void navigatetoeditpage(Map item) async {
    final route=MaterialPageRoute(builder: (context) => addtodolist(todo:item),);
    await Navigator.push(context, route);
    setState(() {
      isloading=true;
    });
    fetchdata();
    
  }
  void navigatetoaddpage( )async{
    final route=MaterialPageRoute(builder: (context) => addtodolist(),);
    await Navigator.push(context, route);
    setState(() {
      isloading=true;
    });
    fetchdata();
  }

  void deletebyid(String id) async {
     final url ="https://api.nstack.in/v1/todos/$id";
    final uri=Uri.parse(url);
    var response =await http.delete(uri);
    if(response.statusCode==200){
      // ignore: unrelated_type_equality_checks
      final filter=items.where((element) => element['_id'] != id,).toList();
      setState(() {
        items=filter;
      });
    }
    print(response.statusCode);
  }


 Future  fetchdata() async {
   
    final url ="https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri=Uri.parse(url);
    var response =await http.get(uri);
    print(response.statusCode);
    if(response.statusCode==200){
      final data= jsonDecode(response.body)as Map;
      final result=data["items"]as List;
      setState(() {
        items = result;
      });
      print(data);
    }

    setState(() {
      isloading = false;
    });
  }
}



// class TodoList extends StatelessWidget{
// const TodoList({
//     super.key,
//     required this.title,
//     required this.description,
//   });
  
//   final String title;
//   final String description;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

// }