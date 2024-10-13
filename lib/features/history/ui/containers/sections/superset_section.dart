import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';

class HistoricWorkoutSupersetSection extends StatelessWidget {
  const HistoricWorkoutSupersetSection({
    required this.section,
    required this.index,
    super.key,
  });

  final int index;
  final HistoricSupersetSectionModel section;

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

              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: set.length,
                separatorBuilder: (context, index) => Divider(
                  indent: 54,
                  height: 0,
                  color: context.colors.divider,
                ),
                itemBuilder: (context, exerciseIndex) {
                  final superSet = set.entries.toList()[exerciseIndex];

                  switch (superSet.value) {
                    case final HistoricDefaultSetModel obj:
                      return HistoricWorkoutDefaultSetTile(
                        set: obj,
                        index: setIndex,
                        setString: superSet.key,
                      );
                  }
                },
              );
            },
            separatorBuilder: (context, index) =>
                Divider(height: 0, color: context.colors.divider),
          ),
        ],
      ),
    );
  }
}
