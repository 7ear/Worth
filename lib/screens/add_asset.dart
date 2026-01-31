import '../imports.dart';

class AddAsset extends StatefulWidget {
  const AddAsset({super.key});

  @override
  State<AddAsset> createState() => _AddAssetState();
}

class _AddAssetState extends State<AddAsset> {
  void addItem() {
    final name = controllerNameField.text;
    final value = double.tryParse(controllerValueField.text) ?? 0;

    if (name.isNotEmpty) {
      final newItem = ChartData(name, value);
      DataManager.addItem(newItem);
      Navigator.pop(context);
    }
  }

  final TextEditingController controllerNameField = TextEditingController();
  final TextEditingController controllerValueField = TextEditingController();

  @override
  void dispose() {
    controllerNameField.dispose();
    controllerValueField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Asset')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Text('Name', style: GoogleFonts.arimo(textStyle: theme.textTheme.labelMedium)),
          ),
          CustomTextField(controller: controllerNameField, isItValueField: false, isItTextInputTypeNumber: false, hint: "Type something..."),
          Container(
            margin: EdgeInsets.only(top: 35, left: 20),
            child: Text('Value', style: GoogleFonts.arimo(textStyle: theme.textTheme.labelMedium)),
          ),
          CustomTextField(controller: controllerValueField, isItValueField: true, isItTextInputTypeNumber: true, hint: "Type something..."),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 15 + MediaQuery.of(context).padding.bottom),
            child: AddButton(),
          ),
        ],
      ),
    );
  }
}
