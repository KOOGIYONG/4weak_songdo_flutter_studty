import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  Timer? timer;
  Stopwatch stopwatch = Stopwatch();
  Duration time = Duration.zero;

  int _tapNumber = 1;

  int _H = 0;
  int _M = 0;
  int _S = 0;
  int _m = 0;

  playAndPause(){
    if(timer != null){
      stopwatch.stop();
      timer?.cancel();
      timer = null;
      return;
    }
    else {
      stopwatch.start();
      timer = Timer.periodic(
        Duration(milliseconds: 10),
            (timer) {
          setState(() {
            time = stopwatch.elapsed;
          });
        },
      );
    }
  }

  reset(){
    if(timer != null){
      timer?.cancel();
      timer = null;

       _tapNumber = 1;
       _H = 0;
       _M = 0;
       _S = 0;
       _m = 0;

    }
    stopwatch.reset();
    setState(() {
      time = Duration.zero;
    });
  }

  mark(){

    if(timer != null) {
      ++_tapNumber;
      _H = (time.inHours % 24);
      _M = (time.inMinutes % 60);
      _S = (time.inSeconds % 60);
      _m = ((time.inMilliseconds/10).floor() % 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      '${time.inHours.toString().padLeft(2, '0')} : ${(time.inMinutes % 60).toString().padLeft(2, '0')} : ${(time.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Text('${(time.inMilliseconds / 10).floor() % 100}',
                    style: TextStyle(
                      fontSize: 30,
                    ),),
                ],
              ),
          ),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(
                '랩${_tapNumber}      ${_H} : ${_M} : ${_S} . $_m',
                ),
              ),
              Expanded(child: Text(
                '${time.inHours - _H} : ${time.inMinutes - _M} : ${time.inSeconds - _S} . ${(time.inMilliseconds/10 - _m).floor() % 100}',
              ),
              ),
             ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: reset,
              ),
              FloatingActionButton.large(
                child: Icon(Icons.play_arrow),
                onPressed: playAndPause,
              ),
              FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: mark,
              ),
            ],
          )
        ],
      ),
    );
  }
}
