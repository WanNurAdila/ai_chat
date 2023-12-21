import 'package:ai_chat/text_box/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextBox extends StatelessWidget {
  final String value;
  final String hintText;
  final String errorText;
  final TextEditingController? textController;
  final bool readOnly;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const ReusableTextBox({
    super.key,
    required this.value,
    required this.hintText,
    required this.readOnly,
    required this.errorText,
    required this.onChanged,
    this.hintStyle,
    this.textController,
    this.keyboardType,
    this.inputFormatter,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
      minLines: 1,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: inputFormatter ?? [],
      controller: TextEditingController()..text = value,
      onChanged: (value) => {
        onChanged(value),
      },
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: hintStyle,
        enabledBorder: Style().basicStyle,
        errorBorder: Style().basicStyle,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 5.0),
        ),
        focusedErrorBorder: Style().basicStyle,
        errorText: '',
        errorStyle: const TextStyle(
          color: Colors.transparent,
          fontSize: 0,
        ),
      ),
    );
  }
}
