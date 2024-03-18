import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/widgets/miniWidgets/log_out_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.body, this.title = ''});

  final Widget body;
  final String title;

  IconButton _makeIconButton(BuildContext context, String buttonPath, String currentPath, IconData iconData) {
    return IconButton(
      onPressed: () {
        context.go(buttonPath);
      }, 
      icon: Icon(
        iconData,
        color: (buttonPath == currentPath)
          ? TanukiColor.PRIMARY
          : TanukiColor.PRIMARY.withOpacity(0.55),
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    final state = Provider.of<UserState>(context, listen: false);
    final String bottomText = (state.logstate == LogState.notLogged)
      ? "Sign in to open your tanuki diary"
      : "What's up ${state.displayName} ?";
    const String loginPath = "/";
    const String agendaPath = "/agenda";
    final String currentPath = GoRouter.of(context).routeInformationProvider.value.uri.path;

    
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _makeIconButton(context, loginPath, currentPath, Icons.account_circle_outlined),

            Text(
              bottomText, 
              textAlign: TextAlign.center,
            ),

            _makeIconButton(context, agendaPath, currentPath, Icons.calendar_today_outlined),
          ],
        ),
      )
    );

  }

  

}