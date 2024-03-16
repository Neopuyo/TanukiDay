import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TanukiTheme {

  static const String _titleFontName = 'Zilla Slab';
  static const String _textFontName = 'Kalam';

  static ThemeData getTanukiTheme() {

    return ThemeData(
      
      // [1] textTheme
      textTheme: TextTheme(
        displayLarge: _titleFont(size: 26.0, color: TanukiColor.SECONDARY),
        displayMedium: _titleFont(size: 22.0, color: TanukiColor.SECONDARY),
        displaySmall: _titleFont(size: 16.0, color: TanukiColor.SECONDARY),
        titleLarge: _titleFont(size: 16.0, color: TanukiColor.PRIMARY),
        titleMedium: _titleFont(size: 14.0, color: TanukiColor.PRIMARY),
        titleSmall: _titleFont(size: 12.0, color: TanukiColor.PRIMARY),
        bodyLarge:_textFont(size: 16.0),
        bodyMedium: _textFont(size: 14.0),
        bodySmall: _textFont(size: 12.0),
      ),

      // [2] AppBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: TanukiColor.PRIMARY,
        systemOverlayStyle: null,
        toolbarTextStyle: TextStyle(
          color: TanukiColor.SECONDARY,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: _titleFontName,
        ),
        titleTextStyle: TextStyle(
          color: TanukiColor.SECONDARY,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: _titleFontName,
        ),
      ),

      // [3] Scaffolf
       scaffoldBackgroundColor: TanukiColor.BG_COLOR, // covered by image

      // [4] BottomNavigationBarThemeData
      bottomAppBarTheme: BottomAppBarTheme(
        color: TanukiColor.PRIMARY.withOpacity(0.20),
        elevation: 5.0,
        surfaceTintColor: TanukiColor.TEXT_COLOR,
        shadowColor: TanukiColor.SECONDARY,
      ),

      // [5] Icons
      iconTheme: const IconThemeData(
        color: TanukiColor.SECONDARY,
        size: 24.0,
      ),

      // [6] TabBarTheme
      tabBarTheme: TabBarTheme(
        dividerColor: TanukiColor.PRIMARY,
        dividerHeight: 0,
        labelColor: TanukiColor.ACCENT,
        unselectedLabelColor: TanukiColor.primarySwatch[700],
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: TanukiColor.primarySwatch[700]!.withOpacity(0.2),
          shape: BoxShape.circle,
          ),
        ),

      // [7] listTileTheme
      listTileTheme: ListTileThemeData(
        tileColor: TanukiColor.BG_COLOR.withOpacity(0.2),
        iconColor: TanukiColor.primarySwatch[700],
        textColor: TanukiColor.TEXT_COLOR,
        titleTextStyle: _titleFont(size: 18.0, color: TanukiColor.accentSwatch[700]),
        subtitleTextStyle: _textFont(size: 14.0),
        selectedColor: TanukiColor.ACCENT,
        selectedTileColor: TanukiColor.primarySwatch[700],
        visualDensity: VisualDensity.compact,
      ),

      // [8] TextField
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: TanukiColor.PRIMARY_WRITE_UP,
          fontSize: 16.0,
        ),
      ),

      // [9] PrimarySwatch - not used yet
      primarySwatch: TanukiColor.primarySwatch,
      focusColor: TanukiColor.ACCENT,

      // [10] textSelectionTheme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: TanukiColor.ACCENT,
        selectionColor: TanukiColor.ACCENT,
        selectionHandleColor: TanukiColor.ACCENT,
      ),

      // [11] ElevatedButtonTheme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(TanukiColor.PRIMARY),
          foregroundColor: MaterialStateProperty.all<Color>(TanukiColor.SECONDARY),
          textStyle: MaterialStateProperty.all<TextStyle>(_titleFont(size: 16.0)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),

      // [12] TextButtonTheme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(TanukiColor.PRIMARY),
          foregroundColor: MaterialStateProperty.all<Color>(TanukiColor.SECONDARY),
          textStyle: MaterialStateProperty.all<TextStyle>(_titleFont(size: 16.0)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<CircleBorder>(
            const CircleBorder(
            ),
          ),
        ),
      ),

      
    );

  }

  // [1] textTheme - Helpers
  static TextStyle _titleFont({double size = 20.0, color = TanukiColor.TEXT_COLOR}) {
    return GoogleFonts.getFont(
        _titleFontName,
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color
    );
  }

   static TextStyle _textFont({double size = 14.0, color = TanukiColor.TEXT_COLOR}) {
    return GoogleFonts.getFont(
        _textFontName,
        fontSize: size,
        color: color
    );
  }


  /* -------------  [+] Specific widget style  ------------- */
  static TextStyle textfieldInput() {
    return TextStyle(
      color: TanukiColor.primarySwatch[300],
      fontFamily: _textFontName,
      fontSize: 18,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle textfieldHint() {
    return const TextStyle(
      color: TanukiColor.PRIMARY_WRITE_UP_L1,
      fontFamily: _titleFontName,
      fontSize: 18,
    );
  }

  static TextStyle textfieldLabel() {
    return const TextStyle(
      color: TanukiColor.PRIMARY,
      fontFamily: _titleFontName,
      fontSize: 12,
    );
  }

  static TextStyle dateMonthInCard() {
    return const TextStyle(
      color: TanukiColor.TEXT_COLOR,
      fontFamily: _textFontName,
      fontSize: 9,
    );
  }

  static TextStyle dateDayInCard() {
    return const TextStyle(
      color: TanukiColor.PRIMARY,
      fontFamily: _titleFontName,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle appBarTitleTextStyle() {
    return const TextStyle(
      color: TanukiColor.SECONDARY,
      fontFamily: _textFontName,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

}