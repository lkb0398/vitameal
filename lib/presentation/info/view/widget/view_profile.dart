import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';

class ViewProfile extends HookConsumerWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profilesViewModelProvider);

    // 기본 프로필 이미지
    final Image defaultImg = Image.asset(
      'assets/images/profile_image_s.webp',
      height: 48,
      width: 48,
    );

    // preload
    useEffect(() {
      ref.read(profilesViewModelProvider.future);
      return null;
    }, []);

    return profileAsync.when(
      loading: () => Row(spacing: 14, children: [defaultImg, const Text("")]),
      error: (_, __) =>
          Row(spacing: 14, children: [defaultImg, const Text("")]),
      data: (profile) {
        return InkWell(
          onTap: () => context.push(AppRoutePath.profile, extra: true),
          child: Row(
            spacing: 14,
            children: [
              profile!.photoUrl == null
                  ? defaultImg
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        height: 48,
                        width: 48,
                        imageUrl: profile.photoUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
              Text(
                "${profile.nickname}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
