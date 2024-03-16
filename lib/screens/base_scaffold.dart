import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/widgets/miniWidgets/log_out_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.body, this.title = ''});

  final Widget body;
  final String title;
  
  @override
  Widget build(BuildContext context) {

    final state = Provider.of<UserState>(context, listen: false);
    final String bottomText = (state.logstate == LogState.notLogged)
      ? "Sign in to open your tanuki diary"
      : "What's up ${state.displayName} ?";
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title.isNotEmpty ? title : "Tanuki Day",
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
          )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tanuki_bkg.webp'), // Chemin de l'image
            fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [ 
          if (state.logstate != LogState.notLogged) const LogOutWidget()
        ],
      ),
      body: body,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          bottomText, 
          textAlign: TextAlign.center,
        ),
      )
    );

  }

  

}