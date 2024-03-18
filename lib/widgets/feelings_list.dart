import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/design/tanuki_theme.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/widgets/miniWidgets/content_card_widget.dart';
import 'package:flutter/material.dart';


class FeelingsList extends StatelessWidget {
  const FeelingsList({super.key, required this.feelingsMap});

  final Map<String, int> feelingsMap;

  Icon _feelingIconMake(String feeling) {
    return Icon(
      Entry.getIconDataFromString(feeling: feeling), 
      color: TanukiColor.getColorFromStringFeeling(feeling: feeling), 
      size: 30,
    );
  }

  Widget _feelingTileMake(String iconName, int count, int total) {
    final int percent = total == 0 ? 0 : ((count / total) * 100).toInt(); 
    final Icon icon = _feelingIconMake(iconName);

    return Column(
      children: [
        icon,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$count",
              style: TanukiTheme.dateDayInCard(),
            ),
            Text(
              "/ $total",
              style: TanukiTheme.dateMonthInCard(),
              ),
          ],
        ),
        Text(
          "$percent %",
          style: TanukiTheme.dateMonthInCard(),
        ),        
      ],
    );

  }

  List<Widget> _feelingListMake(Map<String, int> feelingsMap) {
     final List<Widget> tiles = [];
     final int total = feelingsMap.values.reduce((value, element) => value + element);

     for (var item in feelingsMap.entries) {
       tiles.add(_feelingTileMake(item.key, item.value, total));
     }
     return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _feelingListMake(feelingsMap),
        ),
    );
  }

}