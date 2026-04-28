import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/di/provider.dart';
import 'package:vitameal/domain/entity/allergies_entity.dart';
import 'package:vitameal/domain/entity/diseases_entity.dart';
import 'package:vitameal/presentation/language/view_model/locale_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/user_allergies_view_model.dart';
import 'package:vitameal/presentation/onboarding/viewmodel/user_diseases_view_model.dart';

part 'health_tag_view_model.g.dart';

enum HealthTagType { disease, allergy }

class HealthTag {
  const HealthTag({required this.name, required this.type});

  final String name;
  final HealthTagType type;
}

@Riverpod(keepAlive: true)
class HealthTagViewModel extends _$HealthTagViewModel {
  // State : 사용자 질병-알레르기 태그 목록 (Async)
  @override
  Future<List<HealthTag>> build() async {
    final locale = ref.watch(localeViewModelProvider); // 🌎
    final isKo = (locale?.languageCode ?? 'ko') == 'ko';

    // 질병-알레르기 병렬 처리
    final results = await Future.wait([_diseaseEntities(), _allergyEntities()]);
    final diseases = results[0] as List<DiseasesEntity>;
    final allergies = results[1] as List<AllergiesEntity>;

    return [
      ...diseases.map(
        (e) => HealthTag(
          name: isKo ? e.name : e.nameEn,
          type: HealthTagType.disease,
        ),
      ),
      ...allergies.map(
        (e) => HealthTag(
          name: isKo ? e.name : e.nameEn,
          type: HealthTagType.allergy,
        ),
      ),
    ];
  }

  // 사용자 질병 entity 목록
  Future<List<DiseasesEntity>> _diseaseEntities() async {
    // final userId = ref.read(userIdProvider);

    final repo = ref.read(diseasesRepositoryProvider);
    final ids = await ref.watch(userDiseasesViewModelProvider.future);
    final allDiseases = await repo.readAllDiseases();

    //  id > entity 매핑
    final map = {for (final d in allDiseases) d.id: d};
    return ids.map((id) => map[id]).whereType<DiseasesEntity>().toList();
  }

  // 사용자 알레르기 entity 목록
  Future<List<AllergiesEntity>> _allergyEntities() async {
    // final userId = ref.read(userIdProvider);

    final repo = ref.read(allergiesRepositoryProvider);
    final ids = await ref.watch(userAllergiesViewModelProvider.future);
    final allAllergies = await repo.readAllAllergies();

    //  id > entity 매핑
    final map = {for (final a in allAllergies) a.id: a};
    return ids.map((id) => map[id]).whereType<AllergiesEntity>().toList();
  }
}
