import 'package:diaryapp/design/tanuki_theme.dart';
import 'package:diaryapp/models/entry.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/entry_form.dart';
import 'package:diaryapp/screens/login_screen.dart';
import 'package:diaryapp/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      
  );
  runApp(ChangeNotifierProvider(
    create:(context) => UserState(),
    builder:(context, child) => const MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // ROUTER
  GoRouter _makeRouter({required BuildContext context}) {

    final logstate = Provider.of<UserState>(context).logstate;

    late final GoRouter router = GoRouter(
      routes: <GoRoute>[
        
        GoRoute(
          path: '/',
          builder: (context, state) {
            return StartScreen();
          },
        ),

        GoRoute(
          path: '/login',
          builder: (context, state) {
            return const GoogleSignInScreen();
          },
        ),

        GoRoute(
          path: '/entry-detail',
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>?;
            final bool? isCreation = params?['isCreation'] as bool?;
            final Entry? entry = params?['entry'] as Entry?;
            return EntryForm(isCreation: isCreation ?? false, entry: entry);
          },
        ),

      ],

      // redirect to the login page if the user is not logged in
      redirect: (context, state) {
        final bool loggedIn = (logstate != LogState.notLogged);
        final bool loggingIn = state.matchedLocation == '/login';

        if (!loggedIn) {
          return '/login';
        } else if (loggingIn) { // user is logged in but still at login page
          return '/'; 
        } else {
          return null; // no need to redirect at all
        }
      },

      refreshListenable: Provider.of<UserState>(context),
    );

    return router;
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // home: StartScreen(),
      title: 'Tanuki Day',
      routerConfig: _makeRouter(context: context),
      theme: TanukiTheme.getTanukiTheme(),
    );
  }
}