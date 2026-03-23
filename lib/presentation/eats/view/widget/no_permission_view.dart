import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/eats/view_model/eats_view_model.dart';
import 'package:vitameal/presentation/widget/button/add_button.dart';

/// 위치 권한 없을 때 유도 화면
class NoPermissionView extends ConsumerWidget {
  const NoPermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final v = vrc(context);
    final f = fxc(context);
    final vm = ref.read(eatsViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            Icon(Icons.location_off, size: 100, color: v.border),
            const SizedBox(height: 16),
            Text(
              "${l.need_permission} :(",
              style: TextStyle(
                fontSize: 20,
                color: v.border,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.request_permission,
              style: TextStyle(color: v.border, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            AddButton(
              borderColor: f.primary400!,
              textColor: f.primary400!,
              text: l.allow_access,
              onTap: () async {
                final permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  await vm.init(); // 최초 or 재요청 가능 상태 > 권한 요청 팝업
                } else {
                  await Geolocator.openAppSettings(); // 이미 거절된 상태 > 설정으로 이동
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
