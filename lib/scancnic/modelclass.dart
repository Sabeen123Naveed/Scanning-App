import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'modelclass.g.dart';
@HiveType(typeId: 0)
class TodoModel{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String  cnic;
  @HiveField(2)
  final String  dob;
  @HiveField(3)
  final String  doi;
  @HiveField(4)
  final String  doe;
  @HiveField(5)
  final String imageUrl;
  @HiveField(6)
  String imageUrl2;


  TodoModel({
    required this.name,
    required this.cnic,
    required this.dob,
    required this.doi, required this.doe,
    required this. imageUrl,
    required this.imageUrl2,

  });

}
@HiveType(typeId: 1)
class Doc {
  @HiveField(0)
  String? imageU;
  Doc({required this.imageU});
}
@HiveType(typeId: 2)
class Qr {
  @HiveField(0)
  final  String qrcode;
  Qr({required this.qrcode});
}