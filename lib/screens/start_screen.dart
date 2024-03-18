import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/widgets/entries_list_block.dart';
import 'package:diaryapp/widgets/feelings_list_block.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {

  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    
    return const BaseScaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              
              EntriesListBlock(),

              FeelingsListBlock(),

            ],
          ),
        )
    );
    
  }
}