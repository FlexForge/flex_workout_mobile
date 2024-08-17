import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_model.freezed.dart';

@freezed
class AppModel with _$AppModel {
  const factory AppModel({
    @Default(false) bool workoutInProgress,
  }) = _AppModel;
}
