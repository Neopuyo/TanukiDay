
import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/entries_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:diaryapp/models/entry.dart';
import 'dart:collection';

class CalendarTableEntries extends StatefulWidget {

  const CalendarTableEntries({super.key, required this.linkedHashEntries});
  final LinkedHashMap<DateTime, List<Entry>> linkedHashEntries;

  @override
  State<StatefulWidget> createState() => _CalendarTableEntriesState();
}

class _CalendarTableEntriesState extends State<CalendarTableEntries> {
 
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  final _dbHandler = DatabaseHandler();
  late final DateTime _today;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late final ValueNotifier<List<Entry>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _firstDay = DateTime(_today.year, _today.month - 3, _today.day);
    _lastDay = DateTime(_today.year, _today.month + 6, _today.day);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEntriesForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

   List<Entry> _getEntriesForDay(DateTime day) {
    return widget.linkedHashEntries[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEntriesForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Entry>(
          firstDay: _firstDay,
          lastDay: _lastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: _getEntriesForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: _makeCalendarStyle(),
          headerStyle: _makeHeaderStyle(),
          daysOfWeekStyle: _makeDaysOfWeekStyle(),
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Entry>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final Entry entry = value[index];
                  return Dismissible(
                    key: Key(entry.date.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _dbHandler.deleteEntry(entryDate: entry.date);
                      setState(() {
                        value.removeAt(index);
                      });
                    }, 
                    child: EntryListTile(
                      entry: value[index],  
                      onTap: () {
                        context.go(
                          '/entry-detail', 
                          extra: {
                            'isCreation': false, 
                            'entry': value[index],
                            'goBackPath': '/agenda',
                          });
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  CalendarStyle _makeCalendarStyle() {
    return const CalendarStyle(
      markerDecoration: BoxDecoration(
        color: TanukiColor.SECONDARY,
        shape: BoxShape.circle
        ),
      todayDecoration: BoxDecoration(
        color: TanukiColor.PRIMARY_WRITE_UP,
        shape: BoxShape.circle
      ),
      selectedDecoration: BoxDecoration(
        color: TanukiColor.PRIMARY,
        shape: BoxShape.circle
      ),
      outsideDaysVisible: true,
      outsideTextStyle: TextStyle(
        color: TanukiColor.BODY_COLOR,
      ),
      defaultTextStyle: TextStyle(
        color: TanukiColor.TEXT_COLOR,
      ),
      weekendTextStyle: TextStyle(
        color: TanukiColor.SECONDARY,
      ),
      weekNumberTextStyle: TextStyle(
        color: TanukiColor.ACCENT,
      ),
    );
  }

  HeaderStyle _makeHeaderStyle() {
    return const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,     
    );
  }

  DaysOfWeekStyle _makeDaysOfWeekStyle() {
    return const DaysOfWeekStyle(
       weekdayStyle: TextStyle(
        color: TanukiColor.PRIMARY,
      ),
      weekendStyle: TextStyle(
        color: TanukiColor.SECONDARY,
      ),
    );
  }
}