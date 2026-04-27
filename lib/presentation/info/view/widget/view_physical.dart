import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/config/routes.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/presentation/info/view/util/bold_rich_text.dart';
import 'package:vitameal/presentation/info/view/widget/bordered_container.dart';
import 'package:vitameal/presentation/info/view_model/health_tag_view_model.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/profiles_view_model.dart';
import 'package:vitameal/presentation/util/remove_decimals.dart';

class ViewPhysical extends ConsumerWidget {
  const ViewPhysical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context)!; // 🌎
    final locale =
        ref.watch(localeViewModelProvider) ?? Localizations.localeOf(context);

    final profileAsync = ref.watch(profilesViewModelProvider);
    final healthTagsAsync = ref.watch(healthTagViewModelProvider);

    return profileAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => Text(l.failed_loading_info),
      data: (profile) {
        if (profile == null) {
          return const Text("");
        }

        final gender = profile.gender(locale);
        final age = profile.age;
        final height = profile.heightCm;
        final weight = profile.weightKg;

        return BorderedContainer(
          title: l.my_info,
          onTap: () => context.push(AppRoutePath.editPhysical, extra: profile),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              /// 기본 정보
              Row(
                spacing: 20,
                children: [
                  if (gender != null) boldRichText(gender),
                  if (age != null) boldRichText('{$age}세'),
                  if (height != null)
                    boldRichText('{${removeDecimals(height)}}cm'),
                  if (weight != null)
                    boldRichText('{${removeDecimals(weight)}}kg'),
                ],
              ),

              /// 질환 + 알레르기 태그
              healthTagsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => Text(l.failed_loading_info),
                data: (tags) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) {
                      return _tagChip(
                        context: context,
                        label: tag.name,
                        type: tag.type,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tagChip({
    required BuildContext context,
    required String label,
    required HealthTagType type,
  }) {
    final colors = _tagToColors(context, type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colors.$2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.$1,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // (텍스트색, 배경색)
  (Color, Color) _tagToColors(BuildContext context, HealthTagType type) {
    final f = fxc(context);

    switch (type) {
      case HealthTagType.disease:
        return (f.secondary400!, f.secondary100!);
      case HealthTagType.allergy:
        return (f.yellowText!, f.yellowTag!);
    }
  }
}
