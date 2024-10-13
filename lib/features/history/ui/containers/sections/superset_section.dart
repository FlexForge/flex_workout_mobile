import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';

class HistoricWorkoutSupersetSection extends StatelessWidget {
  const HistoricWorkoutSupersetSection({required this.section, super.key});

  final HistoricSupersetSectionModel section;

  @override
  Widget build(BuildContext context) {
    return Section(
      header: section.title,
      subHeader: 'Working Sets',
      padding: const EdgeInsets.only(
        left: AppLayout.p4,
        right: AppLayout.p4,
        bottom: AppLayout.p3,
      ),
      body: Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: section.sets.length,
            itemBuilder: (context, setIndex) {
              final set = section.sets[setIndex];

              return ListView.separated(
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
                  // return superSet.display();
                },
              );
            },
            separatorBuilder: (context, index) =>
                Divider(height: 0, color: context.colors.divider),
          ),
          const SizedBox(height: AppLayout.p4),
        ],
      ),
    );
  }
}
