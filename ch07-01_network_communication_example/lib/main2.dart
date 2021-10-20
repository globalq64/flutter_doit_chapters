import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main2() {
  // runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  _HttpAppState createState() => _HttpAppState();
}

// *************
class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Http Example')),
      body: Container(
        child: Center(
          child: data!.length == 0
              ? Text('데이터가 없습니다',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
              : ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Column(
                          children: [
                            Text(data![index]['title'].toString()),
                            Text(data![index]['authors'].toString()),
                            Text(data![index]['sale_price'].toString()),
                            Text(data![index]['status'].toString()),
                            Image.network(
                              data![index]['thumbnail'],
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  //itemCount: data!.length
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          getJSONData();
        },
      ),
    );
  }

  Future<String> getJSONData() async {
    var text = 'doit';
    var url = "https://dapi.kakao.com/v3/search/book?target=title&query=doit";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK 10d307a348786441d0b4645f1cba717d"});

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}
