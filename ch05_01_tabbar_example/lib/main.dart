import 'package:flutter/material.dart';
import 'package:my_flutter_doti/sub/first_page.dart';
import 'package:my_flutter_doti/sub/second_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
  with SingleTickerProviderStateMixin{

  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('TabBar Example'),
    ),
    body: TabBarView(
      controller: controller,
      children: const [
        FirstApp(),
        SecondApp(),
      ],
    ),
    bottomNavigationBar: TabBar(tabs: const [
      Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
      Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
    ],
      controller: controller,
    ),
  );
  }

}

