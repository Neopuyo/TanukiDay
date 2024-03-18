import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/models/tuple.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/entries_list_block.dart';
import 'package:diaryapp/widgets/feelings_list_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StartScreen extends StatelessWidget {

  StartScreen({super.key});

  final _dbHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {

    final usermail = Provider.of<UserState>(context, listen: false).email;

    return BaseScaffold(
      body: StreamBuilder<Tuple2<List<Entry>, Map<String, int>>>(
        stream: _dbHandler.getEntriesAndFeelingsStream(usermail),
        builder: (context, snapshot) {

           if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final entries = snapshot.data!.item1;
          final feelingsMap = snapshot.data!.item2;

          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EntriesListBlock(entries: entries),
                  FeelingsListBlock(feelingsMap: feelingsMap),
                ],
              ),
            );
        }
      )
    );
  }
}