import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.confirmColor,
    this.reverseButtons = false,
  });

  final String title;
  final String? content;
  final String confirmText;
  final String cancelText;
  final void Function() onConfirm;
  final Color? confirmColor;
  final bool reverseButtons;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 300,
        padding: const EdgeInsets.fromLTRB(24, 34, 24, 34),
        decoration: BoxDecoration(
          color: vrc(context).background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: vrc(context).emptyText!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 25,
          children: [
            Column(
              children: [
                // 제목
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                // 내용
                if (content != null) ...[
                  const SizedBox(height: 12),
                  Text(content!, style: TextStyle(fontSize: 13, height: 1.5)),
                ],
              ],
            ),

            /// 버튼 영역
            Row(
              spacing: 12,
              children: [
                /// 취소 버튼
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: reverseButtons
                          ? confirmColor ?? fxc(context).secondary400
                          : Colors.transparent,
                      side: reverseButtons
                          ? BorderSide.none
                          : BorderSide(color: vrc(context).border!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: AutoSizeText(
                      cancelText,
                      style: TextStyle(
                        // fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: reverseButtons
                            ? Colors.white
                            : vrc(context).text,
                      ),
                    ),
                  ),
                ),

                /// 완료 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: reverseButtons
                          ? Colors.transparent
                          : confirmColor ?? fxc(context).secondary400,
                      side: reverseButtons
                          ? BorderSide(color: vrc(context).border!)
                          : BorderSide.none,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: AutoSizeText(
                      confirmText,
                      style: TextStyle(
                        // fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: reverseButtons
                            ? vrc(context).text
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
