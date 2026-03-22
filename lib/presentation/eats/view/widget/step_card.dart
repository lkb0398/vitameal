import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/eats/view_model/step_view_model.dart';

/// 만보기
class StepCard extends ConsumerWidget {
  const StepCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final f = fxc(context);
    final vm = ref.watch(stepViewModelProvider);

    return Container(
      padding: const EdgeInsets.only(right: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PhosphorIcon(PhosphorIcons.sneakerMove(), color: f.textcolor300),
          Text(
            "  ${vm.steps} ${l.steps}  |  ${vm.calories.toStringAsFixed(0)} ${l.kcal}",
            style: TextStyle(
              color: f.textcolor300,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
