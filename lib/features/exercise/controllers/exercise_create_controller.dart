import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'exercise_create_controller.g.dart';

@riverpod
class ExerciseCreateController extends _$ExerciseCreateController {
  @override
  ExerciseModel? build() {
    return null;
  }

  void handle(ExerciseForm form) {
    final generalModel = form.model.general;
    final advancedModel = form.model.advanced;
    final muscleGroupsModel = form.model.muscleGroups;

    final name = generalModel?.name;
    final description = generalModel?.description;
    final youtubeVideoId =
        YoutubePlayer.convertUrlToId(generalModel?.videoUrl ?? '');
    final baseExercise = generalModel?.baseExercise;

    final movementPattern = advancedModel?.movementPattern;
    final engagement = advancedModel?.engagement;
    final equipment = advancedModel?.equipment;

    final primaryMuscleGroups = muscleGroupsModel?.primaryMuscleGroups;
    final secondaryMuscleGroups = muscleGroupsModel?.secondaryMuscleGroups;

    if (name == null) return;

    final res = ref.read(exerciseRepositoryProvider).createExercise(
          name: name,
          description: description,
          youtubeVideoId: youtubeVideoId,
          engagement: engagement,
          equipment: equipment,
          baseExercise: baseExercise,
          movementPattern: movementPattern,
          primaryMuscleGroups: primaryMuscleGroups ?? [],
          secondaryMuscleGroups: secondaryMuscleGroups ?? [],
        );

    state = res.fold((l) => throw l, (r) => r);
  }
}
