import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/design/tanuki_theme.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/tools/database_handler.dart';
import 'package:diaryapp/widgets/miniWidgets/content_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeelingsList extends StatelessWidget {
  FeelingsList({super.key});

  final _dbHandler = DatabaseHandler();

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

    final usermail = Provider.of<UserState>(context, listen: false).email;

    return ContentCard(
      child: StreamBuilder<Map<String, int>>(
          stream: _dbHandler.getFeelingsStream(usermail), 
          builder: (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final Map<String, int> feelingsMap = snapshot.data ?? {};

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _feelingListMake(feelingsMap),
                );
              }      
          },
          

      ),
  
    );
  }

}