import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/eats/view_model/eats_view_model.dart';
import 'package:vitameal/presentation/eats/view_model/step_view_model.dart';

class CustomBottomNav extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎

    final eatsVM = ref.read(eatsViewModelProvider.notifier);
    final stepVM = ref.read(stepViewModelProvider.notifier);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 10),
        decoration: BoxDecoration(
          color: vrc(context).background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: vrc(context).bottomNavShadow!,
              blurRadius: 5,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: PhosphorIcons.bowlFood(),
              label: l.my_diet,
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: PhosphorIcons.forkKnife(),
              label: l.recipe_feed,
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: PhosphorIcons.mapPinArea(),
              label: l.eats,
              isSelected: currentIndex == 2,
              onTap: () async {
                onTap(2);
                // [권한 요청 및 초기화]
                await eatsVM.init();
                await stepVM.init();
              },
            ),
            _NavItem(
              icon: PhosphorIcons.user(),
              label: l.my_info,
              isSelected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? vrc(context).selectedItem
        : fxc(context).textcolor300!;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w500 : null,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
