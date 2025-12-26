import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitameal/core/config/routes.dart';

part 'router_location_provider.g.dart';

/// 현재 Location 얻기 Provider
@riverpod
String routerLocation(Ref ref) {
  final router = ref.watch(routerProvider);

  final configuration = router.routerDelegate.currentConfiguration;

  if (configuration.routes.isEmpty) {
    return '/';
  }

  return configuration.last.matchedLocation;
}
