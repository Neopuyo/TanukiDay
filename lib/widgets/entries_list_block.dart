import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/widgets/entries_list.dart';
import 'package:diaryapp/widgets/miniWidgets/header_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntriesListBlock extends StatefulWidget {
  const EntriesListBlock({super.key, required this.entries});

  final List<Entry> entries;

  @override
  State<StatefulWidget> createState() {
    return _EntriesListBlockState();
  }
}

class _EntriesListBlockState extends State<EntriesListBlock> {
  bool _displayAll = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // [1] ENTRY LIST HEADER
          HeaderCard(
            children: [
                 Row(
                    children: [
                      Text(
                        _displayAll ? "All entries" : "Last entries",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _displayAll = !_displayAll;
                            });
                          },
                          icon: Icon(_displayAll
                              ? Icons.expand_more_outlined
                              : Icons.expand_less_outlined)),
                    ],
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.go('/entry-detail',
                          extra: {'isCreation': true, 'entry': null});
                    },
                    icon: const Icon(Icons.add_outlined)),
              ],
           
          ),

          // [2] ENTRY LIST
          Expanded(
            child: EntriesList(
              entries: widget.entries,
              displayLimit: _displayAll ? 365 : 2,
            )
          ),
        ],
      ),
    );
  }
}
