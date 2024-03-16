import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/design/tanuki_theme.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EntryListTile extends StatelessWidget {
  final Entry entry;
  final void Function() onDelete;
  final void Function() onTap;


  const EntryListTile({super.key, required this.entry, required this.onDelete, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final feelingColor = TanukiColor.getColorFromStringFeeling(feeling: entry.feeling);
    final month = DateFormat('MMMM', 'en_US').format(entry.date);
    final day = DateFormat('d', 'en_US').format(entry.date);

    return Card.outlined(
       shape: RoundedRectangleBorder(
    side:  const BorderSide(
      color: TanukiColor.PRIMARY, // Couleur de la bordure
      width: 3, // Épaisseur de la bordure
    ),
    borderRadius: BorderRadius.circular(16.0), // Rayon de la bordure
  ),
      color: TanukiColor.BODY_COLOR,
      child: ListTile(
        title: Text(
          entry.title,
          style: const TextStyle(
            color: TanukiColor.PRIMARY,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          entry.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(month,
                style: TanukiTheme.dateMonthInCard(),
            ),
            Text(day,
                style: TanukiTheme.dateDayInCard(),
            ),
          ],
        ),
        trailing: Icon(
          Entry.getIconDataFromString(feeling: entry.feeling),
          color: feelingColor,
          size: 28.0
        ),

        onTap: () => onTap(),
      ),
    );
  }
}