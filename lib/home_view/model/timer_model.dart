import 'dart:async';

class TimerModel{

Duration? duration;
bool get isContinue => duration!.inSeconds>0?true:false;
TimerModel({this.duration});
}