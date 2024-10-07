import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_search_query_controller.g.dart';

@riverpod
class ExerciseSearchQueryController extends _$ExerciseSearchQueryController {
  @override
  String build() {
    return '';
  }

  void handle(String value) {
    state = value.trim();
  }
}
