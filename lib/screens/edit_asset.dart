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

  bool isTextFieldFocused = false;
  final FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(() {
      setState(() {
        isTextFieldFocused = textFieldFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    controllerNameField.dispose();
    controllerValueField.dispose();
    textFieldFocusNode.dispose();
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
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            constraints: BoxConstraints(maxHeight: 40),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: isTextFieldFocused
                    ? [
                        BoxShadow(
                          color: Color.fromRGBO(55, 55, 55, 0.6),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ]
                    : [],
              ),
              child: TextField(
                focusNode: textFieldFocusNode,
                controller: controllerValueField,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(20, 20, 20, 1),
                  isDense: true,
                  suffixText: '\$',
                  suffixStyle: GoogleFonts.arimo(textStyle: theme.textTheme.displaySmall),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(55, 55, 55, 1),
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      width: 1.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13.0,
                    horizontal: 12.0,
                  ),
                ),
                style: GoogleFonts.arimo(textStyle: theme.textTheme.headlineSmall),
                keyboardType: TextInputType.number,
                cursorWidth: 2,
                cursorRadius: Radius.circular(10),
                cursorColor: textFieldColor,
              ),
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

