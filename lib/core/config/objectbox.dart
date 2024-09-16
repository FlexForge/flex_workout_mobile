import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/db/seed/test_workout.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const devMode = true;

class ObjectBox {
  ObjectBox._create(this.store) {
    if (devMode) {
      _resetData();
    } else if (isFirstLoadListener.value) {
      _putInitialPostData();
    }
  }

  /// The Store of this app.
  late final Store store;

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(
        docsDir.path,
        'obx-template',
      ),
    );
    return ObjectBox._create(store);
  }

  void _putInitialPostData() {
    store.box<ExerciseEntity>().putManyAsync(masterExercises);
  }

  void _resetData() {
    store.box<ExerciseEntity>().removeAll();
    store.box<MuscleGroup>().removeAll();
    store.box<TrackedWorkoutEntity>().removeAll();
    store.box<MuscleGroup>().putMany(muscleGroups);
    store.box<TrackedWorkoutEntity>().put(exampleWorkout);
    store.box<ExerciseEntity>().putManyAsync(masterExercises);
  }
}
