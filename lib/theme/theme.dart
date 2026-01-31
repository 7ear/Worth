import '../imports.dart';

const scaffoldColor = Color.fromRGBO(14, 14, 14, 1);
const mainOrangeColor = Color.fromARGB(255, 251, 164, 3);
const textFieldColor = Color.fromARGB(248, 193, 193, 193);
const iconsTextFieldColor = Color.fromRGBO(80, 80, 80, 1);

final theme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: scaffoldColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: AppBarTheme(backgroundColor: scaffoldColor, elevation: 0),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 35, color: Color.fromRGBO(248, 248, 255, 1)),
    displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromRGBO(237, 237, 237, 1)),
    displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromRGBO(248, 248, 255, 1)),
    displaySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: iconsTextFieldColor),
    headlineMedium: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: scaffoldColor),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: const Color.fromRGBO(193, 193, 193, 1)),
    labelMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color.fromRGBO(248, 248, 255, 1)),
    labelSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromRGBO(58, 58, 58, 1)),
    headlineLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w600, color: Color.fromRGBO(248, 248, 255, 1))
    // TextStyle? displayLarge,
    // TextStyle? displayMedium,
    // TextStyle? displaySmall,
    // TextStyle? headlineLarge,
    // TextStyle? headlineMedium,
    // TextStyle? headlineSmall,
    
    // TextStyle? titleMedium,
    // TextStyle? titleSmall,
    // TextStyle? bodyLarge,
    // TextStyle? bodyMedium,
    // TextStyle? bodySmall,
    // TextStyle? labelLarge,
    // TextStyle? labelSmall,
  ),
);
