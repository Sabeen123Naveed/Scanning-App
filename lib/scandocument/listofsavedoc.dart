
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scanning/scandocument/newscreen.dart';
import 'package:scanning/scandocument/scandocument.dart';

import '../scancnic/modelclass.dart';


class ListDoc extends StatefulWidget {
  const ListDoc({Key? key}) : super(key: key);

  @override
  State<ListDoc> createState() => _ListDocState();
}

class _ListDocState extends State<ListDoc> {
  Box<Doc>? saveBoxx;
  // Delete info from save box
  _deleteInfo(int index) {
    saveBoxx!.deleteAt(index);
    print('Item deleted from box at index: $index');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      saveBoxx = Hive.box<Doc>("doc box");
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(' List of Save Document'),

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Document (),
                ),
              ),
              child: Icon(Icons.add),
            ),
            body: ValueListenableBuilder(
                valueListenable: saveBoxx!.listenable(),
                builder: (context,  Box<Doc> docBox , _ ){
                  if (docBox.isEmpty) {
                    return Center(
                      child: Text('No Record Found'),
                    );
                  }
                  else{
                    // List<TodoModel> list = [];
                    return ListView.builder(
                        itemCount: docBox.length,
                        itemBuilder: (context, index) {
                          var currentBox = docBox;
                          var personData = currentBox.getAt(index)!;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 0.7,
                              shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black87,
                                ),
                              ),
                              child:ListTile(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => NewScreen1
                                        (
                                        imageU: personData.imageU,
                                      )
                                      )
                                  );
                                },
                                leading: Image.file(File(personData.imageU.toString()
                                ),

                                ),
                                title: Text("Document ",style: TextStyle(color: Colors.black,fontSize: 15),),
                                trailing: IconButton(
                                  onPressed: () {
                                    _deleteInfo(index);

                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),


                            ),
                          );

                        }
                    );
                  }
                }

            )
        ),
      ),
    );
  }
}




