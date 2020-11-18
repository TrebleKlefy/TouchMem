import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:touchgo/model/images.dart';
import 'package:touchgo/pages/startpage.dart';

int level = 8;

class GamePage extends StatefulWidget {
  final int size;

  const GamePage({Key key, this.size = 8}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<int> data = [];
  int previousIndex = -1;
  bool flip = false;
  int time = 0;
  Timer timer;
  final bool onlyOkButton = true;


  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i);
    }
    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void dispose() {
      timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              if (cardFlips.every((t) => t == false)) {
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.indigo[100].withOpacity(0.9),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                            image: AssetImage(
                            '${imageList[data[index]].name}'),
                            fit: BoxFit.fill)),
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image.asset('assets/party.gif'),
              title: Text('We have a winner!!!!!!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                'Your time is $time seconds',
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              onlyOkButton: true,
              buttonOkText: Text('Close'),
              onOkButtonPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Starting(),
                  ),
                );
              },
            ));
  }
}
