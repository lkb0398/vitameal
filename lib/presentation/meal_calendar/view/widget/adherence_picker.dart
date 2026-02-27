import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class AdherencePicker extends StatelessWidget {
  /// 성취도 자가평가 선택
  const AdherencePicker({
    super.key,
    required this.selectedDay,
    required this.adherence,
    required this.onPick,
  });

  final DateTime selectedDay;
  final Color? adherence;
  final void Function(Color c) onPick;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 2),
              Text(
                l.rate_today_meal,
                style: TextStyle(fontSize: 13.5, color: vrc(context).content),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _AdherenceChip(
                  color: Colors.redAccent,
                  selected: adherence == Colors.redAccent,
                  onTap: () => onPick(Colors.redAccent),
                  label: l.fine,
                  icon: PhosphorIcons.smileySad(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AdherenceChip(
                  color: Colors.orangeAccent,
                  selected: adherence == Colors.orangeAccent,
                  onTap: () => onPick(Colors.orangeAccent),
                  label: l.good,
                  icon: PhosphorIcons.smileyMeh(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AdherenceChip(
                  color: Color(0xFF89CC00),
                  selected: adherence == Color(0xFF89CC00),
                  onTap: () => onPick(Color(0xFF89CC00)),
                  label: l.great,
                  icon: PhosphorIcons.smiley(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdherenceChip extends StatelessWidget {
  const _AdherenceChip({
    required this.color,
    required this.selected,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final bg = color.withOpacity(0.12);

    // 선택 상태 강조
    final borderColor = selected ? color.withOpacity(0.55) : Colors.transparent;

    return Material(
      color: Colors.transparent,
      // 알약 모양
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),

        // 클릭 효과 제거
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,

        // 매끄럽게 선택되도록 애니메이션
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: ShapeDecoration(
            color: bg,
            shape: StadiumBorder(
              side: BorderSide(color: borderColor, width: 2),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(icon, size: 18, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
