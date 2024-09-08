import 'dart:math';

import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracked_workout_create_controller.g.dart';

Random _random = Random();

@riverpod
class TrackedWorkoutCreateController extends _$TrackedWorkoutCreateController {
  @override
  TrackedWorkoutModel? build() {
    return null;
  }

  void handle(int durationInMinutes) {
    // final title = form.model.title;
    // final subtitle = form.model.subtitle;
    // final notes = form.model.notes;
    // final startTimestamp = form.model.startTimestamp;
    // final sections = form.model.sections;

    // if (title == null || subtitle == null || startTimestamp == null) return;

    // /// Convert sections to [WorkoutSectionModel]
    // final sectionsModel = sections.map((e) {
    //   final organizers = e.organizers.map((organizer) {
    //     switch (organizer.organization) {
    //       case SetOrganizationEnum.defaultSet:
    //         final defaultSet = SetTypeModel(
    //           id: _random.nextInt(1 << 32),
    //           exercise: organizer.defaultSet!.exercise,
    //           type: organizer.defaultSet!.type,
    //         );

    //         return SetOrganizerModel(
    //           id: _random.nextInt(1 << 32),
    //           setNumber: organizer.setNumber,
    //           organization: organizer.organization,
    //           defaultSet: defaultSet,
    //         );
    //       case SetOrganizationEnum.superSet:
    //         return SetOrganizerModel(
    //           id: _random.nextInt(1 << 32),
    //           setNumber: organizer.setNumber,
    //           organization: organizer.organization,
    //           superSet: organizer.superSet
    //               .map(
    //                 (e) => SetTypeModel(
    //                   id: _random.nextInt(1 << 32),
    //                   exercise: e.exercise,
    //                   type: e.type,
    //                 ),
    //               )
    //               .toList(),
    //         );
    //     }
    //   }).toList();

    //   return WorkoutSectionModel(
    //     id: _random.nextInt(1 << 32),
    //     title: e.title,
    //     organizers: organizers,
    //   );
    // }).toList();

    // final res = ref.read(trackedWorkoutRepositoryProvider).createTrackedWorkout(
    //       title: title,
    //       subtitle: subtitle,
    //       notes: notes,
    //       durationInMinutes: durationInMinutes,
    //       startTimestamp: startTimestamp,
    //       sections: sectionsModel,
    //     );
    // state = res.fold((l) => throw l, (r) => r);
  }
}
