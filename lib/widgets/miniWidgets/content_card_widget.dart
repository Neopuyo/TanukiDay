import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: TanukiColor.BODY_COLOR,
        border: Border.all(
          color: TanukiColor.PRIMARY,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

}