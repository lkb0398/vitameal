import 'package:flutter/material.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/presentation/meal_calendar/view/util/link_launcher.dart';

class InfoLink extends StatelessWidget {
  /// 출처 및 건강 정보 안내
  const InfoLink({super.key});

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!;

    return Row(
      children: [
        const Icon(Icons.info_outline, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        TextButton(
          onPressed: LinkLauncher.openNotion,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l.source_info,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
