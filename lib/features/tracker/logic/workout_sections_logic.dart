import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';

class WorkoutHistoryTableCell {
  WorkoutHistoryTableCell(
    this.title,
    this.sets,
    this.bestSet, {
    this.superSetIndex,
  });

  final String title;
  final int sets;
  final String bestSet;
  final int? superSetIndex;
}

extension WorkoutSectionHelper on List<WorkoutSectionModel> {
  int _getNumberOfSets(
    List<SetOrganizerModel> organizers,
    ExerciseModel exercise,
  ) {
    return organizers
        .where(
          (organizer) => organizer.superSet
              .where((e) => e.exercise.id == exercise.id)
              .isNotEmpty,
        )
        .length;
  }

  List<WorkoutHistoryTableCell> toWorkoutHistoryTable() {
    final table = <WorkoutHistoryTableCell>[];
    var superSetIndex = 0;

    for (final section in this) {
      if (section.organizers.first.defaultSet != null) {
        final organizer = section.organizers.first;

        table.add(
          WorkoutHistoryTableCell(
            organizer.defaultSet!.exercise.name,
            section.organizers.length,
            '245 lbs x 5',
          ),
        );

        continue;
      }

      if (section.organizers.first.superSet.isNotEmpty) {
        for (final superSet in section.organizers.first.superSet) {
          table.add(
            WorkoutHistoryTableCell(
              superSet.exercise.name,
              _getNumberOfSets(section.organizers, superSet.exercise),
              '20 lbs x 10',
              superSetIndex: superSetIndex,
            ),
          );
        }

        superSetIndex++;
      }
    }

    return table;
  }
}
