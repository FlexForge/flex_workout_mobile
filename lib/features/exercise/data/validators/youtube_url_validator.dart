import 'package:reactive_forms/reactive_forms.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeUrlValidator extends Validator<dynamic> {
  const YoutubeUrlValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.value == null) {
      return null;
    }

    final trimmedString = control.value.toString().trim();

    if (trimmedString.isEmpty) {
      return null;
    }

    final videoId = YoutubePlayer.convertUrlToId(trimmedString);

    if (videoId == null) {
      return <String, dynamic>{
        'invalidUrl': 'cannotParse',
      };
    }

    return null;
  }
}
