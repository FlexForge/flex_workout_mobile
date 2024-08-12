import 'package:flex_workout_mobile/features/auth/controllers/user_create_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_controller.g.dart';

@riverpod
class UserFormController extends _$UserFormController {
  @override
  UserForm build() {
    return UserForm(UserForm.formElements(const User()), null);
  }

  void create() {
    ref.read(userCreateControllerProvider.notifier).handle(state);
  }
}
