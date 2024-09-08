import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';

String getName(WorkoutSectionModel section) {
  final name = StringBuffer();

  for (final organizer in section.organizers) {
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
  }

  return section.title;
}
