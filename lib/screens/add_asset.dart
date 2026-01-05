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
          Container(margin: EdgeInsets.only(top: 50, left: 20), child: Text('Name')),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: BoxConstraints(maxWidth: 350),
            child: TextField(
              controller: controllerNameField,
              decoration: InputDecoration(hintText: 'Type something...', border: OutlineInputBorder()),
            ),
          ),
          Container(margin: EdgeInsets.only(top: 50, left: 20), child: Text('Value')),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: const BoxConstraints(maxWidth: 350),
            child: TextField(
              controller: controllerValueField,
              decoration: InputDecoration(hintText: 'Type something...', border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            child: ElevatedButton(onPressed: addItem, child: Text('Add')),
          ),
        ],
      ),
    );
  }
}
