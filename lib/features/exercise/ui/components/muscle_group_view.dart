import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_display.dart';
import 'package:flutter/widgets.dart';

class MuscleGroupView extends StatefulWidget {
  const MuscleGroupView({
    required this.primaryMuscleGroups,
    required this.secondaryMuscleGroups,
    super.key,
  });

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  @override
  State<MuscleGroupView> createState() => _MuscleGroupViewState();
}

class _MuscleGroupViewState extends State<MuscleGroupView> {
  int _selectedValue = 0;

  void _onSegmentedControllerValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppLayout.p4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IndexedStack(
                index: _selectedValue,
                children: [
                  MuscleGroupDisplay(
                    muscleGroups: frontMuscleGroups,
                    primaryMuscleGroups: widget.primaryMuscleGroups,
                    secondaryMuscleGroups: widget.secondaryMuscleGroups,
                  ),
                  MuscleGroupDisplay(
                    muscleGroups: backMuscleGroups,
                    primaryMuscleGroups: widget.primaryMuscleGroups,
                    secondaryMuscleGroups: widget.secondaryMuscleGroups,
                  ),
                ],
              ),
              const SizedBox(width: AppLayout.p5),
              Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: AppLayout.p2,
                              width: AppLayout.p2,
                              decoration: BoxDecoration(
                                color: context.colors.pink,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: AppLayout.p1),
                            Text(
                              'Primary',
                              style: context.typography.labelMedium.copyWith(
                                color: context.colors.foregroundPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppLayout.p2),
                        Wrap(
                          clipBehavior: Clip.hardEdge,
                          spacing: AppLayout.p1,
                          runSpacing: AppLayout.p1,
                          children: [
                            ...widget.primaryMuscleGroups.map(
                              (primary) => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.colors.divider,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(AppLayout.cornerRadius),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppLayout.p3,
                                  vertical: AppLayout.p1,
                                ),
                                child: Text(
                                  primary.name,
                                  style:
                                      context.typography.labelMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (widget.secondaryMuscleGroups.isNotEmpty) ...[
                      const SizedBox(height: AppLayout.p4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: AppLayout.p2,
                                width: AppLayout.p2,
                                decoration: BoxDecoration(
                                  color: context.colors.pink.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppLayout.p1),
                              Text(
                                'Secondary',
                                style: context.typography.labelMedium.copyWith(
                                  color: context.colors.foregroundPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppLayout.p2),
                          Wrap(
                            clipBehavior: Clip.hardEdge,
                            spacing: AppLayout.p1,
                            runSpacing: AppLayout.p1,
                            children: [
                              ...widget.secondaryMuscleGroups.map(
                                (primary) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colors.divider,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppLayout.cornerRadius),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppLayout.p3,
                                    vertical: AppLayout.p1,
                                  ),
                                  child: Text(
                                    primary.name,
                                    style:
                                        context.typography.labelMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppLayout.p4),
          SegmentedController(
            selectedValue: _selectedValue,
            onValueChanged: _onSegmentedControllerValueChanged,
            items: const ['Front View', 'Back View'],
            small: true,
          ),
        ],
      ),
    );
  }
}
