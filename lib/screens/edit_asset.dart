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
          CustomTextField(controller: controllerNameField, isItValueField: false, isItTextInputTypeNumber: false, hint: "Type something..."),
          Container(
            margin: EdgeInsets.only(top: 35, left: 20),
            child: Text('Value', style: GoogleFonts.arimo(textStyle: theme.textTheme.labelMedium)),
          ),
          CustomTextField(controller: controllerValueField, isItValueField: true, isItTextInputTypeNumber: true, hint: "Type something..."),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15 + MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color.fromRGBO(162, 33, 33, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    ),
                    onPressed: () => editItem(),
                    child: Text('Delete', style: GoogleFonts.roboto(textStyle: theme.textTheme.headlineLarge)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color.fromARGB(248, 237, 237, 237),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    ),
                    onPressed: () => editItem(),
                    child: Text('Edit', style: GoogleFonts.roboto(textStyle: theme.textTheme.headlineMedium)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

