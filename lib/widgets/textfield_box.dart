import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldBox extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final double? width;

  const TextFieldBox({Key? key, required this.controller, this.onChanged,this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: InputBorder.none),
              keyboardType: TextInputType.number),
        ));
  }
}
