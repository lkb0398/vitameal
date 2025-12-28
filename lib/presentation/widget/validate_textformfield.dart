import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidateTextformfield extends StatelessWidget {
  const ValidateTextformfield({
    super.key,
    required this.readOnly,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.title,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    this.fixHeight,
    this.unit,
  });
  final bool readOnly;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String? title;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final bool? fixHeight;

  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? SizedBox.shrink()
            : Container(
                padding: EdgeInsets.only(top: 10),
                width: 70,
                child: Text(title!),
              ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 14, height: 1),
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              errorText: errorText,
              errorMaxLines: 1,
              // helperText: "",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            readOnly: readOnly,
            onTap: onTap,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onFieldSubmitted: (_) {},
          ),
        ),
        unit == null
            ? SizedBox.shrink()
            : Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                width: 30,
                child: Text(unit!),
              ),
      ],
    );
  }
}
