import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/entries_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class EntriesList extends StatelessWidget {
  final int displayLimit;
  final _dbHandler = DatabaseHandler();

  EntriesList({super.key, this.displayLimit = 2})
  : assert(displayLimit > 0, 'displayLimit must be positive');
  

  @override
  Widget build(BuildContext context) {

    final usermail = Provider.of<UserState>(context, listen: false).email;

    return StreamBuilder<List<Entry>>(
      stream: _dbHandler.getEntriesStream(usermail),
      builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Entry> entries = snapshot.data ?? [];
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
                  }),
              );
            },
          );
        }
      },
    );
  }
}