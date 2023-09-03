import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'model/timer_model.dart';
import 'widget/dialog_view.dart';

class HomeViewController extends GetxController{
  List<TimerModel> timers = [];
  Timer? countdown;
  @override
  void onInit() {
    initialMethod();
    super.onInit();
  }
  initialMethod(){
    countdown =  Timer.periodic(const Duration(seconds: 1), (timer) {
      int timerLength = timers.where((element) => element.isContinue).toList().length;
      if(timerLength ==0){
        countdown?.cancel();
        return;
      }
      for(final timer in timers){
        if(timer.duration!.inSeconds>0){
          final sec = timer.duration!.inSeconds - 1;
          debugPrint("this is second===>$sec");
          timer.duration = Duration(seconds:sec);
          update();
        }
      }
    });
  }

  Future<void> addTimer(BuildContext context) async {
    TimerModel? duration = await showDialog(
        context: context,
        builder: (context) => DialogView());
   if(duration != null){
     debugPrint("isActive${countdown?.isActive}");
     if(!(countdown?.isActive??false)){
       initialMethod();
     }
     timers.add(duration);
   }
    update();
  }

  void onRemoveTimer(int index) {
    timers.removeAt(index);
    update();
  }
}