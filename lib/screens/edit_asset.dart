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
    final newItem = ChartData(controllerNameField.text, double.tryParse(controllerValueField.text) ?? 0);

    widget.onSave(newItem);

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
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Text('Name', style: GoogleFonts.arimo(textStyle: theme.textTheme.labelMedium)),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: BoxConstraints(maxWidth: 350),
            child: TextField(
              controller: controllerNameField,
              decoration: InputDecoration(
                
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Text('Value', style: GoogleFonts.arimo(textStyle: theme.textTheme.labelMedium)),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20),
            constraints: BoxConstraints(maxWidth: 350, maxHeight: 40),
            child: TextField(
              controller: controllerValueField,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(20, 20, 20, 1),
                suffixText: '\$',
                suffixStyle: TextStyle(color: Colors.green, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: GoogleFonts.inter(textStyle: theme.textTheme.displayMedium),
              keyboardType: TextInputType.number, 
              cursorColor: Colors.white,
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

