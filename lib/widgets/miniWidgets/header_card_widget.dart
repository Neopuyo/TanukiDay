
import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  
  const HeaderCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: TanukiColor.BODY_COLOR,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [const SizedBox(width: 16, height:50), ...children],
      ),
    );
  }


}