// ignore_for_file: lines_longer_than_80_chars, avoid_redundant_argument_values

import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';

final barbellBenchPress = Exercise(
  name: 'Bench Press (Barbell)',
  description:
      'Lie supine on bench. Graph bar with overhand and slightly wider than shoulder width grip. Arch back, extend hips, and position feet back flat on floor. Dismount barbell from rack over chest.\n\nLower weight to lower chest. Press bar upwards until arms are extended. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([chest])
  ..secondaryMuscleGroups.addAll([frontDelts, triceps]);

final dumbbellPullover = Exercise(
  name: 'Pullover (Dumbbell)',
  description:
      'Lie supine on bench. Hold dumbbell over chest with both hands. Lower dumbbell over and beyond head. Pull dumbbell back over chest. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.pullOver,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([lats])
  ..secondaryMuscleGroups.addAll([chest, rearDelts, midBack, triceps]);

final barbellAdPress = Exercise(
  name: 'AD Press (Barbell)',
  description:
      'Sit on bench. Hold barbell with overhand grip. Press barbell overhead. Repeat.',
  equipment: Equipment.barbell,
  engagement: Engagement.bilateral,
  movementPattern: MovementPattern.verticalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([frontDelts])
  ..secondaryMuscleGroups.addAll([triceps, chest]);

final cableCrunch = Exercise(
  name: 'Cable Crunch',
  description:
      'Kneel in front of cable machine. Hold rope attachment overhead. Crunch down and forward. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.cable,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([abs])
  ..secondaryMuscleGroups.addAll([]);

final dumbbellBenchPress = Exercise(
  name: 'Bench Press (Dumbbell)',
  description:
      'Lie supine on bench. Hold dumbbells over chest. Press dumbbells upwards until arms are extended. Repeat.',
  engagement: Engagement.bilateralSeparate,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.horizontalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([chest])
  ..secondaryMuscleGroups.addAll([frontDelts, triceps]);

final cableTricepExtension = Exercise(
  name: 'Tricep Extension (Cable)',
  engagement: Engagement.bilateral,
  description:
      'Stand in front of cable machine. Hold rope attachment overhead. Extend arms downwards. Repeat.',
  equipment: Equipment.cable,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([triceps])
  ..secondaryMuscleGroups.addAll([]);

final plateLoadedNeckExtension = Exercise(
  name: 'Neck Extension (Plate Loaded)',
  description:
      'Sit on bench. Hold weight plate behind head. Extend neck. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.other,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([neck])
  ..secondaryMuscleGroups.addAll([]);

final weightedChinUps = Exercise(
  name: 'Chin Ups (Weighted)',
  description:
      'Hang from bar with underhand grip. Pull body upwards until chin is above bar. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.bodyweight,
  movementPattern: MovementPattern.verticalPull,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([lats, biceps])
  ..secondaryMuscleGroups.addAll([rearDelts, midBack]);

final legExtension = Exercise(
  name: 'Leg Extension',
  description: 'Sit on machine. Place feet under pad. Extend legs. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.machine,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([quads])
  ..secondaryMuscleGroups.addAll([]);

final barbellRomanianDeadlift = Exercise(
  name: 'Romanian Deadlift (Barbell)',
  description:
      'Stand with feet hip width apart. Hold barbell with overhand grip. Hinge at hips and lower barbell to mid-shin. Extend hips and return to standing. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.hipHinge,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([quads])
  ..secondaryMuscleGroups.addAll([]);

final dumbbellInclineCurl = Exercise(
  name: 'Incline Curl (Dumbbell)',
  description:
      'Sit on incline bench. Hold dumbbells with underhand grip. Curl dumbbells upwards. Repeat.',
  engagement: Engagement.bilateralSeparate,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([biceps])
  ..secondaryMuscleGroups.addAll([]);

final standingCalfRaise = Exercise(
  name: 'Standing Calf Raise (Machine)',
  description: 'Stand on calf raise machine. Raise heels upwards. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.machine,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([calves])
  ..secondaryMuscleGroups.addAll([]);

final legPress = Exercise(
  name: 'Leg Press',
  description: 'Sit on machine. Push platform upwards. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.machine,
  movementPattern: MovementPattern.squat,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([quads])
  ..secondaryMuscleGroups.addAll([glutes]);

final dumbbellRow = Exercise(
  name: 'Row (Dumbbell)',
  description:
      'Stand with feet hip width apart. Hold dumbbells with overhand grip. Hinge at hips and lower dumbbells to mid-shin. Extend hips and return to standing. Repeat.',
  engagement: Engagement.unilateral,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.horizontalPull,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([lats, midBack])
  ..secondaryMuscleGroups.addAll([biceps, forearms, rearDelts]);

final barbellUprightRow = Exercise(
  name: 'Upright Row (Barbell)',
  description:
      'Stand with feet hip width apart. Hold barbell with overhand grip. Pull barbell upwards to chin. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([midDelts])
  ..secondaryMuscleGroups.addAll([midBack]);

final closeGripBarbellBenchPress = Exercise(
  name: 'Close Grip Bench Press (Barbell)',
  description:
      'Lie supine on bench. Graph bar with overhand and shoulder width grip. Arch back, extend hips, and position feet back flat on floor. Dismount barbell from rack over chest.\n\nLower weight to lower chest. Press bar upwards until arms are extended. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([triceps])
  ..secondaryMuscleGroups.addAll([chest, frontDelts]);

final dumbbellHammerCurl = Exercise(
  name: 'Hammer Curl (Dumbbell)',
  description:
      'Stand with feet hip width apart. Hold dumbbells with neutral grip. Curl dumbbells upwards. Repeat.',
  engagement: Engagement.unilateral,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([biceps])
  ..secondaryMuscleGroups.addAll([]);

final barbellInclineBenchPress = Exercise(
  name: 'Incline Bench Press (Barbell)',
  description:
      'Lie supine on incline bench. Graph bar with overhand and slightly wider than shoulder width grip. Arch back, extend hips, and position feet back flat on floor. Dismount barbell from rack over chest.\n\nLower weight to lower chest. Press bar upwards until arms are extended. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([chest])
  ..secondaryMuscleGroups.addAll([frontDelts, triceps]);

final neckCurl = Exercise(
  name: 'Neck Curl (Plate Loaded)',
  description:
      'Sit on bench. Hold weight plate on forehead. Curl neck. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.other,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([neck])
  ..secondaryMuscleGroups.addAll([]);

final jmPress = Exercise(
  name: 'JM Press (Barbell)',
  description:
      'Lie supine on bench. Graph bar with overhand and slightly wider than shoulder width grip. Arch back, extend hips, and position feet back flat on floor. Dismount barbell from rack over chest.\n\nLower weight to lower chest. Press bar upwards until arms are extended. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPush,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([triceps])
  ..secondaryMuscleGroups.addAll([frontDelts, chest]);

final landmineObliqueTwist = Exercise(
  name: 'Oblique Twist (Landmine)',
  description:
      'Stand with feet hip width apart. Hold barbell with both hands. Rotate torso to one side. Repeat.',
  engagement: Engagement.unilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([abs])
  ..secondaryMuscleGroups.addAll([frontDelts]);

final barbellDeadlift = Exercise(
  name: 'Conventional Deadlift (Barbell)',
  description:
      'Stand with feet hip width apart. Hold barbell with overhand grip. Hinge at hips and lower barbell to mid-shin. Extend hips and return to standing. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.hipHinge,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([lowerBack, hamstrings])
  ..secondaryMuscleGroups.addAll([abs, forearms, glutes, lats, quads, midBack]);

final seatedCalfRaise = Exercise(
  name: 'Seated Calf Raise (Machine)',
  description: 'Sit on calf raise machine. Raise heels upwards. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.machine,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([calves])
  ..secondaryMuscleGroups.addAll([]);

final smithMachineSquat = Exercise(
  name: 'Squat (Smith Machine)',
  description:
      'Stand with feet hip width apart. Hold barbell with overhand grip. Squat downwards. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.smithMachine,
  movementPattern: MovementPattern.squat,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([quads])
  ..secondaryMuscleGroups.addAll([abs, lowerBack, glutes, hamstrings]);

final barbellPreacherCurl = Exercise(
  name: 'Preacher Curl (Barbell)',
  description:
      'Sit on preacher bench. Hold barbell with underhand grip. Curl barbell upwards. Repeat.',
  engagement: Engagement.bilateral,
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([biceps])
  ..secondaryMuscleGroups.addAll([]);

final krocRow = Exercise(
  name: 'Kroc Row',
  description:
      'Stand with feet hip width apart. Hold dumbbell with overhand grip. Hinge at hips and lower dumbbell to mid-shin. Extend hips and return to standing. Repeat.',
  engagement: Engagement.unilateral,
  equipment: Equipment.dumbbell,
  movementPattern: MovementPattern.horizontalPull,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([lats, midBack])
  ..secondaryMuscleGroups.addAll([biceps, forearms, rearDelts]);

final cableLateralRaise = Exercise(
  name: 'Lateral Raise (Cable)',
  description:
      'Stand in front of cable machine. Hold handle with one hand. Raise arm to side. Repeat.',
  engagement: Engagement.unilateral,
  equipment: Equipment.cable,
  movementPattern: MovementPattern.isolation,
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)
  ..primaryMuscleGroups.addAll([midDelts])
  ..secondaryMuscleGroups.addAll([frontDelts]);

final masterExercises = [
  barbellBenchPress,
  dumbbellPullover,
  barbellAdPress,
  cableCrunch,
  dumbbellBenchPress,
  cableTricepExtension,
  plateLoadedNeckExtension,
  weightedChinUps,
  legExtension,
  barbellRomanianDeadlift,
  dumbbellInclineCurl,
  standingCalfRaise,
  legPress,
  dumbbellRow,
  barbellUprightRow,
  closeGripBarbellBenchPress,
  dumbbellHammerCurl,
  barbellInclineBenchPress,
  neckCurl,
  jmPress,
  landmineObliqueTwist,
  barbellDeadlift,
  seatedCalfRaise,
  smithMachineSquat,
  barbellPreacherCurl,
  krocRow,
  cableLateralRaise,
];
