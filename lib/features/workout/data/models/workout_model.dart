import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/features/workout/data/db/workout_entity.dart';

part 'workout_model.mapper.dart';

@MappableClass()
class WorkoutModel with WorkoutModelMappable {
  WorkoutModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String subtitle;
  final String description;

  final DateTime updatedAt;
  final DateTime createdAt;

  WorkoutEntity toEntity() {
    return WorkoutEntity(
      title: title,
      subtitle: subtitle,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}
