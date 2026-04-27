import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/eats/view_model/eats_view_model.dart';
import 'package:vitameal/presentation/eats/view_model/step_view_model.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';

/// 위치 권한 없을 때 유도 화면
class NoPermissionView extends ConsumerWidget {
  const NoPermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final v = vrc(context);
    final f = fxc(context);

    final eatsVM = ref.read(eatsViewModelProvider.notifier);
    final stepVM = ref.read(stepViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Icon(Icons.location_off, size: 100, color: v.border),
            const SizedBox(height: 16),
            Text(
              l.need_location_perm,
              style: TextStyle(
                fontSize: 20,
                color: v.border,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.request_location_perm,
              style: TextStyle(color: v.border, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            AddButton(
              borderColor: f.primary400!,
              textColor: f.primary400!,
              text: l.allow_perm,
              onTap: () async {
                // [권한 요청 및 초기화]
                await eatsVM.init();
                await stepVM.init();

                // [위치 권한 여부 확인]
                final permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.always ||
                    permission == LocationPermission.whileInUse) {
                  return;
                } else {
                  Geolocator.openAppSettings(); // 설정으로 이동
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
