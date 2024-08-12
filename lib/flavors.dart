enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;
  static String get title => 'Example ${appFlavor?.name}';
  static String get envFileName => '${appFlavor?.name}.config.json';
}
