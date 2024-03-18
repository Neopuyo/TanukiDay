

import 'package:diaryapp/widgets/feelings_list.dart';
import 'package:diaryapp/widgets/miniWidgets/header_card_widget.dart';
import 'package:flutter/material.dart';

class FeelingsListBlock extends StatelessWidget {
  const FeelingsListBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderCard(
          children: [
            Text('Feelings', style: Theme.of(context).textTheme.displaySmall),
          ],
        ),

        const SizedBox(height: 4),

        FeelingsList(),

      ],
    );
  }

    

}