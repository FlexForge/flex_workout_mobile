import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

class PathContainer {
  PathContainer({
    required this.id,
    required this.path,
    required this.name,
    this.color = '000000',
  });

  String id;
  String path;
  String color;
  String name;
}

class SvgParser {
  static Future<List<PathContainer>> loadSvgImage({
    required String pathToSvg,
  }) async {
    final maps = <PathContainer>[];
    final generalString = await rootBundle.loadString(pathToSvg);

    final document = XmlDocument.parse(generalString);
    final paths = document.findAllElements('path');

    for (final element in paths) {
      final partId = element.getAttribute('id') ?? 'unknown';
      final partPath = element.getAttribute('d').toString();
      final name = element.getAttribute('name').toString();
      final color = element.getAttribute('color')?.toString() ?? 'D7D3D2';

      maps.add(
        PathContainer(
          id: partId,
          path: partPath,
          color: color,
          name: name,
        ),
      );
    }

    return maps;
  }
}

class Clipper extends CustomClipper<Path> {
  Clipper({
    required this.svgPath,
  });

  String svgPath;

  @override
  Path getClip(Size size) {
    final path = parseSvgPathData(svgPath);
    final matrix4 = Matrix4.identity();

    return path.transform(matrix4.storage);
  }

  @override
  // ignore: strict_raw_type
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
