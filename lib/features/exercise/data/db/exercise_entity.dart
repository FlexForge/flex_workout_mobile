import 'package:objectbox/objectbox.dart';

@Entity()
class Exercise {
  Exercise({
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
    this.description,
    this.videoUrl,
  });

  @Id()
  int id = 0;

  String name;
  String? description;

  String? videoUrl;

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}
