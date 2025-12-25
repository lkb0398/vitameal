import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidateTextformfield extends StatelessWidget {
  const ValidateTextformfield({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  final String hintText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        helperText: "",
        helperMaxLines: 1,
        errorMaxLines: 1,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onFieldSubmitted: (_) {},
    );
  }
}
