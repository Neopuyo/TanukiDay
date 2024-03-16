import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/widgets/entries_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // [!] use consumer ?
    final usermail = Provider.of<UserState>(context, listen: false).email;
    
    return BaseScaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      context.go('/entry-detail', extra: {'isCreation': true, 'entry': null});
                    }, 
                    icon: const Icon(Icons.add_outlined)),
                ],
              ),

              Expanded(
                child: EntriesList(usermail: usermail)
              ),

            ],
          ),
        )
    );
    
  }
}