import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scanning/scancnic/listofsacvecnic.dart';
import 'package:scanning/scandocument/listofsavedoc.dart';
import 'package:scanning/scanocr/ocr.dart';
import 'package:scanning/scanqr/listofsaveqr.dart';



class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home page"),
          centerTitle: true,

        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Listcnic()));
                },
                child: Text("Scan Cnic" , style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListDoc()));
                },
                child: Text("Scan Document" ,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Ocrecognition()));
                },
                child: Text("Scan Ocr" ,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Listqr()));
                },
                child: Text("Scan Qrcode" ,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}