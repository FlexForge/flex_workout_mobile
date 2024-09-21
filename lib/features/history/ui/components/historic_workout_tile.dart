import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HistoricWorkoutTile extends StatelessWidget {
  const HistoricWorkoutTile({required this.workout, super.key});

  final HistoricWorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return Section(
      subHeader: workout.title,
      body: Container(
        padding: const EdgeInsets.only(
          left: AppLayout.p4,
          right: AppLayout.p4,
          bottom: AppLayout.p4,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  workout.subtitle,
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMEd().format(workout.startTimestamp),
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: workout.sections.length,
              itemBuilder: (context, index) {
                final section = workout.sections[index];

                switch (section) {
                  case final HistoricDefaultSectionModel obj:
                    return _HistoricDefaultSectionRow(section: obj);
                  case final HistoricSupersetSectionModel obj:
                    return _HistoricSupersetSectionRow(section: obj);
                }
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppLayout.p4),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoricDefaultSectionRow extends StatelessWidget {
  const _HistoricDefaultSectionRow({required this.section});

  final HistoricDefaultSectionModel section;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _HistoricSupersetSectionRow extends StatelessWidget {
  const _HistoricSupersetSectionRow({required this.section});

  final HistoricSupersetSectionModel section;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _HistoricDefaultSetRow extends StatelessWidget {
  const _HistoricDefaultSetRow({
    required this.defaultSet,
    required this.numberOfSets,
  });

  final HistoricDefaultSetModel defaultSet;
  final int numberOfSets;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
