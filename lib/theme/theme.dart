import '../imports.dart';

const scaffoldColor = Color.fromRGBO(14, 14, 14, 1);
const mainOrangeColor = Color.fromARGB(255, 251, 164, 3);

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
    headlineMedium: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: scaffoldColor),
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
    // TextStyle? labelMedium,
    // TextStyle? labelSmall,
  ),
);
