import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0XFFD69031),
      backgroundColor: isDarkTheme ? const Color(0XFF17181A) : const Color(0XFFD3D3D3),
      indicatorColor: isDarkTheme ? const Color(0XFF2D2D2D) : const Color(0XFFE8EFF5),
      hintColor: isDarkTheme ? const Color(0XFFFFFFFF) : const Color(0XFF000000),
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
      cardColor: isDarkTheme ? const Color(0XFF2D2D2D) : const Color(0XFFE8EFF5),
      canvasColor: isDarkTheme ? Colors.black : const Color(0XFFffffff),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      primaryIconTheme: Theme.of(context).iconTheme.copyWith(color: const Color(0XFFD69031)),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: isDarkTheme ? const Color(0XFFD69031) : const Color(0XFFD69031)),
    );
  }
}
