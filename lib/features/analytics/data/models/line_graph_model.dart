import 'package:dart_mappable/dart_mappable.dart';

part 'line_graph_model.mapper.dart';

@MappableClass()
class LineGraphModel with LineGraphModelMappable {
  LineGraphModel({required this.name, this.points = const []});

  final String name;
  List<LineGraphPoint> points;
}

@MappableClass()
class LineGraphPoint with LineGraphPointMappable {
  LineGraphPoint({
    required this.xAxis,
    required this.yAxis,
  });

  final int xAxis;
  final double yAxis;
}
