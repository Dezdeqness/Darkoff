import 'package:darkoff/presentation/features/more/composer/more_menu_composer.dart';
import 'package:darkoff/presentation/features/more/model/more_menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'more_menu_notifier.g.dart';

@riverpod
class MoreMenu extends _$MoreMenu {
  @override
  List<MoreSectionData> build() => const MoreMenuComposer().compose();
}
