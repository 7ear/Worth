import '../imports.dart';

class EditAsset extends StatefulWidget {
  const EditAsset({super.key, required this.index, required this.item, required this.onSave, required this.onDelete});

  final int index;
  final ChartData item;
  final Function(ChartData) onSave;
  final VoidCallback onDelete;

  @override
  State<EditAsset> createState() => _EditAssetState();
}

final storage = GetStorage();

class _EditAssetState extends State<EditAsset> {
  void editItem() {
    final newItem = ChartData(
      controllerNameField.text,
      double.tryParse(controllerValueField.text) ?? 0
    );

    widget.onSave(newItem);
    
    // DataManager.dataNotifier.value = List<ChartData>.from(DataManager.dataNotifier.value); 
    // DataManager.updateItem(widget.index, newItem);

    Navigator.pop(context);
  }

  void deleteItem() {
    widget.onDelete();
    Navigator.pop(context);
  }

  late final TextEditingController controllerNameField = TextEditingController(text: widget.item.category.toString());
  late final TextEditingController controllerValueField = TextEditingController(text: widget.item.value.toString());

  @override
  void dispose() {
    controllerNameField.dispose();
    controllerValueField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Asset')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: EdgeInsets.only(top: 50, left: 20), child: Text('Name')),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: const BoxConstraints(maxWidth: 350),
            child: TextField(
              controller: controllerNameField,
              decoration: const InputDecoration(hintText: 'Type something...', border: OutlineInputBorder()),
            ),
          ),
          Container(margin: EdgeInsets.only(top: 50, left: 20), child: Text('Value')),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: const BoxConstraints(maxWidth: 350),
            child: TextField(
              controller: controllerValueField,
              decoration: const InputDecoration(hintText: 'Type something...', border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => editItem(), child: Text('Edit')),
                ElevatedButton(onPressed: () => deleteItem(), child: Text('Delete')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
