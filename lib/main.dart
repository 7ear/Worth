import 'imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DataManager.init();
  runApp(const Worth());
}

class Worth extends StatelessWidget {
  const Worth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worth',
      theme: theme,
      home: HomePage(),
    );
  }
}