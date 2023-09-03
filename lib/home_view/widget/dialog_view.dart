import 'package:flutter/material.dart';

import '../../widgets/textfield_box.dart';
import '../model/timer_model.dart';

class DialogView extends StatelessWidget {
  DialogView({Key? key}) : super(key: key);
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final getWidth = MediaQuery.of(context).size.width*0.15;
    debugPrint("this is width===>$getWidth");
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titlePadding: EdgeInsets.zero,
      title: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(child: Text("Add Timer"))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextFieldBox(
                      width: getWidth,
                      controller: hourController,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const Text("Hour")
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextFieldBox(width:getWidth,
                      controller: minuteController,
                      onChanged: (value) {
                        int sec = int.tryParse(value) ?? 0;
                        if (sec > 60) {
                          int minutes = int.tryParse(hourController.text) ?? 0;
                          final least = sec / 60;
                          final lst = least.toStringAsFixed(2).split(".");
                          if (lst.length > 1) {
                            final secCount = ((int.parse(lst.last)) * 60) / 100;
                            minuteController.text = (secCount.round()).toString();
                            hourController.text =
                                (int.parse(lst.first) + minutes).toString();
                          }
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const Text("Minutes")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextFieldBox(
                      width: getWidth,
                      controller: secondController,
                      onChanged: (value) {
                        int sec = int.tryParse(value) ?? 0;
                        if (sec > 60) {
                          int minutes = int.tryParse(minuteController.text) ?? 0;
                          final least = sec / 60;
                          final lst = least.toStringAsFixed(2).split(".");
                          if (lst.length > 1) {
                            final secCount = ((int.parse(lst.last)) * 60) / 100;
                            secondController.text = (secCount.round()).toString();
                            minuteController.text =
                                (int.parse(lst.first) + minutes).toString();
                          }
                        }
                      },
                    ),
                  ],
                ),
                const Text("Sec")
              ],
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
                style: ButtonStyle(
                 // backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      // Change your radius here
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: () {
                  final data =Duration(
                      seconds: int.tryParse(secondController.text) ?? 0,
                      minutes: int.tryParse(minuteController.text) ?? 0,
                      hours: int.tryParse(hourController.text) ?? 0);
                  Navigator.pop(context,TimerModel(duration: data));
                },
                child: const Text("Add")),
          )
        ],
      ),
    );
  }
}
