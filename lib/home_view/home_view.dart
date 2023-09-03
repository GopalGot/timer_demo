import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';

class HomeView extends StatelessWidget {
   HomeView({Key? key}) : super(key: key);
  final controller = Get.put(HomeViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timers"),
        centerTitle: true,
      ),
      body:  GetBuilder<HomeViewController>(
          init: HomeViewController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(itemCount:controller.timers.length,itemBuilder: (context,index){
                String strDigits(int n) => n.toString().padLeft(2, '0');
                bool isComplete = controller.timers[index].isContinue;
                final hours = strDigits(controller.timers[index].duration!.inHours.remainder(24));
                final minutes = strDigits(controller.timers[index].duration!.inMinutes.remainder(60));
                final seconds = strDigits(controller.timers[index].duration!.inSeconds.remainder(60));
                return Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color:isComplete?Colors.grey.shade300:Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Visibility(
                    visible: isComplete,
                    replacement: Center(child: Text("Completed",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
                    child: Row(
                      children: [
                        Expanded(child: Center(child: Text("$hours:$minutes:$seconds",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),))),
                        InkWell(
                          onTap: (){
                            controller.onRemoveTimer(index);
                          },
                          child: Container(decoration: BoxDecoration(color: Colors.white30,
                            borderRadius: BorderRadius.circular(50)
                          ),child: const Icon(Icons.close)),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.addTimer(context);
        },
        child: const Icon(Icons.add),
      ),
    );  }
}
