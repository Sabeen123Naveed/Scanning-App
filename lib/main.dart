import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanning/scancnic/modelclass.dart';




import 'home.dart';

/*List<Box> boxList = [];
Future<List<Box>> _openBox1() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TodoModelAdapter());
  Box<TodoModel> cnicBox = await Hive.openBox('cnic box');
  Hive.registerAdapter(DocAdapter());
  Box<Doc> docBox = await Hive.openBox('doc box');
  boxList.add(cnicBox);
  boxList.add(docBox);
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox1();
  runApp(MyApp());
}*/


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>("cnic box");
  Hive.registerAdapter(DocAdapter());
  await Hive.openBox<Doc>("doc box");
  Hive.registerAdapter(QrAdapter());
  await Hive.openBox<Qr>("qr box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  Homepage(),
    );
  }
}
