
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widget/text_widget.dart';

class BoxDataWidget extends StatelessWidget {
  const BoxDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'NAME',
          ),
          TextWidget(
            text: 'Type',
          ),
          TextWidget(
            text: 'Priority',
          ),
        ]);
  }
}
