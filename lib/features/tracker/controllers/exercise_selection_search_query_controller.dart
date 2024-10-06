import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_selection_search_query_controller.g.dart';

@riverpod
class ExerciseSelectionSearchQueryController
    extends _$ExerciseSelectionSearchQueryController {
  @override
  String build() {
    return '';
  }

  void handle(String value) {
    state = value.trim();
  }
}
