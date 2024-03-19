


import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/widgets/event_table_calendar.dart';
import 'package:diaryapp/widgets/table_calendar.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {

  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      // body: TableCalendarWidget(),
      body: CalendarTableEntries(),
    );

  }

}