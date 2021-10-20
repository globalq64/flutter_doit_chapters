import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../animal_item.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal>? animalList;

  const CupertinoSecondPage({Key? key, this.animalList}) : super(key: key);

  @override
  _CupertinoSecondPageState createState() => _CupertinoSecondPageState();
}

// ***************
class _CupertinoSecondPageState extends State<CupertinoSecondPage> {
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(child: Text('양서류', textAlign: TextAlign.center), width: 80),
    1: SizedBox(child: Text('포유류', textAlign: TextAlign.center), width: 80),
    2: SizedBox(child: Text('파충류', textAlign: TextAlign.center), width: 80),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('동물추가')),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    maxLines: 1),
              ),
              CupertinoSegmentedControl(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value) {
                    setState(() {
                      _kindChoice = value;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                      value: _flyExist,
                      onChanged: (value) {
                        setState(() {
                          _flyExist = value;
                        });
                      })
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                        child: Image.asset('repo/images/cow.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/cow.png';
                        }),
                    GestureDetector(
                        child: Image.asset('repo/images/pig.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/pig.png';
                        }),
                    GestureDetector(
                        child: Image.asset('repo/images/bee.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/bee.png';
                        }),
                    GestureDetector(
                        child: Image.asset('repo/images/cat.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/cat.png';
                        }),
                    GestureDetector(
                        child: Image.asset('repo/images/dog.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/dog.png';
                        }),
                    GestureDetector(
                        child: Image.asset('repo/images/wolf.png', width: 80),
                        onTap: () {
                          _imagePath = 'repo/images/wolf.png';
                        }),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Text('동물 추가하기'),
                  onPressed: () {
                    widget.animalList!.add(Animal(
                        animalName: _textController!.value.text,
                        kind: getKind(_kindChoice),
                        imagePath: _imagePath,
                        flyExist: _flyExist));
                  })
            ],
          ),
        ),
      ),
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return '양서류';
      case 1:
        return '파충류';
      case 2:
        return '포유류';
    }
  }
}
