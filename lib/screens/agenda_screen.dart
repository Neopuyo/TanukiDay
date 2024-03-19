import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/entries_table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';

class AgendaScreen extends StatelessWidget {

   AgendaScreen({super.key});

   final _dbHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
   final usermail = Provider.of<UserState>(context, listen: false).email;

    return BaseScaffold(
      body: StreamBuilder<LinkedHashMap<DateTime, List<Entry>>>(
        stream: _dbHandler.getCalendarFormatedEntriesStream(usermail),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final linkedHashEntries = snapshot.data!;
          return CalendarTableEntries(linkedHashEntries: linkedHashEntries);
        }
      )
    );
  }

}