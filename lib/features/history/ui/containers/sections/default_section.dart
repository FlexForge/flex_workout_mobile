import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';

class HistoricWorkoutDefaultSection extends StatelessWidget {
  const HistoricWorkoutDefaultSection({
    required this.section,
    required this.index,
    super.key,
  });

  final int index;
  final HistoricDefaultSectionModel section;

  @override
  Widget build(BuildContext context) {
    return Section(
      header: index == 0 ? 'Workout Overview' : null,
      subHeader: section.title,
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      body: Column(
        children: [
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: section.sets.length,
            itemBuilder: (context, setIndex) {
              final set = section.sets[setIndex];

              switch (set) {
                case final HistoricDefaultSetModel obj:
                  return HistoricWorkoutDefaultSetTile(
                    set: obj,
                    index: setIndex,
                  );
              }
            },
            separatorBuilder: (context, index) =>
                Divider(indent: 54, height: 0, color: context.colors.divider),
          ),
        ],
      ),
    );
  }
}
