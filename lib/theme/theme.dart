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
    titleLarge: TextStyle(fontSize: 32, color: Color.fromARGB(248, 248, 248, 255)),
    displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(248, 237, 237, 237)),
    displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color.fromARGB(248, 248, 248, 255)),
    displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: iconsTextFieldColor),
    headlineMedium: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: scaffoldColor),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: textFieldColor),
    labelMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color.fromARGB(248, 248, 248, 255)),

    // TextStyle? displayLarge,
    // TextStyle? displayMedium,
    // TextStyle? displaySmall,
    // TextStyle? headlineLarge,
    // TextStyle? headlineMedium,
    // TextStyle? headlineSmall,
    // TextStyle? titleLarge,
    // TextStyle? titleMedium,
    // TextStyle? titleSmall,
    // TextStyle? bodyLarge,
    // TextStyle? bodyMedium,
    // TextStyle? bodySmall,
    // TextStyle? labelLarge,
    // TextStyle? labelSmall,
  ),
);
