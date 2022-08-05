import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  late DocumentSnapshot docToEdit;
  EditNote({required this.docToEdit});

 

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController(text: widget.docToEdit.data['title']);
    content = TextEditingController(text: widget.docToEdit.data['content']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(onPressed: (){
            widget.docToEdit.reference.updateData({
             'title':title.text,
             'content':content.text 
            }).whenComplete(() => Navigator.pop(context));
          },
          child: Text('Save'),),
          FlatButton(onPressed: (){
            widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
          },
          child: Text('Delete'),),
          
        ],
        
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border:Border.all()),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'Title'),
                ), 
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
                  decoration: BoxDecoration(border:Border.all()),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Content'),
                  ), 
            ),
          ),
          ],),
        ),
      
    );
  }
}