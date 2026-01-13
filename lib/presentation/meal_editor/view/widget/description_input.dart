import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class DescriptionInput extends StatelessWidget {
  /// 식단 내용 입력 칸
  const DescriptionInput({super.key, required this.controller, this.maxLength = 100});

  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "설명",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: vrc(context).text),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              maxLength: maxLength,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 26),
                hintText: "",
                counterText: "", // 스택으로 위에 표시할거임
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: vrc(context).border!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: vrc(context).border!),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 8,
              // 글자 수 카운터
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, _) {
                  return Text(
                    "${value.text.length}/$maxLength자",
                    style: TextStyle(
                      fontSize: 12,
                      color: vrc(context).hint,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
