import '../imports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? focusedBorderColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText = '',
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.autofocus = false,
    this.focusNode,
    this.borderColor,
    this.focusedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = borderColor ?? const Color.fromRGBO(45, 45, 45, 1);
    final defaultFocusedBorderColor = focusedBorderColor ?? 
        const Color.fromRGBO(70, 130, 230, 1); // Яркий синий для фокуса

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 4),
              child: Text(
                labelText!,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            maxLines: maxLines,
            autofocus: autofocus,
            focusNode: focusNode,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: defaultFocusedBorderColor,
            cursorWidth: 2.0,
            cursorHeight: 20.0,
            cursorRadius: const Radius.circular(1),
            decoration: InputDecoration(
              // Основные параметры
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              
              // Иконки
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.grey[500],
                          size: 22,
                        ),
                        child: prefixIcon!,
                      ),
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16, left: 12),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.grey[500],
                          size: 22,
                        ),
                        child: suffixIcon!,
                      ),
                    )
                  : null,
              
              // Цвет фона
              filled: true,
              fillColor: const Color.fromRGBO(20, 20, 20, 1),
              
              // Отступы
              contentPadding: EdgeInsets.only(
                top: maxLines! > 1 ? 20 : 18,
                bottom: maxLines! > 1 ? 20 : 18,
                left: prefixIcon != null ? 0 : 16,
                right: suffixIcon != null ? 0 : 16,
              ),
              
              // Плотность
              isDense: true,
              
              // Границы
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              
              // Обычное состояние
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: defaultBorderColor,
                  width: 1.5,
                ),
              ),
              
              // Состояние фокуса (с анимацией)
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: defaultFocusedBorderColor,
                  width: 2.0,
                ),
              ),
              
              // Состояние ошибки
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              
              // Состояние ошибки с фокусом
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              
              // Состояние отключенного поля
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey[800]!,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}