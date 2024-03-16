import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

import 'package:diaryapp/models/entry.dart';


class DatabaseHandler {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      _printEntries(entries: entries);
    });

    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

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
      return entries;
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

}