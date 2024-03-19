import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/models/tuple.dart';
import 'dart:collection';
import 'dart:developer' as dev;

import 'package:table_calendar/table_calendar.dart';


class DatabaseHandler {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // [K] The stream version is used in list view
  // Not used anymore but interesting
  Future<List<Entry>> getEntriesFrom({required String usermail}) async {
    final List<Entry> entries = [];

    await _db.collection("entries")
    .where("usermail", isEqualTo: usermail)
    .get()
    .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final Entry entry = Entry.fromFirestore(data);
        entries.add(entry);
      }
      // DEBUG ONLY
      // _printEntries(entries: entries);
    });

    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

 // [K] Keeping :
 // Entry and feeling stream are merged into one unique stream
 // Without this it'll show duplicate content and unexpected behaviours
 Stream<List<Entry>> getEntriesStream(String usermail) {
    return _db.collection("entries")
        .where("usermail", isEqualTo: usermail)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      final List<Entry> entries = [];
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final Entry entry = Entry.fromFirestore(data);
        entries.add(entry);
      }

      entries.sort((a, b) => b.date.compareTo(a.date));
      // _printEntries(entries: entries);
      return entries;
    });
  }

  // [K] Keeping
  Stream<Map<String, int>> getFeelingsStream(String usermail) {

    Map<String, int> feelingResume = {};
    for (var entry in Entry.feelingToIconMap.entries) {
      feelingResume[entry.value] = 0;
    }

    return _db.collection("entries")
        .where("usermail", isEqualTo: usermail)
        .snapshots()
        .map((QuerySnapshot snapshot) {
          for (var doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final Entry entry = Entry.fromFirestore(data);
            if (feelingResume.containsKey(entry.feeling)) {
              feelingResume[entry.feeling] = feelingResume[entry.feeling]! + 1;
            }
          }
          // _printFeelings(feelingResume: feelingResume);
          return feelingResume;
    });
  }

  Stream<Tuple2<List<Entry>, Map<String, int>>> getEntriesAndFeelingsStream(String usermail) {
    return _db.collection("entries")
        .where("usermail", isEqualTo: usermail)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      final List<Entry> entries = [];
      final Map<String, int> feelingResume = {};
      for (var entry in Entry.feelingToIconMap.entries) {
        feelingResume[entry.value] = 0;
      }
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final Entry entry = Entry.fromFirestore(data);
        entries.add(entry);
        if (feelingResume.containsKey(entry.feeling)) {
          feelingResume[entry.feeling] = feelingResume[entry.feeling]! + 1;
        }
      }
      entries.sort((a, b) => b.date.compareTo(a.date));
      // _printEntries(entries: entries);
      // _printFeelings(feelingResume: feelingResume);
      return Tuple2(entries, feelingResume);
    });
  }

  Stream<LinkedHashMap<DateTime, List<Entry>>> getCalendarFormatedEntriesStream(String usermail) {
    return _db.collection("entries")
      .where("usermail", isEqualTo: usermail)
      .snapshots()
      .map((QuerySnapshot snapshot) {

          final map = LinkedHashMap<DateTime, List<Entry>>(
            equals: isSameDay,
            hashCode: _getHashCode,
          );

          for (var qdoc in snapshot.docs) {
            final data = qdoc.data() as Map<String, dynamic>;
            final Entry entry = Entry.fromFirestore(data);
            final date = entry.date;

            if (map.containsKey(date)) {
              map[date]!.add(entry);
            } else {
              map[date] = [entry];
            }
          }

          return map;
      });
  }



  void addEntry({required Entry entry}) {
    _db.collection("entries")
    .add(entry.toJson())
    .then((DocumentReference doc) {
      dev.log('New Entry document added with ID: ${doc.id}');
    });
  }

  void updateEntry({required Entry entry}) {
    _db.collection("entries")
    .where("date", isEqualTo: entry.date.toIso8601String())
    .get()
    .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update(entry.toJson())
        .then((value) => dev.log("Entry with date: ${entry.date} updated"))
        .catchError((error) => dev.log("Failed to update entry with date: ${entry.date}"));
      }
    });
  }

  void deleteEntry({required DateTime entryDate}) {
    _db.collection("entries")
    .where("date", isEqualTo: entryDate.toIso8601String())
    .get()
    .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete()
        .then((value) => dev.log("Entry with date: $entryDate deleted"))
        .catchError((error) => dev.log("Failed to delete entry with date: $entryDate"));
      }
    });
  }

  // PRIVATE TOOLS
  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  // DEBUG TOOL
  void _printEntries({required List<Entry> entries}) {
    if (entries.isNotEmpty) {
      dev.log("[Entries List]");
      for (var entry in entries) {
        dev.log("> ${entry.toString()}");
      }
    } else {
      dev.log("[Empty Entries List]");
    }
  }

  void _printFeelings({required Map<String, int> feelingResume}) {
    if (feelingResume.isNotEmpty) {
      dev.log("[Feeling Resume]");
      for (var entry in feelingResume.entries) {
        dev.log("> ${entry.key} : ${entry.value}");
      }
    } else {
      dev.log("[Empty Feeling Resume]");
    }
  }

}