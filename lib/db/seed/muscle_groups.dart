import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';

final chest = MuscleGroupEntity(
  name: 'Chest',
  diagramPathNames: [
    'chest_left',
    'chest_right',
    'upper_chest_left',
    'upper_chest_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final frontDelts = MuscleGroupEntity(
  name: 'Front Delts',
  diagramPathNames: [
    'front_shoulder_left',
    'front_shoulder_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final midDelts = MuscleGroupEntity(
  name: 'Middle Delts',
  diagramPathNames: [
    'mid_shoulder_left',
    'mid_shoulder_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final rearDelts = MuscleGroupEntity(
  name: 'Rear Delts',
  diagramPathNames: [
    'rear_shoulder_left',
    'rear_shoulder_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final biceps = MuscleGroupEntity(
  name: 'Biceps',
  diagramPathNames: ['bicep_left', 'bicep_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final triceps = MuscleGroupEntity(
  name: 'Triceps',
  diagramPathNames: ['tricep_left', 'tricep_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final forearms = MuscleGroupEntity(
  name: 'Forearms',
  diagramPathNames: [
    'forearm_bottom_left',
    'forearm_bottom_right',
    'forearm_top_left',
    'forearm_top_right',
    'forearm_lower_left',
    'forearm_lower_right',
    'forearm_upper_left',
    'forearm_upper_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final lats = MuscleGroupEntity(
  name: 'Lats',
  diagramPathNames: ['lat_left', 'lat_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final trap = MuscleGroupEntity(
  name: 'Traps',
  diagramPathNames: ['trap_left', 'trap_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final midBack = MuscleGroupEntity(
  name: 'Mid Back',
  diagramPathNames: [
    'infraspinatus_left',
    'infraspinatus_right',
    'rhomboid_left',
    'rhomboid_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final lowerBack = MuscleGroupEntity(
  name: 'Lower Back',
  diagramPathNames: ['lower_back'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final neck = MuscleGroupEntity(
  name: 'Neck',
  diagramPathNames: ['neck_right', 'neck_left'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final abs = MuscleGroupEntity(
  name: 'Abs',
  diagramPathNames: [
    'oblique_1',
    'oblique_2',
    'oblique_3',
    'oblique_4',
    'oblique_5',
    'oblique_6',
    'oblique_7',
    'oblique_8',
    'oblique_9',
    'oblique_10',
    'oblique_11',
    'oblique_12',
    'oblique_13',
    'oblique_14',
    'abs_1',
    'abs_2',
    'abs_3',
    'abs_4',
    'abs_5',
    'abs_6',
    'abs_7',
    'abs_8',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final glutes = MuscleGroupEntity(
  name: 'Glutes',
  diagramPathNames: [
    'glute_upper_left',
    'glute_upper_right',
    'glute_lower_left',
    'glute_lower_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final hamstrings = MuscleGroupEntity(
  name: 'Hamstrings',
  diagramPathNames: [
    'hamstring_1',
    'hamstring_2',
    'hamstring_3',
    'hamstring_4',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final quads = MuscleGroupEntity(
  name: 'Quads',
  diagramPathNames: [
    'quad_upper_left',
    'quad_upper_right',
    'quad_lower_left',
    'quad_lower_right',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final abductors = MuscleGroupEntity(
  name: 'Abductors',
  diagramPathNames: ['abductor_left', 'abductor_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final adductors = MuscleGroupEntity(
  name: 'Adductors',
  diagramPathNames: ['adductor_left', 'adductor_right'],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final calves = MuscleGroupEntity(
  name: 'Calves',
  diagramPathNames: [
    'calve_left',
    'calf_right',
    'calf_outer_right',
    'calf_outer_left',
    'calf_inner_right',
    'calf_inner_left',
  ],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
);

final muscleGroups = [
  chest,
  frontDelts,
  midDelts,
  rearDelts,
  biceps,
  triceps,
  forearms,
  lats,
  trap,
  midBack,
  lowerBack,
  neck,
  abs,
  glutes,
  hamstrings,
  quads,
  abductors,
  adductors,
  calves,
];
