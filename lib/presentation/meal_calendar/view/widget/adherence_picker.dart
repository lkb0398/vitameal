import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class AdherencePicker extends StatelessWidget {
  /// 성취도 자가평가 선택
  const AdherencePicker({super.key, required this.selectedDay, required this.adherence, required this.onPick});

  final DateTime selectedDay;
  final Color? adherence;
  final void Function(Color c) onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("오늘 식단을 평가해주세요", style: TextStyle(fontSize: 14, color: vrc(context).text)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _AdherenceChip(
                  color: Colors.redAccent,
                  selected: adherence == Colors.redAccent,
                  onTap: () => onPick(Colors.redAccent),
                  label: "노력해요",
                  icon: PhosphorIcons.smileySad(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AdherenceChip(
                  color: Colors.orangeAccent,
                  selected: adherence == Colors.orangeAccent,
                  onTap: () => onPick(Colors.orangeAccent),
                  label: "괜찮아요",
                  icon: PhosphorIcons.smileyMeh(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AdherenceChip(
                  color: Color(0xFF89CC00),
                  selected: adherence == Color(0xFF89CC00),
                  onTap: () => onPick(Color(0xFF89CC00)),
                  label: "최고예요",
                  icon: PhosphorIcons.smiley(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
            shape: StadiumBorder(side: BorderSide(color: borderColor, width: 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color),
              ),
              const SizedBox(width: 6),
              Icon(icon, size: 18, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
