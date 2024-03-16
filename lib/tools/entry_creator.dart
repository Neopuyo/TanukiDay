

import 'package:diaryapp/models/entry.dart';

class EntryCreator {
  final String usermail;

  EntryCreator({required this.usermail});

  Entry createEntry({required String title, required String content, required String feeling}) {
    return Entry(
      usermail: usermail,
      title: title,
      content: content,
      feeling: feeling,
      date: DateTime.now(), 
    );
  }
}