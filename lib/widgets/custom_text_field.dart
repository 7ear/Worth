import '../imports.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.isItValueField,
    required this.isItTextInputTypeNumber,
    required this.hint,
    this.onChanged,
  });

  final TextEditingController controller;
  final bool isItValueField;
  final bool isItTextInputTypeNumber;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      constraints: const BoxConstraints(maxHeight: 40),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: const Color.fromRGBO(55, 55, 55, 0.6),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          style: GoogleFonts.arimo(textStyle: theme.textTheme.headlineSmall),
          keyboardType: widget.isItTextInputTypeNumber
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          cursorWidth: 2,
          cursorRadius: const Radius.circular(10),
          cursorColor: textFieldColor,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(20, 20, 20, 1),
            isDense: true,
            suffixText: widget.isItValueField ? '\$' : null,
            suffixIcon: widget.isItValueField
                ? null
                : Icon(
                    Icons.local_offer_outlined,
                    color: iconsTextFieldColor,
                    size: 21,
                  ),
            suffixStyle: GoogleFonts.arimo(textStyle: theme.textTheme.displaySmall),
            hintText: widget.hint,
            hintStyle: GoogleFonts.inter(textStyle: theme.textTheme.labelSmall),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(45, 45, 45, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(55, 55, 55, 1),
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
              horizontal: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}