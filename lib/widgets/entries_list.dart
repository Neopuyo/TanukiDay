import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/entries_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class EntriesList extends StatelessWidget {
  final int displayLimit;
  final _dbHandler = DatabaseHandler();
  final List<Entry> entries;

  EntriesList({super.key, required this.entries, this.displayLimit = 2})
  : assert(displayLimit > 0, 'displayLimit must be positive');
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length < displayLimit ? entries.length : displayLimit,
      itemBuilder: (BuildContext context, int index) {
        final Entry entry = entries[index];
        return Dismissible(
          key: Key(entry.date.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _dbHandler.deleteEntry(entryDate: entry.date);
          },
          child: EntryListTile(
            entry: entry, 
            onDelete: () => _dbHandler.deleteEntry(entryDate: entry.date),
            onTap: () {
              context.go('/entry-detail', extra: {'isCreation': false, 'entry': entry});
            }
          ),
        );
      },
    );
  }
}