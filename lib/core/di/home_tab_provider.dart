import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_provider.g.dart';

@riverpod
class HomeTab extends _$HomeTab {
  @override
  int build() => 0;
  void change(int index) => state = index;
}
