import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scanning/scancnic/pdfsave.dart';
import 'cnicsacn.dart';
import 'modelclass.dart';
import 'newscreenn.dart';




class Listcnic extends StatefulWidget {
  const Listcnic({Key? key}) : super(key: key);

  @override
  State<Listcnic> createState() => _ListcnicState();
}

class _ListcnicState extends State<Listcnic> {
  Box<TodoModel>? saveBox;
  // Delete info from people box
  _deleteInfo(int index) {
    saveBox!.deleteAt(index);
    print('Item deleted from box at index: $index');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      saveBox = Hive.box<TodoModel>("cnic box");
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(' List of Save cnic'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Cnicfrontdes (),
              ),
            ),
            child: Icon(Icons.add),
          ),
          body: ValueListenableBuilder(
              valueListenable: saveBox!.listenable(),
              builder: (context,  Box<TodoModel> cnicBox , _ ){
                if (cnicBox.isEmpty) {
                  return Center(
                    child: Text('No Record Found'),
                  );
                }
                else{
                  // List<TodoModel> list = [];
                  return ListView.builder(
                      itemCount: cnicBox.length,
                      itemBuilder: (context, index) {
                        var currentBox = cnicBox;
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
                              onTap: () async {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => NewScreen(
                                      name: personData.name,
                                      cnic: personData.cnic,
                                      dob: personData.dob,
                                      doi: personData.doi,
                                      doe: personData.doe,
                                      imageUrl: personData.imageUrl,
                                      imageUrl2: personData.imageUrl2,)
                                    )
                                );
                              },
                              leading: Image.file(File(personData.imageUrl.toString()
                              ),

                              ),
                              title: Text(personData.name.toString()),
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
    );
  }
}
