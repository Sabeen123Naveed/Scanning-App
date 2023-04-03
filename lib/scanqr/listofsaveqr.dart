import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scanning/scanqr/qrcodescan.dart';

import '../scancnic/modelclass.dart';




class Listqr extends StatefulWidget {
  const Listqr({Key? key}) : super(key: key);

  @override
  State<Listqr> createState() => _ListqrState();
}

class _ListqrState extends State<Listqr> {
  TextEditingController controller = TextEditingController();
  Box<Qr>? saveBoxxx;
  // Delete info from save box
  _deleteInfo(int index) {
    saveBoxxx!.deleteAt(index);
    print('Item deleted from box at index: $index');
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      saveBoxxx = Hive.box<Qr>("Qr box");
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(' List of Save Qr codes'),

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Qrcodescan(),
              ),
            ),
            child: Icon(Icons.add),
          ),
          body: ValueListenableBuilder(
              valueListenable: saveBoxxx!.listenable(),
              builder: (context,  Box<Qr> qrBox , _ ){
                if (qrBox.isEmpty) {
                  return Center(
                    child: Text('No Record Found'),
                  );
                }
                else{
                  // List<TodoModel> list = [];
                  return ListView.builder(
                      itemCount: qrBox.length,
                      itemBuilder: (context, index) {
                        var currentBox = qrBox;
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
                              leading:IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () async {
                                  await FlutterClipboard.copy(personData.qrcode.toString());

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('✓   Copied to Clipboard')),
                                  );
                                },
                              ),
                              title: Text("Scan Result",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              subtitle: Text(personData.qrcode.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
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





