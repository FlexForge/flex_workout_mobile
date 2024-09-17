import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MuscleGroupEntity {
  MuscleGroupEntity({
    required this.name,
    required this.diagramPathNames,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String name;
  List<String> diagramPathNames;

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

extension ConvertMuscleGroup on MuscleGroupEntity {
  MuscleGroupModel toModel() => MuscleGroupModel(
        id: id,
        name: name,
        diagramPathNames: diagramPathNames,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
