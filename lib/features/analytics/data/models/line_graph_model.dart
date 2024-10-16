import 'package:dart_mappable/dart_mappable.dart';

part 'line_graph_model.mapper.dart';

@MappableClass()
class LineGraphModel<T> with LineGraphModelMappable<T> {
  LineGraphModel({required this.name, this.points = const []});

  final String name;
  List<LineGraphPoint<T>> points;
}

@MappableClass()
class LineGraphPoint<T> with LineGraphPointMappable<T> {
  LineGraphPoint({
    required this.xAxis,
    required this.yAxis,
  });

  final T xAxis;
  final double yAxis;
}
