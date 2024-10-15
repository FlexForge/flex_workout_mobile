class LineGraphModel {
  LineGraphModel({required this.name, this.points = const []});

  final String name;
  List<LineGraphPoint> points;
}

class LineGraphPoint {
  LineGraphPoint({
    required this.xAxis,
    required this.yAxis,
  });

  final int xAxis;
  final int yAxis;
}
