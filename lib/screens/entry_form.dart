
import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/design/tanuki_theme.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class EntryForm extends StatefulWidget {
  const EntryForm({super.key, required this.isCreation, required this.entry, this.goBackPath = '/'});

  final bool isCreation;
  final Entry? entry;
  final String goBackPath;

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {

  final _formKey = GlobalKey<FormState>();
  final DatabaseHandler _dbHandler = DatabaseHandler();
  

  late String _title;
  late String _content;
  late String _feeling;

  @override
  void initState() {
    super.initState();
      _title = widget.entry?.title ?? '';
      _content = widget.entry?.content ?? '';
      _feeling = widget.entry?.feeling ?? 'sentiment_neutral';
  }

  Widget _buildFeelingButton(IconData iconData, String feeling) {
    
    final selected = _feeling == feeling;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: selected
            ? TanukiColor.getColorFromStringFeeling(feeling: feeling)
            : TanukiColor.GREY,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(iconData),
        color: TanukiColor.getColorFromStringFeeling(feeling: feeling),
        onPressed: () {
          setState(() {
            _feeling = feeling;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) { 
    final String usermail = Provider.of<UserState>(context, listen: false).email;
    return BaseScaffold(
      title: widget.isCreation ? 'Add entry' : 'Read entry',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TanukiTheme.textfieldLabel(),
                  filled: true,
                  fillColor: TanukiColor.BODY_COLOR,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  if (value.length > 100) {
                    return 'Title is too long, 100 characters max.';
                  }
                  return null;
                },
                onSaved: (value) => _title = value ?? '',
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _content,
                minLines: 6,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TanukiTheme.textfieldLabel(),
                  filled: true,
                  fillColor: TanukiColor.BODY_COLOR,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  if (value.length > 1000) {
                    return 'Content is too long, 1000 characters max.';
                  }
                  return null;
                },
                onSaved: (value) => _content = value ?? '',
              ),

              const SizedBox(height: 20),

              Text('Feeling of the day',
              style: TanukiTheme.textfieldLabel()),
              
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Entry.stringToIconDataMap.entries.map((entry) {
                  return _buildFeelingButton(entry.value, entry.key);
                }).toList(),
              ),



              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.isCreation) {
                      // CREATE ENTRY
                      final newEntry = Entry(
                        title: _title,
                        content: _content,
                        feeling: _feeling,
                        date: DateTime.now(), 
                        usermail: usermail,
                      );
                      _dbHandler.addEntry(entry: newEntry);
                      context.go(widget.goBackPath);
                    } else {
                      // UPDATE ENTRY
                      final updatedEntry = Entry(
                        title: _title,
                        content: _content,
                        feeling: _feeling,
                        date: widget.entry!.date,
                        usermail: usermail,
                      );
                      _dbHandler.updateEntry(entry: updatedEntry);
                      context.go('/');
                    }
                  }
                },
                icon: widget.isCreation
                  ? const Icon(Icons.add_circle_outline_outlined)
                  : const Icon(Icons.check_circle_outline_outlined),
              ),

              // CANCEL BUTTON
              IconButton(
                onPressed: () {
                  context.go(widget.goBackPath);
                },
                icon: const Icon(Icons.cancel),
              ),

              if (!widget.isCreation)
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure you want to delete this entry?'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                _dbHandler.deleteEntry(entryDate: widget.entry!.date);
                                context.go('/');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.backspace_outlined),
                ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }


}