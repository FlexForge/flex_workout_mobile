import 'package:flex_workout_mobile/core/common/ui/components/flex_calendar.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_filter_controller.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoricCalendar extends ConsumerStatefulWidget {
  const HistoricCalendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoricCalendarState();
}

class _HistoricCalendarState extends ConsumerState<HistoricCalendar> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final historicWorkouts =
        ref.watch(historicWorkoutListControllerProvider).toHash(_selectedDay);

    return FlexCalendar<HistoricWorkoutModel>(
      events: historicWorkouts,
      onDaySelected: (selectedDay) {
        ref
            .read(historicWorkoutFilterControllerProvider.notifier)
            .handle(selectedDay);
      },
    );
  }
}
