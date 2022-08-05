import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/edit_note.dart';

import 'add_note.dart';

void main() => runApp(MyApp());  
  
/// This Widget is the main application widget.  
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: HomePage(),  
    );  
  }  
}  

class HomePage extends StatelessWidget {

  final ref = Firestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes App'),),
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote()));
      },),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: snapshot.hasData?snapshot.data!.documents.length:0,
          itemBuilder: (_,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditNote(docToEdit: snapshot.data!.documents[index],),));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 150,
                color: Colors.blueAccent[100],
                child: Padding(
                  padding : EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Text(
                      snapshot.data!.documents[index].data['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    SizedBox(height: 10,),
                    Text(
                      snapshot.data!.documents[index].data['content']
                      )
                  ],),
                ),
              ),
            );
          }
          
          );
        }
      ),
      
    );
  }
}