import 'package:reactive_forms/reactive_forms.dart';

class FullNameValidator extends Validator<dynamic> {
  const FullNameValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.value == null) {
      return null;
    }

    final numberString = control.value.toString().trim();

    if (numberString.isEmpty) {
      return null;
    }

    final parts = numberString.split(' ');

    if (parts.length == 1) {
      return <String, dynamic>{
        'invalidName': 'onlyFirstName',
      };
    }

    return null;
  }
}
