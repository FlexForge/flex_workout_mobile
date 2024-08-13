import 'package:flex_workout_mobile/features/auth/data/validators/full_name_validator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'user_form_model.gform.dart';
part 'user_form_model.freezed.dart';

@Rf()
@freezed
class User with _$User {
  const factory User({
    @RfControl(validators: [RequiredValidator(), FullNameValidator()])
    String? name,
    @RfControl(validators: [RequiredValidator(), EmailValidator()])
    String? email,
    @RfControl(validators: [RequiredValidator()]) int? sex,
  }) = _User;
}
