import 'package:flex_workout_mobile/features/history/controllers/tracked_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../mocks.dart';
import '../../../utils.dart';
import '../../exercise/data/db/store.dart';
import '../../tracker/data/models/store.dart';

void main() {
  late MockTrackedWorkoutRepository mockTrackedWorkoutRepository;

  setUp(() {
    mockTrackedWorkoutRepository = MockTrackedWorkoutRepository();
  });

  ProviderContainer createTrackedWorkoutListContainer() {
    return createContainer(
      overrides: [
        trackedWorkoutRepositoryProvider
            .overrideWithValue(mockTrackedWorkoutRepository),
      ],
    );
  }

  group('TrackedWorkoutListController', () {
    test('should return list of workouts on call', () {
      final expected = generateTrackedWorkouts(10);

      when(
        () => mockTrackedWorkoutRepository.getTrackedWorkouts(),
      ).thenReturn(right(expected));

      final container = createTrackedWorkoutListContainer();
      final res = container.read(trackedWorkoutListControllerProvider);

      expect(res, expected);
    });

    test('should add workout to list', () {
      final mockList = generateTrackedWorkouts(10);
      final mockWorkout = generateTrackedWorkouts(1).first;

      when(() => mockTrackedWorkoutRepository.getTrackedWorkouts())
          .thenReturn(right(mockList));

      final container = createTrackedWorkoutListContainer();
      container
          .read(trackedWorkoutListControllerProvider.notifier)
          .addWorkout(mockWorkout);

      final res = container.read(trackedWorkoutListControllerProvider);

      expect(res.length, 11);
      expect(res.last, mockWorkout);
    });
  });

  group('HashMapGenerator', () {
    test('should return correct hash code', () {
      final mockList = generateTrackedWorkouts(1);
      final mockWorkout = mockList.first;
      final mockDate = mockWorkout.startTimestamp;

      final res = mockWorkout.startTimestamp.day * 1000000 +
          mockWorkout.startTimestamp.month * 10000 +
          mockWorkout.startTimestamp.year;

      expect(mockList.getHashCode(mockDate), res);
    });

    test('should return map with correct keys', () {
      final mockList = generateTrackedWorkouts(10);
      final res = mockList.toDateTimeMap();

      for (final workout in mockList) {
        final key = workout.startTimestamp.copyWith(
          hour: 1,
          minute: 1,
          second: 1,
          millisecond: 1,
          microsecond: 1,
        );

        expect(res.containsKey(key), true);
      }
    });

    test('should return map with correct values', () {
      final mockList = generateTrackedWorkouts(10);
      final res = mockList.toDateTimeMap();

      for (final workout in mockList) {
        final key = workout.startTimestamp.copyWith(
          hour: 1,
          minute: 1,
          second: 1,
          millisecond: 1,
          microsecond: 1,
        );

        expect(res[key]!.contains(workout), true);
      }
    });

    test('should return LinkedHashMap with correct keys', () {
      final mockList = generateTrackedWorkouts(10);
      final res = mockList.toHash(DateTime.now());

      for (final workout in mockList) {
        final key = workout.startTimestamp.copyWith(
          hour: 1,
          minute: 1,
          second: 1,
          millisecond: 1,
          microsecond: 1,
        );

        expect(res.containsKey(key), true);
      }
    });

    test('should return LinkedHashMap with correct values', () {
      final mockList = generateTrackedWorkouts(10);
      final res = mockList.toHash(DateTime.now());

      for (final workout in mockList) {
        final key = workout.startTimestamp.copyWith(
          hour: 1,
          minute: 1,
          second: 1,
          millisecond: 1,
          microsecond: 1,
        );

        expect(res[key]!.contains(workout), true);
      }
    });
  });

  group('TrackedWorkoutHistoryListToMap', () {
    group('toFullMap', () {
      test('should return map with correct keys', () {
        final mockList = generateTrackedWorkouts(10);
        final res = mockList.toFullMap();

        for (final workout in mockList) {
          final key = workout.startTimestamp.copyWith(
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          );

          expect(res.containsKey(DateFormat.yMMMM().format(key)), true);
        }
      });

      test('should return map with correct values', () {
        final mockList = generateTrackedWorkouts(10);
        final res = mockList.toFullMap();

        for (final workout in mockList) {
          final key = workout.startTimestamp.copyWith(
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          );

          expect(res[DateFormat.yMMMM().format(key)]!.contains(workout), true);
        }
      });
    });

    group('toSingleMap', () {
      test('should return map with correct keys', () {
        final mockList = generateTrackedWorkouts(10);
        final mockDate = mockList.first.startTimestamp;

        final res = mockList.toSingleMap(selectedDay: mockDate);

        final key = DateFormat.yMMMMEEEEd().format(mockDate);

        final expectedList = mockList.where((e) {
          return isSameDay(mockDate, e.startTimestamp);
        }).toList();

        expect(res.containsKey(key), true);
        expect(res[key]!.length, expectedList.length);
      });

      test('should return map with correct values', () {
        final mockList = generateTrackedWorkouts(10);
        final mockDate = mockList.first.startTimestamp;

        final res = mockList.toSingleMap(selectedDay: mockDate);

        final key = DateFormat.yMMMMEEEEd().format(mockDate);

        final expectedList = mockList.where((e) {
          return isSameDay(mockDate, e.startTimestamp);
        }).toList();

        expect(res[key]!.contains(mockList.first), true);
        expect(res[key]!.length, expectedList.length);
      });
    });
  });

  group('WorkoutSectionTile', () {
    test('toWorkoutHistoryTable', () {
      final sections = exampleWorkout.sections;

      final historyTable = sections.toWorkoutHistoryTable();

      final expected = <WorkoutHistoryTableCell>[
        WorkoutHistoryTableCell(exampleExerciseOne.name, 2, '245 lbs x 5'),
        WorkoutHistoryTableCell(
          exampleExerciseTwo.name,
          2,
          '20 lbs x 10',
          superSetIndex: 0,
        ),
        WorkoutHistoryTableCell(
          exampleExerciseThree.name,
          2,
          '20 lbs x 10',
          superSetIndex: 0,
        ),
      ];

      expect(historyTable.length, expected.length);
    });
  });
}
