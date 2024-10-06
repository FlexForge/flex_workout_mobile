// coverage:ignore-file

import 'package:flex_workout_mobile/core/common/ui/screens/error_screen.dart';
import 'package:flex_workout_mobile/core/common/ui/screens/main_screen.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/auth/ui/screens/onboarding_screen.dart';
import 'package:flex_workout_mobile/features/auth/ui/screens/profile_screen.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_quick_create.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/equipment_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/movement_pattern_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/primary_muscle_group_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_create_screen.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_view_screen.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/exercise_selection_screen.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/normal_set_sheet.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/swipe_action_navigator_observer.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Main router for the Example app
///
/// ! Pay attention to the order of routes.
/// Create:  example/create
/// View:    example/:eid
/// Edit:    example/:eid/edit
/// where :edit means example entity id.
///

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainScreen(),
      routes: [
        /// Tracker Routes
        GoRoute(
          path: TrackerScreen.routePath,
          name: TrackerScreen.routeName,
          pageBuilder: (context, state) => CupertinoModalSheetPage(
            swipeDismissible: true,
            barrierColor: context.colors.overlay,
            child: const TrackerScreenModal(nestedNavigator: TrackerScreen()),
          ),
          routes: [
            GoRoute(
              path: ExerciseSelectionScreen.routePath,
              name: ExerciseSelectionScreen.routeName,
              pageBuilder: (context, state) => CupertinoModalSheetPage(
                swipeDismissible: true,
                barrierColor: context.colors.overlay,
                child: const ExerciseSelectionScreenModal(
                  nestedNavigator: ExerciseSelectionScreen(),
                ),
              ),
              routes: [
                GoRoute(
                  path: ExerciseQuickCreate.routePath,
                  name: ExerciseQuickCreate.routeName,
                  pageBuilder: (context, state) => CupertinoModalSheetPage(
                    swipeDismissible: true,
                    barrierColor: context.colors.overlay,
                    child: const ExerciseQuickCreateModal(
                      child: ExerciseQuickCreate(),
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: NormalSetScreen.routePath,
              name: NormalSetScreen.routeName,
              pageBuilder: (context, state) {
                final set = state.extra as LiveDefaultSetModel?;
                return CupertinoModalSheetPage(
                  swipeDismissible: true,
                  barrierColor: context.colors.overlay,
                  child: NormalSetScreenModal(
                    nestedNavigator: NormalSetScreen(set: set),
                  ),
                );
              },
            ),
          ],
        ),

        /// User Routes
        GoRoute(
          path: ProfileScreen.routePath,
          name: ProfileScreen.routeName,
          builder: (context, state) => const ProfileScreen(),
        ),

        /// Exercise Routes
        GoRoute(
          path: ExerciseCreateScreen.routePath,
          name: ExerciseCreateScreen.routeName,
          builder: (context, state) => const ExerciseCreateScreen(),
          routes: [
            GoRoute(
              path: EquipmentPicker.routePath,
              name: EquipmentPicker.routeName,
              pageBuilder: (context, state) => CupertinoModalSheetPage(
                swipeDismissible: true,
                barrierColor: context.colors.overlay,
                child: const EquipmentModal(child: EquipmentPicker()),
              ),
            ),
            GoRoute(
              path: MovementPatternPicker.routePath,
              name: MovementPatternPicker.routeName,
              pageBuilder: (context, state) => CupertinoModalSheetPage(
                swipeDismissible: true,
                barrierColor: context.colors.overlay,
                child:
                    const MovementPatternModal(child: MovementPatternPicker()),
              ),
            ),
            GoRoute(
              path: PrimaryMuscleGroupPicker.routePath,
              name: PrimaryMuscleGroupPicker.routeName,
              pageBuilder: (context, state) => CupertinoModalSheetPage(
                swipeDismissible: true,
                barrierColor: context.colors.overlay,
                child:
                    const MuscleGroupModal(child: PrimaryMuscleGroupPicker()),
              ),
            ),
            GoRoute(
              path: SecondaryMuscleGroupsPicker.routePath,
              name: SecondaryMuscleGroupsPicker.routeName,
              pageBuilder: (context, state) => CupertinoModalSheetPage(
                swipeDismissible: true,
                barrierColor: context.colors.overlay,
                child: const MuscleGroupModal(
                  child: SecondaryMuscleGroupsPicker(),
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: ExerciseViewScreen.routePath,
          name: ExerciseViewScreen.routeName,
          builder: (context, state) => ExerciseViewScreen(
            id: state.pathParameters['eid']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/${OnboardingScreen.routePath}',
      name: OnboardingScreen.routePath,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
  observers: [
    routeObserver,
    SwipeActionNavigatorObserver(),
  ],
  redirect: (context, state) {
    final isFirstTime = isFirstLoadListener.value;
    final goingToOnboard =
        state.matchedLocation.contains('/${OnboardingScreen.routePath}');

    if (isFirstTime && !goingToOnboard) {
      return '/${OnboardingScreen.routePath}';
    }
    if (!isFirstTime && goingToOnboard) return '/';

    return null;
  },
  refreshListenable: isFirstLoadListener,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      ErrorScreen(message: state.error.toString()),
);

/// Route observer to use with RouteAware
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
