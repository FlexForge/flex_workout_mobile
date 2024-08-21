import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_section_model.freezed.dart';

@freezed
class WorkoutSectionModel with _$WorkoutSectionModel {
  const factory WorkoutSectionModel({
    required int id,
    required String title,
    @Default([]) List<SetOrganizerModel> organizers,
  }) = _WorkoutSectionModel;
}

extension WorkoutSectionHelpers on WorkoutSectionModel {
  String getName() {
    final name = StringBuffer();

    final organizer = organizers.first;

    if (organizer.defaultSet != null) {
      name.write(organizer.defaultSet!.exercise.name);
    } else {
      for (final set in organizer.superSet) {
        name.write(set.exercise.name);

        if (organizer.superSet.last != set) {
          name.write(' & ');
        } else {
          name.write(' (Superset)');
        }
      }
    }

    return name.toString();
  }
}

@freezed
class SetOrganizerModel with _$SetOrganizerModel {
  const factory SetOrganizerModel({
    required int id,
    SetTypeModel? defaultSet,
    @Default([]) List<SetTypeModel> superSet,
  }) = _SetOrganizerModel;
}

@freezed
class SetTypeModel with _$SetTypeModel {
  const factory SetTypeModel({
    required int id,
    required ExerciseModel exercise,
    NormalSetModel? normalSet,
  }) = _SetTypeModel;
}

@freezed
class NormalSetModel with _$NormalSetModel {
  const factory NormalSetModel({
    required int id,
  }) = _NormalSetModel;
}
