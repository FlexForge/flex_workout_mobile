// Helper file to make coverage work for all files

// ignore_for_file: unused_import, directives_ordering
import 'package:flex_workout_mobile/bootstrap.dart';
import 'package:flex_workout_mobile/core/config/router.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/config/objectbox.dart';
import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/core/utils/functions.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/core/utils/svg.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/data/models/app_model.dart';
import 'package:flex_workout_mobile/main_prod.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_create_controller.dart';
import 'package:flex_workout_mobile/features/auth/controllers/onboarding_controller.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_form_controller.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_info_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/onboarding_repository.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/user_repository.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_form_model.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flex_workout_mobile/features/auth/data/db/is_first_load_store.dart';
import 'package:flex_workout_mobile/features/auth/data/validators/full_name_validator.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/main_tracker_info_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/system/controllers/theme_controller.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_view_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/repositories/exercise_repository.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_filter_controller.dart';
import 'package:flex_workout_mobile/main_dev.dart';
import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/flavors.dart';
import 'package:flex_workout_mobile/main_staging.dart';
import 'package:flex_workout_mobile/app.dart';

void main() {}
