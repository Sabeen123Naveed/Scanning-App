import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cnic_scanner/model/cnic_model.dart';





import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import 'package:cnic_scanner/cnic_scanner.dart';


import 'appcolor.dart';
import 'customdialog.dart';
import 'modelclass.dart';





class Cnicfrontdes extends StatefulWidget {
  @override
  _CnicfrontdesState createState() => _CnicfrontdesState();
}

class _CnicfrontdesState extends State<Cnicfrontdes> {

  TextEditingController nameTEController = TextEditingController(),
      cnicTEController = TextEditingController(),
      dobTEController = TextEditingController(),
      doiTEController = TextEditingController(),
      doeTEController = TextEditingController();

  Box<TodoModel>? cnicBox;
  XFile? _image;
  XFile? _image2;



  /// you're required to initialize this model class as method you used
  /// from this package will return a model of CnicModel type
  CnicModel _cnicModel = CnicModel();

  Future<void> scanCnic(ImageSource imageSource) async {
    /// you will need to pass one argument of "ImageSource" as shown here
    var image = await ImagePicker().pickImage(source: imageSource);
    if(image == null) return;
    XFile? img = XFile(image.path);
    img = await _cropimage(imagefile: img);



    CnicModel cnicModel =
    await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) return;
    setState(() {
      _cnicModel = cnicModel;

      nameTEController.text = _cnicModel.cnicHolderName;
      cnicTEController.text = _cnicModel.cnicNumber;
      dobTEController.text = _cnicModel.cnicHolderDateOfBirth;
      doiTEController.text = _cnicModel.cnicIssueDate;
      doeTEController.text = _cnicModel.cnicExpiryDate;
      _image = img;
      //  _image = (await EdgeDetection.detectEdge);
    });
  }
  Future<void>scanCnic2(ImageSource imageSource) async {
    var image2 = await ImagePicker().pickImage(source: imageSource);
    if(image2 == null) return;
    XFile? img2 = XFile(image2.path);
    img2 = await _cropimage2(imagefile2: img2);
    setState(() {
      _image2 = img2;
    });

  }
  Future<XFile?> _cropimage({required XFile imagefile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imagefile.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        /* IOSUiSettings(
        title: 'Cropper',
      ),*/
        /* WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.dialog,
        boundary: const CroppieBoundary(
          width: 520,
          height: 520,
        ),
        viewPort:
        const CroppieViewPort(width: 480, height: 480, type: 'circle'),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
      ),*/
      ],
    );
    if(croppedImage == null)
      return null;
    return XFile(croppedImage.path);

  }
  Future<XFile?> _cropimage2({required XFile imagefile2}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imagefile2.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),

      ],
    );
    if(croppedImage == null)
      return null;
    return XFile(croppedImage.path);

  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cnicBox = Hive.box<TodoModel>("cnic box");
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Center(
          //child: Container(
          //  margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),

          //  padding:  EdgeInsets.all(0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Enter ID Card Details',
                      style: TextStyle(
                          color: Color(kDarkGreyColor),
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text('To verify your Account, please enter your CNIC details.',
                      style: TextStyle(
                          color: Color(kLightGreyColor),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    // flex: 10,
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,

                      children: [
                        _dataField(
                            text: 'Name', textEditingController: nameTEController),
                        _cnicField(textEditingController: cnicTEController),
                        _dataField(
                            text: 'Date of Birth',
                            textEditingController: dobTEController),
                        _dataField(
                            text: 'Date of Card Issue',
                            textEditingController: doiTEController),
                        _dataField(
                            text: 'Date of Card Expire',
                            textEditingController: doeTEController),
                      ],
                    ),
                  ),
                  /* SizedBox(
                        height: 5,
                      ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      _image == null ? Container():Image.file(File(_image!.path),
                        fit: BoxFit.fill,
                        width: 100.0,
                        height: 100.0,
                      ),

                      /*  SizedBox(
                        height: 25,
                      ),*/
                      _image2 == null? Container():Image.file(File(_image2!.path),
                        fit: BoxFit.fill,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  //  _getScanCNICBtn(),











                  _getScanCNICBtn(),
                  SizedBox(
                    height: 20,
                  ),
                  _getScanCNICBtn2(),
                  SizedBox(
                    height: 80,
                  ),




                  Row(
                    children: [


                      Expanded(
                        child: TextButton(onPressed: (){
                          /*  final String name = nameTEController.text;
                                final String cnic = cnicTEController.text;
                                final String  dob =  dobTEController.text;
                                final String  doi =   doiTEController.text;
                                final String   doe = doeTEController.text;
                                TodoModel todo = TodoModel(
                                     name : name , cnic: cnic , dob:dob ,doi:doi, doe:doe, image: img64)
                                cnicBox!.add(todo);*/

                          cnicBox!.put("${DateTime.now().toString()}" ,TodoModel(
                            name: nameTEController.text.toString(),
                            cnic: cnicTEController.text.toString(),
                            dob: dobTEController.text.toString(),
                            doi:  doiTEController.text.toString(),
                            doe: doeTEController.text.toString(),
                            imageUrl: _image!.path.toString(),
                            imageUrl2: _image2!.path.toString(),

                          ),

                          );
                          Navigator.of(context).pop();



                          //   Navigator.pop(context);
                          /*cnicBox!.put(
                                  nameTEController.text,
                                  cnicTEController.text,
                                   dobTEController.text,
                                    doiTEController.text,
                                    doeTEController.text
                                );*/
                          //  idcontroller.clear();
                          //  namecontroller.clear();
                          //  Navigator.pop(context);
                        },
                          child: Text("Save data",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30)),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.blue, width: 3.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),






                  /*ValueListenableBuilder(
                    valueListenable:cnicBox!.listenable(),
                    builder: (context,  Box<TodoModel> cnicBox , _ ){


                      List<TodoModel> list = [];

                      // print("Print : ${cnicBox.keys..toString()}");
                      print("Print : ${cnicBox.values.toString()}");

                      cnicBox.values.forEach((TodoModel element) {
                        list.add(element);
                        print("Print : element  ${element.name.toString()}");
                      });

                      // return Text("${cnicBox.values.toString()}");

                      // List<int> keys;
                      return Expanded(
                          child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context,  index){
                                //    List<int> keys;
                                //   final int key = keys[index];

                                // cnicBox.values.forEach((element) {
                                //   print("Print : ${element.toString()}");
                                // });
                                // final TodoModel? todo = cnicBox.get(cnicBox.values);


                                // return Text("${cnicBox.values[index].}");


                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 0.7,
                                    shadowColor: Colors.cyanAccent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.greenAccent,
                                      ),
                                    ),



                                    child: Column(
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),




                                          child: ListTile(
                                            onTap: (){
                                             // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Listcnic(name: list[index].name, imageUrl: list[index].imageUrl,)));
                                            },
                                            leading:Image.file(File(list[index]!.imageUrl.toString()),),
                                            title: Text(list[index].name ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
                                          ),



                                        ),



                                        /* ListTile(
                                            subtitle: Text(list[index].cnic ,style: TextStyle(fontSize: 15), ),
                                          ),
                                          ListTile(
                                            title: Text(list[index].dob ,style: TextStyle(fontSize: 15), ),
                                          ),
                                          ListTile(
                                            title: Text(list[index].doi ,style: TextStyle(fontSize: 15), ),
                                          ),
                                          ListTile(
                                            title: Text(list[index].doe ,style: TextStyle(fontSize: 15), ),
                                          ),*/


                                      ],
                                    ),
                                  ),

                                );
                              }
                          )
                      );

                    }

                )*/
                ]
            )
        )




    );






  }

  /// these are my custom designs you can use according to your ease
  Widget _cnicField({required TextEditingController textEditingController}) {
    return Card(
      elevation: 7,
      // margin: const EdgeInsets.only(top: 2.0, bottom: 5.0),
      child: Container(
        // margin:
        //const EdgeInsets.only(top: 2.0, bottom: 1.0, left: 0.0, right: 0.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //   width: 3,
                // height: 45,
                //margin: const EdgeInsets.only(left: 3.0, right: 7.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(kDeepDarkGreenColor),
                        const Color(kDarkGreenColor),
                        const Color(kGradientGreyColor),
                      ],
                      stops: [
                        0.0,
                        0.5,
                        1.0
                      ],
                      tileMode: TileMode.mirror,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topRight),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CNIC Number',
                        style: TextStyle(
                            color: Color(kDarkGreenColor),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/cnic.png",
                              width: 40, height: 30),
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: '41000-0000000-0',
                                hintStyle: TextStyle(color: Color(kLightGreyColor)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 5.0),
                              ),
                              style: TextStyle(
                                  color: Color(kDarkGreyColor),
                                  fontWeight: FontWeight.bold),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataField(
      {required String text,
        required TextEditingController textEditingController}) {
    return Card(
        shadowColor: Color(kShadowColor),
        elevation: 5,
        //  margin: const EdgeInsets.only(
        //  top: 10,
        // bottom: 5,
        //),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                (text == "Name") ? Icons.person : Icons.date_range,
                color: Color(kDarkGreenColor),
                size: 17,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15.0, top: 5, bottom: 3),
                    child: Text(
                      text.toUpperCase(),
                      style: TextStyle(
                          color: Color(kDarkGreenColor),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, bottom: 0.0),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: (text == "Name") ? "User Name" : 'DD/MM/YYYY',
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(
                            color: Color(kLightGreyColor),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: TextStyle(
                          color: Color(kDarkGreyColor),
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.done,
                      keyboardType: (text == "Name")
                          ? TextInputType.text
                          : TextInputType.number,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getScanCNICBtn() {
    return TextButton(

      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue, width: 3.0),
            ),
          )
      ),
      onPressed: () {
        /// this is the custom dialog that takes 2 arguments "Camera" and "Gallery"
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(onCameraBTNPressed: () {
                scanCnic(ImageSource.camera);
              }, onGalleryBTNPressed: () {
                scanCnic(ImageSource.gallery);
              });
            });
      },
      //  textColor: Colors.white,
      //  padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(colors: <Color>[
            Color(kDeepDarkGreenColor),
            Color(kDarkGreenColor),
            Colors.green,
          ]),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Scan CNIC Front', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _getScanCNICBtn2() {
    return TextButton(

      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue, width: 3.0),
            ),
          )
      ),
      onPressed: () {
        /// this is the custom dialog that takes 2 arguments "Camera" and "Gallery"
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(onCameraBTNPressed: () {
                scanCnic2(ImageSource.camera);
              }, onGalleryBTNPressed: () {
                scanCnic2(ImageSource.gallery);
              });
            });
      },
      //  textColor: Colors.white,
      //  padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(colors: <Color>[
            Color(kDeepDarkGreenColor),
            Color(kDarkGreenColor),
            Colors.green,
          ]),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Scan CNIC Back', style: TextStyle(fontSize: 18)),
      ),
    );
  }



}
