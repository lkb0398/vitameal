import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class ValidateTextformfield extends HookConsumerWidget {
  const ValidateTextformfield({
    super.key,
    required this.readOnly,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.label,
    this.title,
    this.unit,
  });
  final bool readOnly;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  final void Function()? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? helperText;
  final String? label; // 상단 텍스트
  final String? title; // 좌측 텍스트
  final String? unit; // 우측 텍스트

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isValid = useState<bool?>(null);
    useEffect(() {
      void listener() {
        if (validator == null) return;
        isValid.value = validator!(controller.text) == null;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller, errorText]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 10),
                child: Text(
                  label!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? SizedBox.shrink()
                : Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 50,
                    child: Text(title!, style: TextStyle(fontSize: 12)),
                  ),
            Expanded(
              child: TextFormField(
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  hintText: hintText,
                  hintStyle: TextStyle(color: vrc(context).border),
                  errorText: errorText,
                  errorStyle: TextStyle(
                    fontSize: 11,
                    color: fxc(context).secondary400!,
                  ),
                  errorMaxLines: 1,
                  helperText: helperText,
                  helperStyle: TextStyle(
                    fontSize: 11,
                    color: fxc(context).textcolor200!,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: vrc(context).border!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: fxc(context).primary400!),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: fxc(context).secondary400!),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: fxc(context).secondary400!),
                  ),
                  suffixIcon: isValid.value == null
                      ? null
                      : (errorText != null || isValid.value == false)
                      ? Icon(
                          Icons.clear,
                          size: 16,
                          color: fxc(context).secondary400,
                        )
                      : Icon(
                          Icons.check,
                          size: 16,
                          color: fxc(context).primary400,
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
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    width: 40,
                    child: Text(unit!, style: TextStyle(fontSize: 14)),
                  ),
          ],
        ),
      ],
    );
  }
}
