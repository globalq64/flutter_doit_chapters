import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// *****
class LargeFileMain extends StatefulWidget {
  const LargeFileMain({Key? key}) : super(key: key);

  @override
  _LargeFileMainState createState() => _LargeFileMainState();
}

// =====
class _LargeFileMainState extends State<LargeFileMain> {

  TextEditingController? _editingController;

  @override
  void initState(){
    super.initState();
    _editingController = new TextEditingController(
      text: 'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
           '?auto=compress'
    );
  }

  bool downloading = false;
  var progressString = '';
  String file = '';

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_editingController!.value.text, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        print('Rec: $rec, Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download Completed ...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url 입력하세요'),
        ),
      ),
      body: Center(
        child: downloading
            ? Container(
                height: 120,
                width: 200,
                child: Card(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Downloading FIle: $progressString',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              )
            : FutureBuilder(
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      print('none');
                      return Text('데이터 없음');
                    case ConnectionState.waiting:
                      print('waiting');
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      print('active');
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      print('done');
                      if (snapshot.hasData) {
                        return snapshot.data as Widget;
                      }
                  }
                  print('end process');
                  return Text('에이터 없음');
                },
                future: downloadWidget(file)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          downloadFile();
        },
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if (exist) {
      return Center(
        child: Column(
          children: [Image.file(File(filePath))],
        ),
      );
    } else {
      return Text('NoNo Data...');
    }
  }
}
