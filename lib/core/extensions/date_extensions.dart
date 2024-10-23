extension FormattedDuration on Duration {
  String get formatted => '$inMinutes'
      ':'
      '${inSeconds.remainder(60).toString().padLeft(2, '0')}';
}
