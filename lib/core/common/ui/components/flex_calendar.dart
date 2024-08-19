import 'dart:collection';

import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:table_calendar/table_calendar.dart';

class FlexCalendar<T> extends ConsumerStatefulWidget {
  const FlexCalendar({
    required this.events,
    this.onDaySelected,
    super.key,
  });

  final LinkedHashMap<DateTime, List<T>> events;
  final void Function(DateTime? selectedDay)? onDaySelected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FlexCalendarState<T>();
}

class _FlexCalendarState<T> extends ConsumerState<FlexCalendar<T>> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final DateTime today = DateTime.now();

  final _calendarFormat = CalendarFormat.month;
  final _rangeSelectionMode = RangeSelectionMode.toggledOff;

  DateTime? _selectedDay;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (isSameDay(_selectedDay, selectedDay)) {
        _selectedDay = null;
      } else {
        _selectedDay = selectedDay;
      }
      _focusedDay.value = focusedDay;
    });

    widget.onDaySelected?.call(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    List<T> getEventsForDay(DateTime day) {
      return widget.events[day] ?? [];
    }

    return Container(
      color: context.colors.backgroundSecondary,
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _focusedDay,
            builder: (context, value, _) => _CalendarHeader(
              focusedDay: value,
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
          const SizedBox(height: AppLayout.p2),
          const _CalendarDow(),
          const SizedBox(height: AppLayout.p2),
          TableCalendar<T>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            headerVisible: false,
            daysOfWeekVisible: false,
            sixWeekMonthsEnforced: true,
            focusedDay: _focusedDay.value,
            currentDay: today,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay.value = focusedDay;
              });
            },
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
                  border: Border.all(
                    color: context.colors.foregroundQuaternary,
                    width: 2,
                  ),
                ),
                child: Text(
                  day.day.toString(),
                  style: context.typography.labelMedium,
                ),
              ),
              todayBuilder: (context, day, focusedDay) => Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFe0f2f1),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppLayout.cornerRadius),
                      border: Border.all(
                        color: context.colors.foregroundQuaternary,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      day.day.toString(),
                      style: context.typography.labelMedium,
                    ),
                  ),
                ],
              ),
              outsideBuilder: (context, day, focusedDay) => Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                child: Text(
                  day.day.toString(),
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundTertiary,
                  ),
                ),
              ),
              selectedBuilder: (context, day, focusedDay) => Stack(
                children: [
                  if (isSameDay(today, day))
                    Positioned(
                      bottom: 10,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFe0f2f1),
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colors.blue.withOpacity(0.3),
                      borderRadius:
                          BorderRadius.circular(AppLayout.cornerRadius),
                      border: Border.all(
                        color: context.colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      day.day.toString(),
                      style: context.typography.labelMedium,
                    ),
                  ),
                ],
              ),
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return const SizedBox();

                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
                    border: Border.all(
                      color: (_focusedDay.value.month == day.month)
                          ? context.colors.blue
                          : context.colors.blue.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppLayout.p3),
        ],
      ),
    );
  }
}

class _CalendarDow extends StatelessWidget {
  const _CalendarDow();

  static const List<String> _daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _daysOfWeek
          .map(
            (day) => Expanded(
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: context.typography.labelMedium,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  });

  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM().format(focusedDay);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          headerText,
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        LargeButton(
          icon: Symbols.chevron_left,
          onPressed: onLeftArrowTap,
          backgroundColor: context.colors.backgroundSecondary,
        ),
        LargeButton(
          icon: Symbols.chevron_right,
          onPressed: onRightArrowTap,
          backgroundColor: context.colors.backgroundSecondary,
        ),
      ],
    );
  }
}
